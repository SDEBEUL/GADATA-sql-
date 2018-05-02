
CREATE PROCEDURE [EqUi].[AAGRIP_PloegRaport]

--default parameters
    --timeparameters
	   @StartDate as DATETIME = null,
	   @EndDate as DATETIME = null,
	   @daysBack as int = null,
	--Filterparameters.
	   @assets as varchar(10) = '%',
	   @locations as varchar(20) = '%',
	   @lochierarchy as varchar(20) = '%', 
	--non default parms
	   @minDowntime as int = 20,
       @minCountOfDowtime as int = 3,
       @minCountofWarning as int = 4,
	   @getAlerts as bit = 0,
	   @getShifbook as bit = 1
AS
BEGIN

---------------------------------------------------------------------------------------
--Set default values of start and end date
---------------------------------------------------------------------------------------
if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()
END
if ((@StartDate is null) OR (@StartDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @startdate = @enddate -'1900-01-02 00:00:00'  --SDEBEUL change 2 to 1 !!!!!!!  -- will force 3 last shifts and the active on.
END
--********************************************************--
/*use the selected daterange and ajust so that it matched the
begin en endpoint of a shift.
@enddate should always be the begin point of the activeshift for that DT
@sartdate should alwas be the end point of the activeshift for that DT 
*/
--********************************************************--
SET @startdate = (select top 1 l.starttime from gadata.volvo.L_timeline as l where l.starttime between @startdate and @endDate order by l.endtime asc)
SET @endDate = (select top 1 l.endtime from gadata.volvo.L_timeline as l where l.starttime between @startdate and @endDate order by l.starttime desc)
--********************************************************--
--clause for weekend. needs to look in 3 day shiftwindow
if (@startdate is null)
BEGIN
SET @startdate = (select top 1 l.starttime from gadata.volvo.L_timeline as l where getdate() between l.starttime and l.endtime order by l.endtime asc)
SET @endDate = (select top 1 l.endtime from gadata.volvo.L_timeline as l where  getdate() between l.starttime and l.endtime order by l.starttime desc)
END
--********************************************************--

--************************************************************************************--
---shift report (template)
--************************************************************************************--
SELECT 
--asset
  output.Location       AS 'Location' 
, output.AssetID	    AS 'AssetID'
--log part
, output.Logcode		As 'Logcode'
, output.Logtype		AS 'Logtype'
, output.logtext		AS 'logtext'
, output.[Response(s)]/60 As 'Response(min)'
, output.[Downtime(s)]/60		AS 'Downtime(min)'
, output.count			As 'Count'
--date time part
, CONVERT(char(19),output.[timestamp], 120) AS 'timestamp' --cast to timeformat excel likes 
, CONVERT(char(19),output.[timestamp], 108) AS 'time' 
, output.Subgroup		AS 'Subgroup'
--extra 
, output.refid		    AS 'refId'
, output.LocationTree   AS 'LocationTree'
, output.Classification   AS 'Classification'
FROM
(
--************************************************************************************--

--************************************************************************************--
--c4g breakdown
--************************************************************************************--
SELECT * FROM (
SELECT        
  c4g_breakdown.location 
, c4g_breakdown.AssetID 
, c4g_breakdown.Logtype
, min(c4g_breakdown.[timestamp]) AS 'timestamp'
, min(c4g_breakdown.[Logcode]) as 'Logcode'
, min(c4g_breakdown.logtext) as 'logtext'
, SUM(c4g_breakdown.[Response(s)]) as 'Response(s)'
, SUM(c4g_breakdown.[Downtime(s)]) AS 'Downtime(s)'
, count(c4g_breakdown.[Downtime(s)]) AS 'Count'
, c4g_breakdown.Subgroup
, min(c4g_breakdown.refId) as 'refid'
, c4g_breakdown.LocationTree
, c4g_breakdown.Classification
FROM gadata.c4g.breakdown as c4g_breakdown
left join GADATA.volvo.L_timeline as timeline on c4g_breakdown.[timestamp] between timeline.starttime and timeline.endtime
WHERE 
--Asset Filters
isnull(c4g_breakdown.AssetID,'%') like @assets
and 
isnull(c4g_breakdown.LOCATION,c4g_breakdown.controller_name) like @locations
and
c4g_breakdown.controller_name like @locations
and
isnull(c4g_breakdown.LocationTree,'%') like @lochierarchy
--Time Filter
and
c4g_breakdown.[timestamp] BETWEEN @StartDate AND @EndDate
AND
c4g_breakdown.[Downtime(s)] < (8*60*60) -- just filter out bullshit more than 8 hours
and
c4g_breakdown.Classification like 'UG'

GROUP BY 
 c4g_breakdown.location 
,c4g_breakdown.AssetID 
,c4g_breakdown.Logtype
,timeline.Vyear
,timeline.Vweek
,timeline.Vday
,timeline.shift
,c4g_breakdown.Subgroup
,c4g_breakdown.LocationTree
, c4g_breakdown.Classification
--************************************************************************************--
) as breakdowns
--set report filter
where 
(
breakdowns.Count > @minCountOfDowtime
OR
breakdowns.[Downtime(s)] > (@minDowntime*60)
)
AND 
breakdowns.Subgroup not in('EO Maint','Operational**','Operational')
--************************************************************************************--

--************************************************************************************--
--c3g breakdown
--************************************************************************************--
UNION
SELECT * FROM (
SELECT        
  c3g_breakdown.location 
, c3g_breakdown.AssetID 
, c3g_breakdown.Logtype
, min(c3g_breakdown.[timestamp]) AS 'timestamp'
, min(c3g_breakdown.[Logcode]) as 'Logcode'
, min(c3g_breakdown.logtext) as 'logtext'
, SUM(c3g_breakdown.[Response(s)]) as 'Response(s)'
, SUM(c3g_breakdown.[Downtime(s)]) AS 'Downtime(s)'
, count(c3g_breakdown.[Downtime(s)]) AS 'Count'
, c3g_breakdown.Subgroup
, min(c3g_breakdown.refId) as 'refid'
, c3g_breakdown.LocationTree
, c3g_breakdown.Classification
FROM GADATA.c3g.breakdown as c3g_breakdown
left join GADATA.volvo.L_timeline as timeline on c3g_breakdown.[timestamp] between timeline.starttime and timeline.endtime
WHERE 
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
AND
c3g_breakdown.[Downtime(s)] < (8*60*60) -- just filter out bullshit more than 8 hours
and
c3g_breakdown.Classification like 'UG'

GROUP BY 
 c3g_breakdown.location 
,c3g_breakdown.AssetID 
,c3g_breakdown.Logtype
,timeline.Vyear
,timeline.Vweek
,timeline.Vday
,timeline.shift
,c3g_breakdown.Subgroup
,c3g_breakdown.LocationTree
, c3g_breakdown.Classification
--************************************************************************************--
) as breakdowns
--set report filter
where 
(
breakdowns.Count > @minCountOfDowtime
OR
breakdowns.[Downtime(s)] > (@minDowntime*60)
)
AND 
breakdowns.Subgroup not in('EO Maint','Operational**','Operational')
--************************************************************************************--

--************************************************************************************--
--NGAC breakdown
--************************************************************************************--
UNION 
SELECT * FROM (
SELECT        
  ngac_breakdown.location 
, ngac_breakdown.AssetID 
, ngac_breakdown.Logtype as 'Logtype'
, min(ngac_breakdown.[timestamp]) AS 'timestamp'
, min(ngac_breakdown.[Logcode]) as 'Logcode' 
, ngac_breakdown.logtext as 'logtext'
, SUM(ngac_breakdown.Response) as 'Response(s)'
, SUM(ngac_breakdown.Downtime) AS 'Downtime(s)'
, count(ngac_breakdown.Downtime) AS 'Count'
, ngac_breakdown.Subgroup
, min(ngac_breakdown.refId) as 'refid'
, ngac_breakdown.LocationTree
, ngac_breakdown.Classification
FROM GADATA.NGAC.Breakdown as ngac_breakdown
left join GADATA.volvo.L_timeline as timeline on ngac_breakdown.[timestamp] between timeline.starttime and timeline.endtime
WHERE 
--Asset Filters
isnull(ngac_breakdown.AssetID,'%') like @assets
and 
isnull(ngac_breakdown.LOCATION,ngac_breakdown.controller_name) like @locations
and
ngac_breakdown.controller_name like @locations
and
isnull(ngac_breakdown.LocationTree,'%') like @lochierarchy
--Time Filter
and
ngac_breakdown.[timestamp] BETWEEN @StartDate AND @EndDate
AND
ngac_breakdown.Downtime < (8*60*60) -- just filter out bullshit more than 8 hours
and
ngac_breakdown.Classification like 'UG'

GROUP BY 
 ngac_breakdown.location 
,ngac_breakdown.AssetID 
,ngac_breakdown.Logtype
,timeline.Vyear
,timeline.Vweek
,timeline.Vday
,timeline.shift
,ngac_breakdown.Subgroup
,ngac_breakdown.LocationTree
--group by logtekst for NGAC
,ngac_breakdown.Logtext
, ngac_breakdown.Classification
--************************************************************************************--

) as breakdowns
--set report filter
where 
(
breakdowns.Count > @minCountOfDowtime
OR
breakdowns.[Downtime(s)] > (@minDowntime*60)
)
AND 
breakdowns.Subgroup not in('EO Maint','Operational**','Operational')
--************************************************************************************--

--************************************************************************************--
--S4c breakdown
--************************************************************************************--
UNION 
SELECT * FROM (
SELECT        
  s4c_breakdown.location 
, s4c_breakdown.AssetID 
, s4c_breakdown.Logtype
, min(s4c_breakdown.[timestamp]) AS 'timestamp'
, min(s4c_breakdown.[Logcode]) as 'Logcode'
, min(s4c_breakdown.logtext) as 'logtext'
, SUM(s4c_breakdown.[Response(s)]) as 'Response(s)'
, SUM(s4c_breakdown.[Downtime(s)]) AS 'Downtime(s)'
, count(s4c_breakdown.[Downtime(s)]) AS 'Count'
, s4c_breakdown.Subgroup
, min(s4c_breakdown.refId) as 'refid'
, s4c_breakdown.LocationTree
, s4c_breakdown.Classification
FROM GADATA.s4c.breakdown as s4c_breakdown
left join GADATA.volvo.L_timeline as timeline on s4c_breakdown.[timestamp] between timeline.starttime and timeline.endtime
WHERE 
--Asset Filters
isnull(s4c_breakdown.AssetID,'%') like @assets
and 
isnull(s4c_breakdown.LOCATION,s4c_breakdown.controller_name) like @locations
and
s4c_breakdown.controller_name like @locations
and
isnull(s4c_breakdown.LocationTree,'%') like @lochierarchy
--Time Filter
and
s4c_breakdown.[timestamp] BETWEEN @StartDate AND @EndDate
AND
s4c_breakdown.[Downtime(s)] < (8*60*60) -- just filter out bullshit more than 8 hours
and
s4c_breakdown.Classification like 'UG'

GROUP BY 
 s4c_breakdown.location 
,s4c_breakdown.AssetID 
,s4c_breakdown.Logtype
,timeline.Vyear
,timeline.Vweek
,timeline.Vday
,timeline.shift
,s4c_breakdown.Subgroup
,s4c_breakdown.LocationTree
--group by logtekst for s4c (there is no subgroup system)
,s4c_breakdown.Logtext
, s4c_breakdown.Classification
--************************************************************************************--

) as breakdowns
--set report filter
where 
(
breakdowns.Count > @minCountOfDowtime
OR
breakdowns.[Downtime(s)] > (@minDowntime*60)
)
AND 
breakdowns.Subgroup not in('EO Maint','Operational**','Operational')
--************************************************************************************--


--************************************************************************************--
UNION
--************************************************************************************--
--c4g warning
--************************************************************************************--
SELECT * FROM (
SELECT 
  c4g_error.location 
, c4g_error.AssetID 
, c4g_error.Logtype
, min(c4g_error.[timestamp]) AS 'timestamp'
, min(c4g_error.[Logcode]) as 'Logcode'
, min(c4g_error.logtext) as 'logtext'
, NULL as 'Response(s)'
, NULL as 'Downtime(s)'
, count(c4g_error.[timestamp]) AS 'Count'
, c4g_error.Subgroup
, min(c4g_error.refId) as 'refid'
, c4g_error.LocationTree
, c4g_error.Classification
FROM GADATA.c4g.Error as c4g_error 
left join GADATA.volvo.L_timeline as timeline on c4g_error.[timestamp] between timeline.starttime and timeline.endtime
WHERE 
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
AND 
c4g_error.Severity = 2 --enkel warnings 
and
c4g_error.Classification like 'UG'

GROUP BY 
 c4g_error.location 
,c4g_error.AssetID 
,c4g_error.Logtype
,timeline.Vyear
,timeline.Vweek
,timeline.Vday
,timeline.shift
,c4g_error.Subgroup
,c4g_error.LocationTree
, c4g_error.Classification
--************************************************************************************--
) as warning 
where
warning.Count > @minCountofWarning
AND 
warning.Subgroup not in('EO Maint','Operational**','Operational')
--************************************************************************************--
--************************************************************************************--
--c3g warning
--************************************************************************************--
UNION
SELECT * FROM (
SELECT 
  c3g_error.location 
, c3g_error.AssetID 
, c3g_error.Logtype
, min(c3g_error.[timestamp]) AS 'timestamp'
, min(c3g_error.[Logcode]) as 'Logcode'
, min(c3g_error.logtext) as 'logtext'
, NULL as 'Response(s)'
, NULL as 'Downtime(s)'
, count(c3g_error.[timestamp]) AS 'Count'
, c3g_error.Subgroup
, min(c3g_error.refId) as 'refid'
, c3g_error.LocationTree
, c3g_error.Classification
FROM GADATA.c3g.error as c3g_error 
left join GADATA.volvo.L_timeline as timeline on c3g_error.[timestamp] between timeline.starttime and timeline.endtime
WHERE 
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
AND 
c3g_error.Severity = 2 --enkel warnings 
and
c3g_error.Classification like 'UG'

GROUP BY 
 c3g_error.location 
,c3g_error.AssetID 
,c3g_error.Logtype
,timeline.Vyear
,timeline.Vweek
,timeline.Vday
,timeline.shift
,c3g_error.Subgroup
,c3g_error.LocationTree
, c3g_error.Classification
--************************************************************************************--
) as warning 
where
warning.Count > @minCountofWarning
AND 
warning.Subgroup not in('EO Maint','Operational**','Operational')
--************************************************************************************--

--************************************************************************************--
--Alerts (new EQUI system) 
--************************************************************************************--
UNION
select 
  h_alert.[location] 
, '' 
, 'ALERT'
, max(h_alert._timestamp) AS 'timestamp'
, max(c_triggers.id) as 'Logcode'
, max(h_alert.info) as 'logtext'
, NULL as 'Response(s)'
,CASE 
 WHEN c_triggers.isDowntime = 1 THEN SUM(DATEDIFF(second,h_alert._timestamp,h_alert.lastTriggerd))
 ELSE NULL 
 END as 'Downtime(s)' 
, COUNT(h_alert.id) AS 'Count'
, max(c_triggers.alertType)
, max(h_alert.id) as 'refid'
,h_alert.locationTree
, h_alert.Classification

from GADATA.Alerts.h_alert
left join GADATA.Alerts.c_triggers on c_triggers.id = h_alert.c_tirgger_id
left join GADATA.Volvo.L_timeline on h_alert._timestamp between L_timeline.starttime and L_timeline.endtime

where h_alert._timestamp between @StartDate and @EndDate
and c_triggers.isInReport = 1 --only show alert when this is set
--and 
--@getAlerts = 1
and
h_alert.Classification like 'UG'

group by 
 L_timeline.Vyear
,L_timeline.Vweek
,L_timeline.Vday
,L_timeline.[shift]
,h_alert.[location]
,h_alert.locationTree
,c_triggers.alertType
,c_triggers.isDowntime
, h_alert.Classification
--************************************************************************************--
--************************************************************************************--


--************************************************************************************--
--timeline
--************************************************************************************--
UNION
SELECT 
  null 
, null 
, 'TIMELINE' as 'LogType'
, t.timestamp
, null
, 'ShiftRap for:  ' + cast(t.Year as varchar(4)) + 'W' + cast(t.Week as varchar(2)) + 'D' + cast(t.day as varchar(1)) + '   | above here starts the ' + t.Ploeg + ' shift' as 'Logtekst'
, null 
, null
, null
, null
, null
, ''
, null
FROM GADATA.volvo.Timeline as t where t.timestamp between @startdate and @endDate
--************************************************************************************--

--************************************************************************************--
--Info
--************************************************************************************--
UNION
SELECT 
  null 
, null 
, 'Ruleinfo' as 'LogType'
, @StartDate as  'timestamp'
, null
, '   |@minDowntime = ' + CAST(@minDowntime as varchar(5)) +
  '   |@minCountOfDowtime = ' + CAST(@minCountOfDowtime as varchar(5)) + 
  '   |@minCountofWarning = ' + CAST(@minCountofWarning as varchar(5)) 
as 'Logtekst'
, null 
, null
, null
, '<= refreshed' as 'subgroup'
, null
, ''
, null
--************************************************************************************--

) as output 

--set sort
ORDER BY output.timestamp desc
END