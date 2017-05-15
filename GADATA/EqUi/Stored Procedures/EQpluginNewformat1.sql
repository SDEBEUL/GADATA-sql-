


CREATE PROCEDURE [EqUi].[EQpluginNewformat1]

--default parameters
--timeparameters
	   @StartDate as DATETIME = null,
	   @EndDate as DATETIME = null,
	   @daysBack as int = null,
	--Filterparameters.
	   @assets as varchar(10) = '%',
	   @locations as varchar(20) = '%',
	   @lochierarchy as varchar(20) = '%', 
	--non default parm
   @timeline as bit =1,
   @ExcludeOperational as bit =1,
   @c3gError as bit = 1,
   @c4gError as bit = 1,
   @c3gBreakdown as bit = 1,
   @c4gBreakdown as bit  = 1,
   @c3gSysState as bit = 0,
   @c4gSysState as bit = 0,
   @c3gMOD as bit = 0,
   @c4gMOD as bit = 0,
   @c3gSBCU as bit = 0,
   @abbIRC5Error as bit = 0,
   @abbIRC5State as bit = 0,
   @abbS4Error as bit = 0,
   @abbS4State as bit = 0,
   @getshiftbook as bit = 0,
   @active as bit = 0,
   @stw040 as bit = 0,
   @MinLogserv as int = 0,
   @MinDowntime as int = 0

--gives the right permission when a low level user only has execution rights
--with execute as owner
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
if (@daysBack is not null)
BEGIN
SET @StartDate = GETDATE() - @daysBack
SET @EndDate = GETDATE()
END 
---------------------------------------------------------------------------------------
--template ! 
SELECT
--asset
  output.Location       AS 'Location' 
