
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
--Qry collisions
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
SELECT * FROM GADATA.C4G.CollisionInfo AS CI
WHERE
--datetime filter
(CI.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND 
--Robot name filter 
(CI.Robotname LIKE @RobotFilterWild)
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
--C4G Qry Breakdowns (begin van een storing)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C4G.BreakdownStart AS BS
WHERE 
--Datetime filter
 (BS.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND
(BS.Robotname LIKE @RobotFilterWild)
--Application / subgroup filter
AND
ISNULL(BS.[Object],'') LIKE @ApplFilterWild AND ISNULL(BS.Subgroup,'') LIKE @SubgroupFilterWild
AND
--Exclude Gatestops 
((@ExcludeGateStops = 1 AND (ISNULL(BS.subgroup,'') NOT LIKE '%Gate/Hold%')) OR @ExcludeGateStops =0)
AND
--enable bit
(@GetC4GDownTBegin = 1)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G Qry Systate 
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C4G.sysstate AS SS
WHERE 
--Datetime filter
 (SS.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND
(SS.Robotname LIKE @RobotFilterWild)
AND
--enable bit
(@GetC4GEvents = 1)
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
 (RespT.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND
--robot name filter 
(RespT.Robotname LIKE @RobotFilterWild)
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
 (RelvT.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND
--robot name filter 
(RelvT.Robotname LIKE @RobotFilterWild)
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

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G ACTION information (action log)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C4G.[ACTION] AS C4GA
WHERE
--datetime filter
(C4GA.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND 
--Robot name filter 
(C4GA.Robotname LIKE @RobotFilterWild)
--Application / subgroup filter
AND
ISNULL(C4GA.[Object],'') LIKE @ApplFilterWild AND ISNULL(C4GA.Subgroup,'') LIKE @SubgroupFilterWild
AND 
@GetC4GAction = 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G SPEED information (GEN OVR)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.c4g.gen_ovr AS C4GSPEED
WHERE
--datetime filter
(C4GSPEED.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND 
--Robot name filter 
(C4GSPEED.Robotname LIKE @RobotFilterWild)
AND 
@GetC4GSpeedCheck = 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G SPEED information (GEN OVR NOW not 100) (for live view)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.c4g.SLOWspeed AS C4GSlowSPEED
WHERE
--Robot name filter 
(C4GSlowSPEED.Robotname LIKE @RobotFilterWild)
AND 
@GetC4GLive = 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G modifications
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C4G.mod AS C4GM
WHERE
--datetime filter
(C4GM.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND 
--Robot name filter 
(C4GM.Robotname LIKE @RobotFilterWild)
AND 
@GetC4gMOD = 1
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G SBCU
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C4G.sbcu AS C4Gsbcu
WHERE
--datetime filter
(C4Gsbcu.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND 
--Robot name filter 
(C4Gsbcu.Robotname LIKE @RobotFilterWild)
AND 
@GetC4GSBCU = 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G liveview (action breakdowns)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.Volvo.L_liveView AS C4GLive
where
--Exclude Gatestops 
((@ExcludeGateStops = 1 AND ((C4GLive.logtekst NOT LIKE '%(SS)%') OR (C4GLive.logtekst NOT LIKE '%bla bla bla%') )) OR @ExcludeGateStops =0)
AND
--robot name filter 
(C4GLive.Robot LIKE @RobotFilterWild)
AND
@GetC4GLive = 1
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
---------------------------------------------------------------------------------------
--C3G Qry LIVE
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C3G.Live as Live
WHERE 
--robot name filter 
(Live.Robotname LIKE @RobotFilterWild)
--Application / subgroup filter
AND
ISNULL(Live.[Object],'') LIKE @ApplFilterWild AND ISNULL(Live.Subgroup,'') LIKE @SubgroupFilterWild
AND
--Exclude Gatestops 
((@ExcludeGateStops = 1 AND (LIVE.logtekst NOT LIKE '%(SS)%')) OR @ExcludeGateStops =0)
AND
--enable bit
(@GetC3GLive = 1)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C3G Qry Breakdowns (begin van een storing)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C3G.BreakdownStart AS BS
WHERE 
--Datetime filter
 (BS.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND
(BS.Robotname LIKE @RobotFilterWild)
--Application / subgroup filter
AND
ISNULL(BS.[Object],'') LIKE @ApplFilterWild AND ISNULL(BS.Subgroup,'') LIKE @SubgroupFilterWild
AND
--Exclude Gatestops 
((@ExcludeGateStops = 1 AND (ISNULL(BS.subgroup,'') NOT LIKE '%Gate/Hold%')) OR @ExcludeGateStops =0)
AND
--enable bit
(@GetC3GDownTBegin = 1)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C3G Qry Systate 
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C3G.sysstate AS SS
WHERE 
--Datetime filter
 (SS.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND
(SS.Robotname LIKE @RobotFilterWild)
AND
--enable bit
(@GetC3GEvents = 1)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C3G modifications
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C3G.mod AS C3GM
WHERE
--datetime filter
(C3GM.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND 
--Robot name filter 
(C3GM.Robotname LIKE @RobotFilterWild)
AND 
@GetC3gMOD = 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--SBCU data
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.c3g.SBCU AS C3GSBCU
WHERE
--datetime filter
(C3GSBCU.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND 
--Robot name filter 
(C3GSBCU.Robotname LIKE @RobotFilterWild)
AND 
@GetC3GSBCU = 1
---------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--ALERTS that are not accepted
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.Volvo.Alerts as a 
WHERE
a.Subgroup like '%WGK%'
AND
@GetC3gLive = 1

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--ALERTS 
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.Volvo.Alerts as a 
WHERE 
--datetime filter
(a.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND 
--Robot name filter 
(a.Robotname LIKE @RobotFilterWild)
AND
@GetAlerts = 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------

--***********************************************************************************************************************--
--ABBS4
--***********************************************************************************************************************--
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--ABB S4 error
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.ABB.S4error AS S4E
WHERE
--datetime filter
(S4E.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND 
--Robot name filter 
(S4E.Robotname LIKE @RobotFilterWild)
--Application / subgroup filter
AND
ISNULL(S4E.[Object],'') LIKE @ApplFilterWild AND ISNULL(S4E.Subgroup,'') LIKE @SubgroupFilterWild
AND
--Exclude Gatestops 
((@ExcludeGateStops = 1 AND (ISNULL(S4E.subgroup,'') NOT LIKE '%GateStop%')) OR @ExcludeGateStops =0)
AND 
@GetS4Error = 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--ABB S4 State
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.ABB.S4state AS S4S
WHERE
--datetime filter
(S4S.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND 
--Robot name filter 
(S4S.Robotname LIKE @RobotFilterWild)
AND 
@GetS4State = 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--ABB Qry Breakdowns (einde van storings met storings tijd)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.ABB.breakdown as B
WHERE 
--Datetime filter
 (B.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND
--robot name filter 
(B.Robotname LIKE @RobotFilterWild)
AND
--enable bit
(@GetABBDowntimes = 1)
---------------------------------------------------------------------------------------


--***********************************************************************************************************************--
--ABBIRC5
--***********************************************************************************************************************--
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--ABB IRC5 error
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.ABB.IRC5error AS IRC5E
WHERE
--datetime filter
(IRC5E.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND 
--Robot name filter 
(IRC5E.Robotname LIKE @RobotFilterWild)
--Application / subgroup filter
AND
ISNULL(IRC5E.[Object],'') LIKE @ApplFilterWild AND ISNULL(IRC5E.Subgroup,'') LIKE @SubgroupFilterWild
AND 
--Exclude Gatestops 
((@ExcludeGateStops = 1 AND (ISNULL(IRC5E.subgroup,'') NOT LIKE '%GateStop%')) OR @ExcludeGateStops =0)
AND
@GetIRC5Error = 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--ABB S4 State
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.ABB.IRC5state AS IRC5S
WHERE
--datetime filter
(IRC5S.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND 
--Robot name filter 
(IRC5S.Robotname LIKE @RobotFilterWild)
AND 
@GetIRC5State = 1
---------------------------------------------------------------------------------------
--***********************************************************************************************************************--
--WeldTimer
--***********************************************************************************************************************--
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Bosch weld timer errorlog 
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

UNION
SELECT * FROM GADATA.Volvo.TimerError AS TE
WHERE
--datetime filter
(TE.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND 
--Robot name filter 
(TE.Robotname LIKE @RobotFilterWild)
AND 
@GetTimerError = 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Bosch weld timer Datechange log  
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

UNION
SELECT * FROM GADATA.Volvo.TimerDataChange AS TDC
WHERE
--datetime filter
(TDC.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND 
--Robot name filter 
(TDC.Robotname LIKE @RobotFilterWild)
AND 
@GetTimerData = 1
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

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--system info
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
--HeartBeats
SELECT * FROM GADATA.Volvo.vcscinfo 
WHERE
(@getc3glive =1 OR @GetC4GLive = 1)
UNION
--All L_operation messages
SELECT * FROM GADATA.Volvo.vcscmessages
WHERE 
(vcscmessages.[timestamp] BETWEEN @StartDate AND @EndDate)
AND
(@ServerMessages = 1)

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--shiftbook
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
--
SELECT * FROM GADATA.Volvo.Shiftbook as sb
WHERE
(sb.timestamp BETWEEN @startdate AND @EndDate)
AND
sb.Robotname LIKE @RobotFilterWild
AND
sb.Location LIKE @LocationFilterWild
AND
GADATA.volvo.fn_getuserlevel(@user ) > 0
AND
@shiftbook = 1
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