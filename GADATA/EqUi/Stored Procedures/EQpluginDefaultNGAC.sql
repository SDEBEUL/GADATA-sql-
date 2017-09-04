




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
	   @VariableLog as bit = 0,
	   @DeviceProperty as bit = 0,

    --filters
	@DisplayLevel as int = 2,
	@DisplayFullLogtext as bit = 1,
	@ExcludeOperational as bit = 0

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
, NGAC.ifThenElse(@DisplayFullLogtext,output.FullLogtext,'<@DisplayFullLogtext = 0>')  as 'FullLogtext'
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
, NULL      AS 'FullLogtext'
, NULL      AS 'Response'
, NULL      AS 'Downtime'
, 'TIMELINE'		AS 'Classification'
, 'TIMELINE'		AS 'Subgroup'
, NULL		AS 'Category'
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
--displaylevel
and 
d.Severity > @DisplayLevel
--enable
and 
@ErrDispLog =1
---------------------------------------------------------------------------------------

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

---------------------------------------------------------------------------------------
--DeivcePropertys
---------------------------------------------------------------------------------------
UNION
SELECT * 
From gadata.NGAC.devicePropertyLog as v 

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
(@ExcludeOperational = 1 AND (ISNULL(output.Subgroup,'') NOT LIKE '%Operational%')) 
OR 
@ExcludeOperational =0
)
order by output.timestamp desc 

END