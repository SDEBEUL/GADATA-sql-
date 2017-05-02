
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
   @c3gSBCU as bit = 0,
   @getshiftbook as bit = 0,
   @active as bit = 0,
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
  Null	    AS 'Location' 
, Null	    AS 'AssetID'
,'TIMELINE' AS 'Logtype'
, T.starttime AS 'timestamp'
, Null      AS 'Logcode'
, Null      AS 'Severity'
, null      AS 'logtext'
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
--c3g SysState
--*******************************************************************************************************--
SELECT  
  A.Location	     AS 'Location' 
, A.CLassificationID AS 'AssetID'
,'SYSSTATE' AS 'Logtype'
, Y._timestamp AS 'timestamp'
, Null      AS 'Logcode'
, Null      AS 'Severity'
,'  Code: ' + CAST(Y.Sys_state AS varchar) +   '  SysState: ' + (GADATA.C3G.fn_decodeSysstate(y.Sys_state))       AS 'logtext'
, NULL      AS 'Response'
, NULL      AS 'Downtime'
, NULL		AS 'Classification'
, NULL		AS 'Subgroup'
, NULL		AS 'refId'
, NULL		As 'LocationTree'
, NULL		AS 'ClassTree'
, NULL		AS 'controller_name'
, 'c3g'		As 'controller_type'

FROM  GADATA.C3G.rt_sys_event as Y
--join the timeline
LEFT JOIN GADATA.VOLVO.L_timeline AS T ON ( Y._timestamp BETWEEN T.starttime AND T.endtime)
--joining of the RIGHT ASSET
LEFT OUTER JOIN equi.ASSETS as A on 
A.controller_type = 'c3g' --join the right 'data controller type'
AND
A.controller_id = Y.controller_id --join the right 'data controller id'
AND 
A.CLassificationId LIKE '%URC%'--join c3g robot because state is owned by robot

where 
--Asset Filters
a.CLassificationId like @assets
and 
a.LOCATION like @locations
and
a.LocationTree like @lochierarchy
--Time Filter
and
Y._timestamp BETWEEN @StartDate AND @EndDate
and
@c3gSysState = 1
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--c4g SysState
--*******************************************************************************************************--
SELECT  
  A.Location	     AS 'Location' 
, A.CLassificationID AS 'AssetID'
,'SYSSTATE' AS 'Logtype'
, Y._timestamp AS 'timestamp'
, Null      AS 'Logcode'
, Null      AS 'Severity'
,'  Code: ' + CAST(Y.Sys_state AS varchar) +   '  SysState: ' + (GADATA.c4g.fn_decodeSysstate(y.Sys_state)) + '  RobState: ' + CAST(GADATA.C4G.fn_robstate(y.Sys_state) as varchar) AS 'logtext'
, NULL      AS 'Response'
, NULL      AS 'Downtime'
, NULL		AS 'Classification'
, NULL		AS 'Subgroup'
, NULL		AS 'refId'
, NULL		As 'LocationTree'
, NULL		AS 'ClassTree'
, NULL		AS 'controller_name'
, 'c4g'		As 'controller_type'

FROM  GADATA.C4G.rt_sys_event as Y
--join the timeline
LEFT JOIN GADATA.VOLVO.L_timeline AS T ON ( Y._timestamp BETWEEN T.starttime AND T.endtime)
--joining of the RIGHT ASSET
LEFT OUTER JOIN equi.ASSETS as A on 
A.controller_type = 'c4g' --join the right 'data controller type'
AND
A.controller_id = Y.controller_id --join the right 'data controller id'
AND 
A.CLassificationId LIKE '%URC%'--join c4g robot because state is owned by robot

where 
--Asset Filters
a.CLassificationId like @assets
and 
a.LOCATION like @locations
and
a.LocationTree like @lochierarchy
--Time Filter
and
Y._timestamp BETWEEN @StartDate AND @EndDate
and
@c4gSysState = 1
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--c3g SBCU
--*******************************************************************************************************--
SELECT  
  A.Location	     AS 'Location' 
, A.CLassificationID AS 'AssetID'
,'SBCU' AS 'Logtype'
, L.tool_timestamp AS 'timestamp'
, Null      AS 'Logcode'
, Null      AS 'Severity'
,'Gun:' + CAST(L.tool_id as varchar(2)) + ' Long: ' + isnull(CAST(L.Longcheck as varchar(3)), '/') + '  Update: ' + isnull(CAST(L.TcpUpdate as varchar(3)),'/') + '  Dsetup: ' + LTRIM(Str(L.dsetup, 5, 2)) + '  Dmeas: ' + LTRIM(Str(L.Dmeas, 5, 2)) AS 'Logtekst'
, NULL      AS 'Response'
, NULL      AS 'Downtime'
, NULL		AS 'Classification'
, NULL		AS 'Subgroup'
, NULL		AS 'refId'
, NULL		As 'LocationTree'
, NULL		AS 'ClassTree'
, NULL		AS 'controller_name'
, 'c3g'		As 'controller_type'

FROM c3g.rt_toollog as L 
--join the timeline
LEFT JOIN GADATA.VOLVO.L_timeline AS T ON ( L.tool_timestamp BETWEEN T.starttime AND T.endtime)
--joining of the RIGHT ASSET
LEFT OUTER JOIN equi.ASSETS as A on 
A.controller_type = 'c3g' --join the right 'data controller type'
AND
A.controller_id = L.controller_id --join the right 'data controller id'
AND 
A.CLassificationId LIKE '%URC%'

where 
--Asset Filters
a.CLassificationId like @assets
and 
a.LOCATION like @locations
and
a.LocationTree like @lochierarchy
--Time Filter
and
L.tool_timestamp BETWEEN @StartDate AND @EndDate
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