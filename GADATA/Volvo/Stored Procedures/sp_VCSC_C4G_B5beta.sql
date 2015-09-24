
CREATE PROCEDURE [Volvo].[sp_VCSC_C4G_B5beta]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @Daysback as int = 1,
   @RobotFilterWild as varchar(10) = '%',
   @RobotFilterMaskStart as varchar(10) = '%',
   @RobotFilterMaskEnd as varchar(10) = '99999R99%',
   @LocationFilterWild as varchar(20) = '%',

   @GetC4GAction as bit = 1,
   @GetC4Gerror as bit = 1,
   @GetC4GEvents as bit = 0, --removed in this version
   @GetC4GDowntimes as bit = 1,
   @GetC4GDownTBegin as bit = 1,
   @GetC4GCollisions as bit = 0,
   @GetC4GSpeedCheck as bit = 0, --removed in this version
   @GetC3GError as bit = 1,
   @GetModification as bit = 0, --removed in this version 
   @RespT as bit = 1,
   @RelvT as bit =1,
   @Timeline as bit = 1,

   @ExcludeGateStops as bit = 0,
   @MinLogserv as int = 0
AS
BEGIN


---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------


--template ! 
/*
SELECT        
  'P4_sibo_framing'		AS 'Location'
, '99999R01'			AS 'Robotname'
, 'C3G'					AS 'Type'
, 'ERROR'				AS 'Errortype'
, getdate()				AS 'timestamp'
, 4600					AS 'Logcode'
, 16					AS 'Severity'
, 'bla bla bla bla'		AS 'Logtekst'
, NULL					AS 'Downtime'
, T.Vyear				AS 'Year'
, T.Vweek				AS 'Week'
, T.Vday				AS 'day'
, T.shift				AS 'Shift'
, 'Template'			AS 'Object'
, 'Template				AS 'Subgroup'
, CAST(1 AS int)		AS 'idx'
*/

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Timeline
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
SELECT 
T.Location
,T.Robotname
,T.[Type]
,T.Errortype
,T.[Timestamp]
,T.Logcode
,T.Severity
,T.Logtekst
,T.DOWNTIME
,T.[Year]
,T.[Week]
,T.[day]
,T.ploeg as 'shift'
,T.[Object]
,T.Subgroup
,T.id as 'idx'
FROM GADATA.Volvo.Timeline AS T
WHERE
--datetime filter
(T.[Timestamp]  BETWEEN ISNULL(@StartDate,GETDATE()-@daysback) AND ISNULL(@EndDate,GETDATE())) 
AND 
--Enable bit
(@Timeline = 1)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Qry collisions
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C4G.CollisionInfo AS CI
WHERE
--datetime filter
(CI.[Timestamp]  BETWEEN ISNULL(@StartDate,GETDATE()-@daysback) AND ISNULL(@EndDate,GETDATE())) 
AND 
--Robot name filter 
(CI.Robotname BETWEEN    @RobotFilterMaskStart AND @RobotFilterMaskEnd)
AND  
(CI.Robotname LIKE @RobotFilterWild)
--Location Filter
AND
(ISNULL(CI.location,'') LIKE @LocationFilterWild )
AND
--Enable bit
(@GetC4GCollisions = 1)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G Qry Breakdowns (einde van storings met storings tijd)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C4G.RsBreakdown as B
WHERE 
--Datetime filter
 B.[Timestamp]  BETWEEN ISNULL(@StartDate,GETDATE()-@daysback) AND ISNULL(@EndDate,GETDATE())
AND
--robot name filter 
((B.Robotname BETWEEN @RobotFilterMaskStart AND @RobotFilterMaskEnd))
AND
(B.Robotname LIKE @RobotFilterWild)
--Location Filter
AND
(ISNULL(B.location,'') LIKE @LocationFilterWild )
AND
--Exclude Gatestops 
((@ExcludeGateStops = 1 AND (ISNULL(B.subgroup,'') NOT LIKE '%Gate/Hold%')) OR @ExcludeGateStops =0)
AND
--enable bit
(@GetC4GDowntimes = 1)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G Qry Breakdowns (begin van een storing)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C4G.BreakdownStart AS BS
WHERE 
--Datetime filter
 BS.[Timestamp]  BETWEEN ISNULL(@StartDate,GETDATE()-@daysback) AND ISNULL(@EndDate,GETDATE())
AND
--robot name filter 
((BS.Robotname BETWEEN @RobotFilterMaskStart AND @RobotFilterMaskEnd))
AND
(BS.Robotname LIKE @RobotFilterWild)
--Location Filter
AND
(ISNULL(BS.location,'') LIKE @LocationFilterWild )
AND
--Exclude Gatestops 
((@ExcludeGateStops = 1 AND (ISNULL(BS.subgroup,'') NOT LIKE '%Gate/Hold%')) OR @ExcludeGateStops =0)
AND
--enable bit
(@GetC4GDownTBegin = 1)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G Qry RespTime (snelheid van de operator om te reageren)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C4G.RespTime AS RespT
WHERE 
--Datetime filter
 RespT.[Timestamp]  BETWEEN ISNULL(@StartDate,GETDATE()-@daysback) AND ISNULL(@EndDate,GETDATE())
