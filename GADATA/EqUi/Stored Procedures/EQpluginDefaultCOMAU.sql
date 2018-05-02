


CREATE PROCEDURE [EqUi].[EQpluginDefaultCOMAU]

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
   @c3gBreakdownStart as bit = 0,
   @c4gBreakdownStart as bit  = 0,
   @c3gSysState as bit = 0,
   @c4gSysState as bit = 0,
   @c3gSBCU as bit = 0,
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
, T.id		AS 'refId'
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
SELECT * from GADATA.c3g.error
where 
--Asset Filters
isnull(error.AssetID,'%') like @assets
and 
isnull(error.LOCATION,error.controller_name) like @locations
and
error.controller_name like @locations
and
isnull(error.LocationTree,'%') like @lochierarchy
--Time Filter
and
error.[timestamp] BETWEEN @StartDate AND @EndDate
and
@MinLogserv <= error.Severity
and
@c3gError = 1
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--c4g error
--*******************************************************************************************************--
select * from GADATA.c4g.error
where 
--Asset Filters
isnull(error.AssetID,'%') like @assets
and 
isnull(error.LOCATION,error.controller_name) like @locations
and
error.controller_name like @locations
and
isnull(error.LocationTree,'%') like @lochierarchy
--Time Filter
and
error.[timestamp] BETWEEN @StartDate AND @EndDate
and
@MinLogserv <= error.Severity
and
@c4gError = 1
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--c3g breakdown
--*******************************************************************************************************--
select * from GADATA.c3g.breakdown as c3g_breakdown
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
SELECT * from GADATA.c4g.breakdown as c4g_breakdown
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
--c3g breakdown start
--*******************************************************************************************************--
select * from GADATA.c3g.breakdown_start as c3g_breakdown_start
where 
--Asset Filters
isnull(c3g_breakdown_start.AssetID,'%') like @assets
and 
isnull(c3g_breakdown_start.LOCATION,c3g_breakdown_start.controller_name) like @locations
and
c3g_breakdown_start.controller_name like @locations
and
isnull(c3g_breakdown_start.LocationTree,'%') like @lochierarchy
--Time Filter
and
c3g_breakdown_start.[timestamp] BETWEEN @StartDate AND @EndDate
and
@c3gBreakdownStart = 1
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--c4g breakdown start
--*******************************************************************************************************--
SELECT * from GADATA.c4g.Breakdown_Start as Breakdown_Start
where 
--Asset Filters
isnull(Breakdown_Start.assetid,'%') like @assets
and 
isnull(Breakdown_Start.LOCATION,Breakdown_Start.controller_name) like @locations
and
Breakdown_Start.controller_name like @locations
and
isnull(Breakdown_Start.LocationTree,'%') like @lochierarchy
--Time Filter
and
Breakdown_Start.[timestamp] BETWEEN @StartDate AND @EndDate
and
@c4gBreakdownStart = 1
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
isnull(sysstate.LOCATION,sysstate.controller_name) like @locations
and
sysstate.controller_name like @locations
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
--c3g SBCU
--*******************************************************************************************************--
select * from gadata.c3g.sbcu
where 
--Asset Filters
sbcu.AssetID like @assets
and
isnull(sbcu.LOCATION,sbcu.controller_name) like @locations
and
sbcu.controller_name like @locations
and
sbcu.LocationTree like @lochierarchy
--Time Filter
and
sbcu.[timestamp] BETWEEN @StartDate AND @EndDate
and
@c3gSBCU = 1
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