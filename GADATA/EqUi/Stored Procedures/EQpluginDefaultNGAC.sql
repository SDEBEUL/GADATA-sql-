





CREATE PROCEDURE [EqUi].[EQpluginDefaultNGAC]

--default parameters
--timeparameters
	   @StartDate as DATETIME = null,
	   @EndDate as DATETIME = null,
	   @daysBack as int = null,
	--Filterparameters.
	   @assets as varchar(10) = '%',
	   @locations as varchar(20) = '%',
	   @lochierarchy as varchar(20) = '%',
	--optional
	   @timeline as bit = 1,
	   @ControllerEventLog as bit = 1,
	   @ErrDispLog as bit =1,
	   @ErrDispLogS4C as bit = 0,
	   @VariableLog as bit = 0,
	   @DeviceProperty as bit = 0,
	   @Breakdown as bit = 0,
	   @BreakdownStart as bit = 0,
	   @Jobs as bit = 0,
	   @Events as bit = 0,
    --filters
	@DisplayLevel as int = 2,
	@DisplayFullLogtext as bit = 1,
	@ExcludeOperational as bit = 1

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
, CASE @DisplayFullLogtext 
	WHEN 1 THEN output.FullLogtext
    ELSE output.logtext
	END as 'logtext'
, output.Response/60		AS 'Response(min)'
, output.Downtime/60		AS 'Downtime(min)'
--date time part
, CONVERT(char(19),output.[timestamp], 120) AS 'timestamp' --cast to timeformat excel likes 
, CONVERT(char(19),output.[timestamp], 108) AS 'time' 
, timeline.Vyear		     AS 'Year'
, timeline.Vweek		     AS 'Week'
, timeline.Vday		     AS 'Day'
, timeline.[shift]           AS 'Shift'
, timeline.PLOEG		     As 'Ploeg'
--classifcation part
, output.Classification	AS 'Classification'
, output.Subgroup		AS 'Subgroup'
, output.Category		AS 'Category'
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
, 'Begin of Shift: ' + T.[shift] + '  Ploeg:'+ T.PLOEG       AS 'FullLogtext'
, NULL      AS 'Response'
, NULL      AS 'Downtime'
, 'TIMELINE'		AS 'Classification'
, 'TIMELINE'		AS 'Subgroup'
, ''		AS 'Category'
, T.id		AS 'refId'
, ''		As 'LocationTree'
, ''		AS 'ClassTree'
, ''		AS 'controller_name'
, ''		As 'controller_type'

FROM  Volvo.L_timeline as T 
where 
T.starttime BETWEEN @StartDate AND @EndDate
AND
@timeline = 1


--*******************************************************************************************************--
UNION
-----------------------------------------------------------------------------------
--ControllerEventLog
---------------------------------------------------------------------------------------
SELECT * 
From gadata.NGAC.ControllerEventLog as e 
where 
--Asset Filters
isnull(e.AssetID,'%') like @assets
and 
isnull(e.LOCATION,e.controller_name) like @locations
and
e.controller_name like @locations
and
isnull(e.LocationTree,'%') like @lochierarchy
--Time Filter
and
e.[timestamp] BETWEEN @StartDate AND @EndDate
--enable
and
@ControllerEventLog = 1

---------------------------------------------------------------------------------------
UNION
-----------------------------------------------------------------------------------
--ControllerEventLog rt_alarms
---------------------------------------------------------------------------------------
SELECT * 
From gadata.NGAC.junk_alarms as e 
where 
--Asset Filters
isnull(e.AssetID,'%') like @assets
and 
isnull(e.LOCATION,e.controller_name) like @locations
and
e.controller_name like @locations
and
isnull(e.LocationTree,'%') like @lochierarchy
--Time Filter
and
e.[timestamp] BETWEEN @StartDate AND @EndDate
--enable
and
@ControllerEventLog = 1
and 
@ExcludeOperational = 0

---------------------------------------------------------------------------------------
UNION
-----------------------------------------------------------------------------------
--Breakdown
---------------------------------------------------------------------------------------
SELECT * 
From gadata.NGAC.Breakdown as e 
where 
--Asset Filters
isnull(e.AssetID,'%') like @assets
and 
isnull(e.LOCATION,e.controller_name) like @locations
and
e.controller_name like @locations
and
isnull(e.LocationTree,'%') like @lochierarchy
--Time Filter
and
e.[timestamp] BETWEEN @StartDate AND @EndDate
--enable
and
@Breakdown = 1

---------------------------------------------------------------------------------------
UNION
-----------------------------------------------------------------------------------
--Breakdown s4C CONTROLLERS!!!!
---------------------------------------------------------------------------------------
SELECT * 
From gadata.s4c.Breakdown as e 
where 
--Asset Filters
isnull(e.AssetID,'%') like @assets
and 
isnull(e.LOCATION,e.controller_name) like @locations
and
e.controller_name like @locations
and
isnull(e.LocationTree,'%') like @lochierarchy
--Time Filter
and
e.[timestamp] BETWEEN @StartDate AND @EndDate
--enable
and
@Breakdown = 1