, output.AssetID		as 'AssetID'
--log part
, output.Logtype		AS 'Logtype'
, output.Logcode		AS 'Logcode'
, output.Severity		AS 'Severity'
, output.logtext		AS 'logtext'
, output.Response/60		AS 'Response(min)'
, output.Downtime/60		AS 'Downtime(min)'
--date time part
, CONVERT(char(19),output.timestamp, 120) AS 'timestamp' --cast to timeformat excel likes 
, CONVERT(char(19),output.[timestamp], 108) AS 'time' 
, timeline.Vyear		     AS 'Year'
, timeline.Vweek		     AS 'Week'
, timeline.Vday		     AS 'Day'
, timeline.[shift]           AS 'Shift'
, timeline.PLOEG		     As 'Ploeg'
--classifcation part
, output.Classification	AS 'Classification'
, output.Subgroup		AS 'Subgroup'
--Part reference  part 
, null					As 'PartRef'
, null					As 'ProcessRef'
--extra 
, output.refId		    AS 'refId'
, output.LocationTree   As 'LocationTree'
, output.ClassTree		As 'ClassTree'
, output.controller_name  as 'controller_name'
, output.controller_type as 'controller_type'
FROM
(
--*******************************************************************************************************--
--timeline
--*******************************************************************************************************--
SELECT 
 'TIMELINE' AS 'Location' 
,'TIMELINE'	AS 'AssetID'
,'TIMELINE' AS 'Logtype'
, T.starttime + '1900-01-01 00:00:01' AS 'timestamp' --add 1s because else dubble match on join with weeknumbers
, Null      AS 'Logcode'
, Null      AS 'Severity'
, 'Begin of Shift: ' + T.[shift] + '  Ploeg:'+ T.PLOEG       AS 'logtext'
, NULL      AS 'Response'
, NULL      AS 'Downtime'
, 'TIMELINE'		AS 'Classification'
, 'TIMELINE'		AS 'Subgroup'
, NULL		AS 'refId'
, NULL		As 'LocationTree'
, NULL		AS 'ClassTree'
, NULL		AS 'controller_name'
, NULL		As 'controller_type'

FROM  Volvo.L_timeline as T 
where 
T.starttime BETWEEN @StartDate AND @EndDate
AND
@timeline = 1
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--c3g error
--*******************************************************************************************************--
SELECT * from GADATA.EqUi.c3g_error
where 
--Asset Filters
isnull(c3g_error.AssetID,'%') like @assets
and 
isnull(c3g_error.LOCATION,c3g_error.controller_name) like @locations
and
c3g_error.controller_name like @locations
and
isnull(c3g_error.LocationTree,'%') like @lochierarchy
--Time Filter
and
c3g_error.[timestamp] BETWEEN @StartDate AND @EndDate
and
@MinLogserv <= c3g_error.Severity
and
@c3gError = 1
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--c4g error
--*******************************************************************************************************--
select * from GADATA.EqUi.c4g_error
where 
--Asset Filters
isnull(c4g_error.AssetID,'%') like @assets
and 
isnull(c4g_error.LOCATION,c4g_error.controller_name) like @locations
and
c4g_error.controller_name like @locations
and
isnull(c4g_error.LocationTree,'%') like @lochierarchy
--Time Filter
and
c4g_error.[timestamp] BETWEEN @StartDate AND @EndDate
and
@MinLogserv <= c4g_error.Severity
and
@c4gError = 1
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--c3g breakdown
--*******************************************************************************************************--
select * from GADATA.EqUi.c3g_breakdown
where 
--Asset Filters
isnull(c3g_breakdown.AssetID,'%') like @assets
and 
isnull(c3g_breakdown.LOCATION,c3g_breakdown.controller_name) like @locations
and
c3g_breakdown.controller_name like @locations
and
isnull(c3g_breakdown.LocationTree,'%') like @lochierarchy
--Time Filter
and
c3g_breakdown.[timestamp] BETWEEN @StartDate AND @EndDate
and 
@MinDowntime*60 <= c3g_breakdown.[Downtime(s)] 
and
@c3gBreakdown = 1
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--c4g breakdown
--*******************************************************************************************************--
SELECT * from GADATA.EqUi.c4g_breakdown
where 
--Asset Filters
isnull(c4g_breakdown.assetid,'%') like @assets
and 
isnull(c4g_breakdown.LOCATION,c4g_breakdown.controller_name) like @locations
and
c4g_breakdown.controller_name like @locations
and
isnull(c4g_breakdown.LocationTree,'%') like @lochierarchy
--Time Filter
and
c4g_breakdown.[timestamp] BETWEEN @StartDate AND @EndDate
and 
@MinDowntime*60 <= c4g_breakdown.[Downtime(s)] 
and
@c4gBreakdown = 1
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--ABB IRC5 Error
--*******************************************************************************************************--
SELECT * from GADATA.abb.IRC5error
where 
--Asset Filters
isnull(IRC5error.assetid,'%') like @assets
and 
isnull(IRC5error.LOCATION,IRC5error.controller_name) like @locations
and
IRC5error.controller_name like @locations
and
isnull(IRC5error.LocationTree,'%') like @lochierarchy
--Time Filter
and
IRC5error.[timestamp] BETWEEN @StartDate AND @EndDate
and
@abbIRC5Error = 1
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--ABB IRC5 State
--*******************************************************************************************************--
SELECT * from GADATA.abb.IRC5State
where 
--Asset Filters
isnull(IRC5State.assetid,'%') like @assets
and 
isnull(IRC5State.LOCATION,IRC5State.controller_name) like @locations
and
IRC5State.controller_name like @locations
and
isnull(IRC5State.LocationTree,'%') like @lochierarchy
--Time Filter
and
IRC5State.[timestamp] BETWEEN @StartDate AND @EndDate
and
@abbIRC5State = 1
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--ABB S4 Error
--*******************************************************************************************************--
SELECT * from GADATA.abb.S4error
where 
--Asset Filters
isnull(S4error.assetid,'%') like @assets
and 
isnull(S4error.LOCATION,S4error.controller_name) like @locations
and
S4error.controller_name like @locations
and
isnull(S4error.LocationTree,'%') like @lochierarchy
--Time Filter
and
S4error.[timestamp] BETWEEN @StartDate AND @EndDate
and
@abbS4Error = 1
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--ABB S4 State
--*******************************************************************************************************--
SELECT * from GADATA.abb.S4State
where 
--Asset Filters
isnull(S4State.assetid,'%') like @assets
and 
isnull(S4State.LOCATION,S4State.controller_name) like @locations
and
S4State.controller_name like @locations
and
isnull(S4State.LocationTree,'%') like @lochierarchy
--Time Filter
and
S4State.[timestamp] BETWEEN @StartDate AND @EndDate
and
@abbS4State = 1
--*******************************************************************************************************--

UNION
--*******************************************************************************************************--
--stw040
--*******************************************************************************************************--
SELECT * from GADATA.EqUi.stw040
where 
--Asset Filters
isnull(stw040.assetid,'%') like @assets
and 
isnull(stw040.LOCATION,stw040.controller_name) like @locations
and
stw040.controller_name like @locations
and
isnull(stw040.LocationTree,'%') like @lochierarchy
--Time Filter
and
stw040.[timestamp] BETWEEN @StartDate AND @EndDate
and
@stw040 = 1
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--c3g SysState
--*******************************************************************************************************--
SELECT * from gadata.c3g.sysstate
where 
--Asset Filters
sysstate.AssetID like @assets
and 
sysstate.LOCATION like @locations
and
sysstate.LocationTree like @lochierarchy
--Time Filter
and
sysstate.timestamp BETWEEN @StartDate AND @EndDate
and
@c3gSysState = 1
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--c4g SysState
--*******************************************************************************************************--
SELECT * from gadata.c4g.sysstate
where 
--Asset Filters
sysstate.AssetID like @assets
and 
sysstate.LOCATION like @locations
and
sysstate.LocationTree like @lochierarchy
--Time Filter
and
sysstate.timestamp BETWEEN @StartDate AND @EndDate
and
@c4gSysState = 1

--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--c4g MOD
--*******************************************************************************************************--
SELECT * from gadata.c4g.[MOD]
where 
--Asset Filters
[MOD].AssetID like @assets
and 
[MOD].LOCATION like @locations
and
[MOD].LocationTree like @lochierarchy
--Time Filter
and
[MOD].timestamp BETWEEN @StartDate AND @EndDate
and
@c4gMOD = 1
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--c3g MOD
--*******************************************************************************************************--
SELECT * from gadata.c3g.[MOD]
where 
--Asset Filters
[MOD].AssetID like @assets
and 
[MOD].LOCATION like @locations
and
[MOD].LocationTree like @lochierarchy
--Time Filter
and
[MOD].timestamp BETWEEN @StartDate AND @EndDate
and
@c3gMOD = 1
--*******************************************************************************************************--
UNION


--*******************************************************************************************************--
--c3g SBCU
--*******************************************************************************************************--
select * from gadata.c3g.sbcu
where 
--Asset Filters
sbcu.AssetID like @assets
and 
sbcu.LOCATION like @locations
and
sbcu.LocationTree like @lochierarchy
--Time Filter
and
sbcu.[timestamp] BETWEEN @StartDate AND @EndDate
and
@c3gSBCU = 1
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--Shiftbook TEMP
--*******************************************************************************************************--
SELECT
  L.robotname	     AS 'Location' 
, Null AS 'AssetID'
,'SHIFTBOOK' AS 'Logtype'
, L.timestamp AS 'timestamp'
, Null      AS 'Logcode'
, Null      AS 'Severity'
, L.logtekst AS 'Logtekst'
, NULL      AS 'Response'
, NULL      AS 'Downtime'
, NULL		AS 'Classification'
, l.subgroup		AS 'Subgroup'
, l.idx		AS 'refId'
, NULL		As 'LocationTree'
, NULL		AS 'ClassTree'
, NULL		AS 'controller_name'
, NULL		As 'controller_type'

FROM GADATa.VOLVO.[Shiftbook] as l 
where 
L.timestamp BETWEEN @StartDate AND @EndDate
AND
@getshiftbook = 1
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--supervisie
--*******************************************************************************************************--
SELECT
  L.[Robot]	     AS 'Location' 
, Null AS 'AssetID'
, L.Errortype AS 'Logtype'
, L.timestamp AS 'timestamp'
, Null      AS 'Logcode'
, Null      AS 'Severity'
, L.logtekst AS 'Logtekst'
, NULL      AS 'Response'
, l.DT*60      AS 'Downtime'
, l.Object		AS 'Classification'
, l.subgroup		AS 'Subgroup'
, l.id		AS 'refId'
, NULL		As 'LocationTree'
, NULL		AS 'ClassTree'
, NULL		AS 'controller_name'
, NULL		As 'controller_type'

FROM GADATA.volvo.L_liveView as l 
where @active = 1 
and
l.robot not like 'ABB%'
and
--filter out some crap states 
l.Logtekst not in (
 'S: Run   |T: Run '
,'S: Alarm (SS) H   |T: Safety gate'
,'S: Alarm (SS) H   |T: HOLD from fieldbus'
,'S: Ready Alarm (SS) H   |T: Safety gate'
,'S: Ready Alarm (SS) H   |T: HOLD from fieldbus'
,'S: Ready H   |T: Ready H '
,'S: Ready   |T: Ready '
,'S: H   |T: HOLD from fieldbus'
,'S:   |T: '
)
--*******************************************************************************************************--

--*******************************************************************************************************--

) as output
left join gadata.volvo.l_timeline as timeline on output.timestamp between timeline.starttime and timeline.endtime
where 
--Exclude opeation logs 
(
(@ExcludeOperational = 1 AND (ISNULL(output.Subgroup,'') NOT LIKE '%Operational%')) 
OR 
@ExcludeOperational =0
)
order by output.timestamp desc 

END