
CREATE PROCEDURE [EqUi].[AAOSR_PloegRaportV2]

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
SET @startdate = @enddate -'1900-01-02 00:00:00' -- will force 3 last shifts and the active on.
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
FROM
(
--************************************************************************************--
SELECT * FROM
(
--************************************************************************************--
--c4g breakdown
--************************************************************************************--
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

GROUP BY 
 c4g_breakdown.location 
,c4g_breakdown.AssetID 
,c4g_breakdown.Logtype
,timeline.Vyear
,timeline.Vweek
,timeline.Vday
,timeline.shift
,c4g_breakdown.Subgroup
--************************************************************************************--

--************************************************************************************--
--c3g breakdown
--************************************************************************************--
UNION
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

GROUP BY 
 c3g_breakdown.location 
,c3g_breakdown.AssetID 
,c3g_breakdown.Logtype
,timeline.Vyear
,timeline.Vweek
,timeline.Vday
,timeline.shift
,c3g_breakdown.Subgroup
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
SELECT * FROM (
--************************************************************************************--
--c4g warning
--************************************************************************************--

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

GROUP BY 
 c4g_error.location 
,c4g_error.AssetID 
,c4g_error.Logtype
,timeline.Vyear
,timeline.Vweek
,timeline.Vday
,timeline.shift
,c4g_error.Subgroup
--************************************************************************************--

--************************************************************************************--
--c3g warning
--************************************************************************************--
UNION
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

GROUP BY 
 c3g_error.location 
,c3g_error.AssetID 
,c3g_error.Logtype
,timeline.Vyear
,timeline.Vweek
,timeline.Vday
,timeline.shift
,c3g_error.Subgroup
--************************************************************************************--
) as warning 
where
warning.Count > @minCountofWarning
AND 
warning.Subgroup not in('EO Maint','Operational**','Operational')
--************************************************************************************--

--************************************************************************************--
--Alerts (binnen dt range)
--************************************************************************************--
UNION
SELECT 
  a.Robotname
, null
, a.ErrorType
, a.timestamp
,null
, a.Logtekst +ISNULL(' |info: ' +CAST(REPLACE(ia.User_Comment,'***************************',' => ') as varchar(600)),'') as 'Logtekst'
,null
,null
,null
, a.Subgroup
, a.idx

FROM GADATA.volvo.Alerts as a 
left join GADATA.volvo.ia_Alert as ia on ia.id = a.idx
where a.timestamp between @startdate and @endDate
and 
@getAlerts = 1
--************************************************************************************--

--************************************************************************************--
--Alerts (openstaand BUTIEN dt range)
--************************************************************************************--
UNION
SELECT 
  a.Robotname
, null
, a.ErrorType
, a.timestamp
,null
, a.Logtekst +ISNULL(' |info: ' +CAST(REPLACE(ia.User_Comment,'***************************',' => ') as varchar(600)),'') as 'Logtekst'
,null
,null
,null
, a.Subgroup
, a.idx
FROM GADATA.volvo.Alerts as a 
left join GADATA.volvo.ia_Alert as ia on ia.id = a.idx
where 
a.timestamp < @startdate 
AND
a.Subgroup LIKE '%OKREQ%' 
and 
@getAlerts = 1
--************************************************************************************--


--************************************************************************************--
--shiftbook (binnen dt range)
--************************************************************************************--
UNION
SELECT 
  sb.location 
, sb.AssetID 
, sb.Logtype
, sb.[timestamp] 
, sb.[Logcode] 
, sb.logtext 
 + ISNULL(' |info: ' + CAST(REPLACE(sb2.userComment,'***************************','=>') as varchar(8000)),'')  
 + ISNULL(char(10) + ' |WO: ' + CAST(sb2.wo as varchar(10)),'') as 'logtext'
, NULL
, NULL 
, NULL
, sb.Subgroup
, sb.refId 

FROM Gadata.volvo.Shiftbook as sb 
left join GADATA.volvo.hShiftbook sb2 on sb2.id = sb.refid
where 
sb.timestamp between @StartDate and @EndDate 
and 
@getShifbook = 1
--************************************************************************************--

--************************************************************************************--
--shiftbook (open buiten dt range)
--************************************************************************************--
UNION
SELECT 
  sb.location 
, sb.AssetID 
, sb.Logtype
, sb.[timestamp] 
, sb.[Logcode] 
, sb.logtext 
 + ISNULL(' |info: ' + CAST(REPLACE(sb2.userComment,'***************************','=>') as varchar(8000)),'')  
 + ISNULL(char(10) + ' |WO: ' + CAST(sb2.wo as varchar(10)),'') as 'logtext'
, NULL
, NULL 
, NULL
, sb.Subgroup
, sb.refId 

FROM Gadata.volvo.Shiftbook as sb 
left join GADATA.volvo.hShiftbook sb2 on sb2.id = sb.refid
where 
sb.timestamp < @StartDate
AND 
sb.Subgroup not like '%COMP%'
and 
@getShifbook = 1
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
, getdate() as  'timestamp'
, null
, '   |@minDowntime = ' + CAST(@minDowntime as varchar(5)) +
  '   |@minCountOfDowtime = ' + CAST(@minCountOfDowtime as varchar(5)) + 
  '   |@minCountofWarning = ' + CAST(@minCountofWarning as varchar(5)) 
as 'Logtekst'
, null 
, null
, null
, '<= last refresh' as 'subgroup'
, null
--************************************************************************************--

) as output 

--set sort
ORDER BY output.timestamp desc
END