---------------------------------------------------------------------------------------


UNION
-----------------------------------------------------------------------------------
--Breakdown START
---------------------------------------------------------------------------------------
SELECT * 
From gadata.NGAC.Breakdown_start as e 
where 
--Asset Filters
isnull(e.AssetID,'%') like @assets
and 
isnull(e.LOCATION,e.controller_name) like @locations
and
e.controller_name like @locations
and
isnull(e.LocationTree,'%') like @lochierarchy
--Time Filter
and
e.[timestamp] BETWEEN @StartDate AND @EndDate
--enable
and
@BreakdownStart = 1

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--ErrDispLog
---------------------------------------------------------------------------------------
UNION
SELECT * 
From gadata.NGAC.ErrDispLog as d 

where 
--Asset Filters
isnull(d.AssetID,'%') like @assets
and 
isnull(d.LOCATION,d.controller_name) like @locations
and
d.controller_name like @locations
and
isnull(d.LocationTree,'%') like @lochierarchy
--Time Filter
and
d.[timestamp] BETWEEN @StartDate AND @EndDate
--enable
and 
@ErrDispLog =1
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--ErrDispLog S4C
---------------------------------------------------------------------------------------

UNION
SELECT * 
From gadata.S4C.ErrDispLog as d 

where 
--Asset Filters
isnull(d.AssetID,'%') like @assets
and 
isnull(d.LOCATION,d.controller_name) like @locations
and
d.controller_name like @locations
and
isnull(d.LocationTree,'%') like @lochierarchy
--Time Filter
and
d.[timestamp] BETWEEN @StartDate AND @EndDate
--displaylevel
and 
d.Severity > @DisplayLevel
--enable
and 
@ErrDispLogs4c =1

---------------------------------------------------------------------------------------
UNION
-----------------------------------------------------------------------------------
--Jobs
---------------------------------------------------------------------------------------
SELECT * 
From gadata.NGAC.jobs as e 
where 
--Asset Filters
isnull(e.AssetID,'%') like @assets
and 
isnull(e.LOCATION,e.controller_name) like @locations
and
e.controller_name like @locations
and
isnull(e.LocationTree,'%') like @lochierarchy
--Time Filter
and
e.[timestamp] BETWEEN @StartDate AND @EndDate
--enable
and
@Jobs = 1

-----------------------------------------------------------------------------------
--EVENTS
---------------------------------------------------------------------------------------
UNION
SELECT * 
From gadata.NGAC.Events as e 
where 
--Asset Filters
isnull(e.AssetID,'%') like @assets
and 
isnull(e.LOCATION,e.controller_name) like @locations
and
e.controller_name like @locations
and
isnull(e.LocationTree,'%') like @lochierarchy
--Time Filter
and
e.[timestamp] BETWEEN @StartDate AND @EndDate
--enable
and
@Events = 1

---------------------------------------------------------------------------------------
/*
---------------------------------------------------------------------------------------
--VariableLog
---------------------------------------------------------------------------------------
UNION
SELECT * 
From gadata.NGAC.variableLog as v 

where 
--Asset Filters
isnull(v.AssetID,'%') like @assets
and 
isnull(v.LOCATION,v.controller_name) like @locations
and
v.controller_name like @locations
and
isnull(v.LocationTree,'%') like @lochierarchy
--Time Filter
and
v.[timestamp] BETWEEN @StartDate AND @EndDate
--enable
and 
@VariableLog =1
---------------------------------------------------------------------------------------
*/
---------------------------------------------------------------------------------------
--DeivcePropertys
---------------------------------------------------------------------------------------

UNION
SELECT * 
From gadata.NGAC.device_info as v 

where 
--Asset Filters
isnull(v.AssetID,'%') like @assets
and 
isnull(v.LOCATION,v.controller_name) like @locations
and
v.controller_name like @locations
and
isnull(v.LocationTree,'%') like @lochierarchy
--Time Filter
and
v.[timestamp] BETWEEN @StartDate AND @EndDate
--enable
and 
@DeviceProperty =1

---------------------------------------------------------------------------------------

) as output
left join gadata.volvo.l_timeline as timeline on output.timestamp between timeline.starttime and timeline.endtime
where 
--Exclude opeation logs 
(
(@ExcludeOperational = 1 
AND (ISNULL(output.Subgroup,'') NOT LIKE '%Operational%') 
AND (ISNULL(output.Category,'') <> 'Operational') 
)
OR 
@ExcludeOperational =0
)
order by output.timestamp desc 

END