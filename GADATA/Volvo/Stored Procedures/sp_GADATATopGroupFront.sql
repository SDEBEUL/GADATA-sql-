



CREATE PROCEDURE [Volvo].[sp_GADATATopGroupFront]
--timeparameters
   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @Ndays as int = null,
--BooleanParms
   @ExcludeGateStops as bit = 0,
--Filterparameters.
   @RobotFilterWild as varchar(10) = '%',
   @LocationFilterWild as varchar(20) = '%',
   @ApplFilterWild as varchar(20) = '%', 
   @SubgroupFilterWild as varchar(20) = '%', 
--COMAU C4G booleans
   @GetC4Gerror as bit = 1,
   @GetC4GDowntimes as bit = 1,
--Comau C3G Booleans   
   @GetC3GError as bit = 1,
   @GetC3GDowntimes as bit = 0,  
--optional pars
   @MinLogserv as int = 0,
   @MinDowntime as int = 0 ,
   @UsePloeg as bit = 0,
   @UseOwnership as bit = 0
--gives the right permission when a low level user only has execution rights
with execute as owner
AS
BEGIN
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

--output ! 
SELECT
 GADATA.volvo.fn_useOwnership(output.Location, output.Robotname, @UseOwnership) AS 'Location' 
,output.Location		AS 'Robotname'
,MAX(CONVERT(char(19),output.timestamp, 120)) AS 'timestamp'
,count(output.Logcode)		As 'ErrorCount'
,count(output.downtime)     As 'Linestops'
,SUM(output.downtime)		AS 'Downtime'
,output.object			AS 'Object'
FROM
(

--***********************************************************************************************************************--
--COMAU C4G
--***********************************************************************************************************************-
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G Qry Breakdowns (einde van storings met storings tijd)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
SELECT * FROM GADATA.C4G.RsBreakdown as B
WHERE 
--Datetime filter
 (B.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND
--robot name filter 
(B.Robotname LIKE @RobotFilterWild)
--Location Filter
AND
(ISNULL(B.location,'') LIKE @LocationFilterWild )
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
SELECT * FROM GADATA.C4G.Error AS C4GE
WHERE 
--datetime filter
(C4GE.[Timestamp] BETWEEN @StartDate AND @EndDate)
AND 
--Robot name filter 
(C4GE.Robotname LIKE @RobotFilterWild)
--Location Filter
AND
(ISNULL(C4GE.location,'') LIKE @LocationFilterWild )
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
SELECT * FROM GADATA.C3G.Error AS C3GE

WHERE
--date time filter
(C3GE.[timestamp] BETWEEN @StartDate AND @EndDate)
AND
--robot name filter  
(C3GE.RobotName LIKE @RobotFilterWild)
--Location Filter
AND
(ISNULL(C3GE.location,'') LIKE @LocationFilterWild ) 
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
SELECT * FROM GADATA.C3G.Breakdown as B
WHERE 
--Datetime filter
 (B.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND
--robot name filter 
(B.Robotname LIKE @RobotFilterWild)
--Location Filter
AND
(ISNULL(B.location,'') LIKE @LocationFilterWild )
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
) as output

--***********************************************************************************************************************--
--Grouping 
GROUP BY  
output.Location, output.Robotname, output.Object
--***********************************************************************************************************************--


--***********************************************************************************************************************--
ORDER BY Linestops DESC 
--***********************************************************************************************************************--
END
GO
GRANT EXECUTE
    ON OBJECT::[Volvo].[sp_GADATATopGroupFront] TO [db_frontendUser]
    AS [GADATA];