AND
--robot name filter 
((RespT.Robotname BETWEEN @RobotFilterMaskStart AND @RobotFilterMaskEnd))
AND
(RespT.Robotname LIKE @RobotFilterWild)
--Location Filter
AND
(ISNULL(RespT.location,'') LIKE @LocationFilterWild )
--enable bit
And 
@RespT = 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G Qry ResolveTime (snelheid om storing op te lossen)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C4G.ResolveTime AS RelvT
WHERE 
--Datetime filter
 RelvT.[Timestamp]  BETWEEN ISNULL(@StartDate,GETDATE()-@daysback) AND ISNULL(@EndDate,GETDATE())
AND
--robot name filter 
((RelvT.Robotname BETWEEN @RobotFilterMaskStart AND @RobotFilterMaskEnd))
AND
(RelvT.Robotname LIKE @RobotFilterWild)
--Location Filter
AND
(ISNULL(RelvT.location,'') LIKE @LocationFilterWild )
--enable bit
And 
@RelvT = 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G Alarm information (error log)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C4G.Error AS C4GE
WHERE 
--datetime filter
(C4GE.[Timestamp]  BETWEEN ISNULL(@StartDate,GETDATE()-@daysback) AND ISNULL(@EndDate,GETDATE())) 
AND 
--Robot name filter 
(C4GE.Robotname BETWEEN    @RobotFilterMaskStart AND @RobotFilterMaskEnd)
AND  
(C4GE.Robotname LIKE @RobotFilterWild)
--Location Filter
AND
(ISNULL(C4GE.location,'') LIKE @LocationFilterWild )
AND
 --Exclude Gatestops 
(
(@ExcludeGateStops = 1 AND (ISNULL(C4GE.subgroup,'') NOT LIKE '%Gate/Hold%')) 
OR 
@ExcludeGateStops =0
)
--minimum log serverity
AND
(C4GE.Severity  > (@MinLogserv-1))
--Enable bit 
AND
(@GetC4Gerror = 1)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G ACTION information (action log)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C4G.[ACTION] AS C4GA
WHERE
--datetime filter
(C4GA.[Timestamp]  BETWEEN ISNULL(@StartDate,GETDATE()-@daysback) AND ISNULL(@EndDate,GETDATE())) 
AND 
--Robot name filter 
(C4GA.Robotname BETWEEN    @RobotFilterMaskStart AND @RobotFilterMaskEnd)
AND  
(C4GA.Robotname LIKE @RobotFilterWild)
--Location Filter
AND
(ISNULL(C4GA.location,'') LIKE @LocationFilterWild )
AND 
@GetC4GAction = 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C3G Alarm information (error log)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C3G.Error AS C3GE

WHERE
--date time filter
C3GE.[timestamp] BETWEEN ISNULL(@StartDate,GETDATE()-@daysback) AND ISNULL(@EndDate,GETDATE())
AND
--robot name filter 
(C3GE.RobotName BETWEEN    @RobotFilterMaskStart AND @RobotFilterMaskEnd )
AND  
(C3GE.RobotName LIKE @RobotFilterWild)
--Location Filter
AND
(ISNULL(C3GE.location,'') LIKE @LocationFilterWild ) 
AND
 --Exclude Gatestops 
(
(@ExcludeGateStops = 1 AND (ISNULL(C3GE.subgroup,'') NOT LIKE '%Gate/Hold%')) 
OR 
@ExcludeGateStops =0
)
--minimum log serverity
AND
(C3GE.Severity  > (@MinLogserv-1))
--enable bit
AND
@GetC3GError = 1

---------------------------------------------------------------------------------------
ORDER BY [Timestamp] DESC --robotname,

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Activity log (logs the execution of the Query to a table)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
DECLARE @rowcountmen as int 
SET @rowcountmen = @@rowcount
DECLARE @RequestString as varchar(255)
SET @RequestString =
   CONCAT(
   '[Volvo].[sp_VCSC_C4G_B5beta]',
   ' @StartDate = " '						, @StartDate
     ,' "  ,@EndDate = " '					, @EndDate
     ,' "  ,@RobotFilterWild = " '			, @RobotFilterWild
     ,' "  ,@RobotFilterMaskStart = " '		, @RobotFilterMaskStart
     ,' "  ,@RobotFilterMaskEnd = " '		, @RobotFilterMaskEnd
     ,' "  ,@LocationFilterWild = " '		, @LocationFilterWild 
     ,' "  ,@GetC4GAction = " '				, @GetC4GAction   
     ,' "  ,@GetC4Gerror = " '				, @GetC4Gerror 
     ,' "  ,@GetC4GEvents = " '				, @GetC4GEvents 
     ,' "  ,@GetC4GDowntimes = " '			, @GetC4GDowntimes  
     ,' "  ,@GetC4GDownTBegin = " '			, @GetC4GDownTBegin  
     ,' "  ,@GetC3GError = " '				, @GetC3GError 
     ,' "  ,@ExcludeGateStops = " '			, @ExcludeGateStops  
     ,' "  ,@MinLogserv = " '				, @MinLogserv ,' "'
	)
EXEC GADATA.volvo.sp_Alog  @rowcount = @rowcountmen, @Request = @RequestString

END