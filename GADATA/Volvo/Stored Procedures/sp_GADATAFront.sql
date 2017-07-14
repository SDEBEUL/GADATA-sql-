
CREATE PROCEDURE [Volvo].[sp_GADATAFront]
--timeparameters
   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @Ndays as int = null,
--BooleanParms
   @Timeline as bit = 1,
   @ExcludeGateStops as bit = 0,
--Filterparameters.
   @RobotFilterWild as varchar(10) = '%',
   @LocationFilterWild as varchar(20) = '%',
   @ApplFilterWild as varchar(20) = '%', 
   @SubgroupFilterWild as varchar(20) = '%', 
--COMAU C4G booleans
   @GetC4GAction as bit = 0,
   @GetC4Gerror as bit = 1,
   @GetC4GEvents as bit = 0, 
   @GetC4GDowntimes as bit = 1,
   @GetC4GDownTBegin as bit = 0,
   @GetC4GCollisions as bit = 0,
   @GetC4GSpeedCheck as bit = 0,
   @GetC4GSBCU as bit = 0, 
   @GetC4GMod as bit = 0,
   @GetC4GLive as bit = 0,
--Comau C3G Booleans   
   @GetC3GError as bit = 1,
   @GetC3GEvents as bit = 0, 
   @GetC3GDowntimes as bit = 0, 
   @GetC3GDownTBegin as bit = 0, 
   @GetC3GSpeedCheck as bit = 0, 
   @GetC3GSBCU as bit = 0, 
   @GetC3GMod as bit = 0,
   @GetC3gLive as bit = 0, 
--ABB S4C Booleans
   @GetS4Error as bit = 0,
   @GetS4State as bit = 0,
   @GetABBDowntimes as bit = 0,
--ABB IRC5 Booleans 
   @GetIRC5Error as bit = 0,
   @GetIRC5State as bit = 0,
--ARO weldTImer Boolean 
   @GetTimerData as bit = 0,
   @GetTimerError as bit = 0,
   @GetTimerWear as bit =0, --tbt
--blocked pars 
   @RespT as bit = 0, 
   @RelvT as bit =0,
--optional pars
   @MinLogserv as int = 0,
   @MinDowntime as int = 0 ,
   @UsePloeg as bit = 0,
   @UseOwnership as bit = 0,
   @ServerMessages as bit = 0,
   @GetAlerts as bit = 0,
   @USER as varchar(20) = null,
   @Shiftbook as bit = 0 
--gives the right permission when a low level user only has execution rights
with execute as owner
AS
BEGIN

--RAISERROR (15600,-1,-1, '*******Im sorry Working on it .....********(SDEBEUL)');

---------------------------------------------------------------------------------------
--Kindly responde to user if using unfinished stuff
---------------------------------------------------------------------------------------
IF  (@GetTimerWear =1 )
--BEGIN
RAISERROR (15600,-1,-1, 'Im sorry ... Have not got this implemented (SDEBEUL)');
--END

---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--Set default values of start and end date
---------------------------------------------------------------------------------------
if ((@StartDate is null) OR (@StartDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @StartDate = GETDATE()-'1900-01-01 12:00:00'
END

if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()
END

--for days back mode
if (@ndays is not null)
BEGIN
SET @StartDate = GETDATE() - @ndays
END 

--template ! 
SELECT
  GADATA.volvo.fn_useOwnership(output.Location, output.Robotname, @UseOwnership) AS 'Location' 
, output.robotname		AS 'Robotname'
, output.type			AS 'Type'
, output.errortype		AS 'Errortype'
, CONVERT(char(19),output.timestamp, 120) AS 'timestamp'
, output.logcode		AS 'Logcode'
, output.severity		AS 'Severity'
, output.logtekst		AS 'Logtekst'
, output.downtime		AS 'Downtime'
, output.year			AS 'Year'
, output.week			AS 'Week'
, output.day			AS 'day'
, GADATA.volvo.fn_usePloeg(output.shift, output.Timestamp, @UsePloeg) AS 'Shift'
, output.object			AS 'Object'
, output.Subgroup		AS 'Subgroup'
, output.idx		    AS 'idx'
FROM
(

--***********************************************************************************************************************--
--COMAU C4G
--***********************************************************************************************************************--

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G Qry Breakdowns (einde van storings met storings tijd)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
SELECT * FROM GADATA.C4G.OLD_breakdown as B
WHERE 
--Datetime filter
 (B.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND
--robot name filter 
(B.Robotname LIKE @RobotFilterWild)
--Application / subgroup filter
AND
ISNULL(B.[Object],'') LIKE @ApplFilterWild AND ISNULL(B.Subgroup,'') LIKE @SubgroupFilterWild
AND
--Exclude Gatestops 
((@ExcludeGateStops = 1 AND (ISNULL(B.subgroup,'') NOT LIKE '%Gate/Hold%')) OR @ExcludeGateStops =0)
AND
--minimun downtime option
(@MinDowntime <= B.Downtime)
AND
--enable bit
(@GetC4GDowntimes = 1)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G Alarm information (error log)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C4G.old_error AS C4GE
WHERE 
--datetime filter
(C4GE.[Timestamp] BETWEEN @StartDate AND @EndDate)
AND 
--Robot name filter 
(C4GE.Robotname LIKE @RobotFilterWild)
--Application / subgroup filter
AND
ISNULL(C4GE.[Object],'') LIKE @ApplFilterWild AND ISNULL(C4GE.Subgroup,'') LIKE @SubgroupFilterWild
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


--***********************************************************************************************************************--
--COMAU C3G
--***********************************************************************************************************************--

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C3G Alarm information (error log)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C3G.old_error AS C3GE

WHERE
--date time filter
(C3GE.[timestamp] BETWEEN @StartDate AND @EndDate)
AND
--robot name filter  
(C3GE.RobotName LIKE @RobotFilterWild)
--Application / subgroup filter
AND
ISNULL(C3GE.[Object],'') LIKE @ApplFilterWild AND ISNULL(C3GE.Subgroup,'') LIKE @SubgroupFilterWild
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
---------------------------------------------------------------------------------------
--C3G Qry Breakdowns (einde van storings met storings tijd)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C3G.OLD_Breakdown as B
WHERE 
--Datetime filter
 (B.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND
--robot name filter 
(B.Robotname LIKE @RobotFilterWild)
--Application / subgroup filter
AND
ISNULL(B.[Object],'') LIKE @ApplFilterWild AND ISNULL(B.Subgroup,'') LIKE @SubgroupFilterWild
AND
--Exclude Gatestops 
((@ExcludeGateStops = 1 AND (B.logtekst NOT LIKE '%(SS)%')) OR @ExcludeGateStops =0)
AND
--minimun downtime option
(@MinDowntime <= B.Downtime)
AND
--enable bit
(@GetC3GDowntimes = 1)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------

) as output

WHERE
--***********************************************************************************************************************--
--Location Filter (with an option to filter by ownership ... Will clean this up when I find my mojo)
GADATA.volvo.fn_useOwnership(output.Location, output.Robotname, @UseOwnership) LIKE @LocationFilterWild
--***********************************************************************************************************************--


--***********************************************************************************************************************--
--COMMON PART (does not get filterd)
--***********************************************************************************************************************--
UNION
SELECT
  output.Robotname AS 'Location' 
, output.robotname		AS 'Robotname'
, output.type			AS 'Type'
, output.errortype		AS 'Errortype'
, CONVERT(char(19),output.timestamp, 120) AS 'timestamp'
, output.logcode		AS 'Logcode'
, output.severity		AS 'Severity'
, output.logtekst		AS 'Logtekst'
, output.downtime		AS 'Downtime'
, output.year			AS 'Year'
, output.week			AS 'Week'
, output.day			AS 'day'
, GADATA.volvo.fn_usePloeg(output.shift, output.Timestamp, @UsePloeg) AS 'Shift'
, output.object			AS 'Object'
, output.Subgroup		AS 'Subgroup'
, output.idx		    AS 'idx'
FROM
(
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
,T.[Shift] as 'shift'
,T.[Object]
,T.Subgroup
,T.id as 'idx'
FROM GADATA.Volvo.Timeline AS T
WHERE
--datetime filter
(T.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND 
--Enable bit
(@Timeline = 1)
---------------------------------------------------------------------------------------

) as output
--***********************************************************************************************************************--

--***********************************************************************************************************************--
ORDER BY [Timestamp] DESC 
--***********************************************************************************************************************--

--***********************************************************************************************************************--
--Datalog
--***********************************************************************************************************************--

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
   'Running: [Volvo].[sp_GADATAFront]',
   ' @StartDate = " '						, @StartDate
     ,' "  ,@EndDate = " '					, @EndDate
     ,' "  ,@RobotFilterWild = " '			, @RobotFilterWild
     ,' "  ,@LocationFilterWild = " '		, @LocationFilterWild
	 ,' "  ,@GetC4gLive = " '				, @GetC4gLive 
     ,' "  ,@GetC3gLive = " '				, @GetC3gLive ,' "'
	)
EXEC GADATA.volvo.sp_Alog @rowcount = @rowcountmen, @Request = @RequestString

END