
CREATE PROCEDURE [EqUi].[AAOSR_PloegRaport]

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
       @minCountofWarning as int = 4
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
SET @startdate = @enddate -'1900-01-02 8:00:00' -- will force 3 last shifts and the active on.
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


--************************************************************************************--
---shift report (template)
--************************************************************************************--
SELECT 
--asset
  output.Robotname       AS 'Location' 
, A.CLassificationId		as 'AssetID'
--log part
, output.Logcode		As 'Logcode'
, output.ErrorType		AS 'Logtype'
, output.Logtekst		AS 'logtext'
, output.Downtime		AS 'Downtime'
, output.count			As 'Count'
--date time part
, CONVERT(char(19),output.timestamp, 120) AS 'timestamp' --cast to timeformat excel likes 
, rtrim(output.Object)+'*'	AS 'Classification'
, output.Subgroup		AS 'Subgroup'
--extra 
, output.IDX		    AS 'refId'
, a.LocationTree   As 'LocationTree'
, a.ClassificationTree		As 'ClassTree'

FROM
(
--************************************************************************************--
--c4g breakdown
--************************************************************************************--
SELECT * FROM
(
SELECT        
  c4gb.location 
, c4gb.Robotname 
, c4gb.ErrorType
, min(timestamp) AS 'timestamp'
, min(c4gb.[Logcode]) as 'Logcode'
, min(c4gb.Logtekst) as 'Logtekst'
, SUM(downtime) AS 'Downtime'
, count(c4gb.downtime) AS 'Count'
, c4gb.Object
, c4gb.Subgroup
, min(c4gb.idx) as 'idx'

FROM GADATA.C4G.Breakdown as c4gb

WHERE 
--target
c4gb.timestamp between @startdate and @endDate
AND
c4gb.downtime < (8*60) -- just filter out bullshit 
--filter
AND 
c4gb.Subgroup not like 'Gate/Hold%'
AND 
C4gb.Logtekst not like '%tips have been changed%'
GROUP BY 
 c4gb.location 
,c4gb.Robotname 
,c4gb.ErrorType
,c4gb.Year
,c4gb.Week
,c4gb.day
,c4gb.shift
,c4gb.Object
,c4gb.Subgroup
--************************************************************************************--

--************************************************************************************--
--c3g breakdown
--************************************************************************************--
UNION
SELECT        
  c3gb.location 
, c3gb.Robotname 
, c3gb.ErrorType
, min(timestamp) AS 'timestamp'
, min(c3gb.[Logcode]) as 'Logcode'
, min(c3gb.Logtekst) as 'Logtekst'
, SUM(downtime) AS 'Downtime'
, count(c3gb.downtime) AS 'Count'
, c3gb.Object
, c3gb.Subgroup
, min(c3gb.idx) as 'idx'

FROM GADATA.c3g.Breakdown as c3gb

WHERE 
--target
c3gb.timestamp between @startdate and @endDate
--filter
AND 
(
(
c3gb.Subgroup not like 'Gate/Hold%'
AND
c3gb.Subgroup not like 'Maint%'
AND 
c3gb.Logtekst not like '%Maint mode%'
AND
c3gb.Logtekst not like '%(SS)%' 
)

)
GROUP BY 
 c3gb.location 
,c3gb.Robotname 
,c3gb.ErrorType
,c3gb.Year
,c3gb.Week
,c3gb.day
,c3gb.shift
,c3gb.Object
,c3gb.Subgroup

) as x
--set report filter
where 
x.Count > @minCountOfDowtime
OR
x.Downtime > @minDowntime
--************************************************************************************--

--************************************************************************************--
--c4g warning
--************************************************************************************--
UNION
SELECT * FROM (
SELECT        
  c4gW.location 
, c4gW.Robotname 
, 'WARNING' as 'ErrorType'
, min(c4gW.timestamp) AS 'timestamp'
, min(c4gW.[Logcode]) as 'Logcode'
, min(c4gW.Logtekst) as 'Logtekst'
, NULL AS 'Downtime'
, count(c4gW.Logcode) AS 'Count'
, c4gW.Object
, c4gW.Subgroup
, min(c4gw.idx) as 'idx'

FROM GADATA.C4G.Error as c4gW
WHERE 
--target
c4gW.timestamp between @startdate and @endDate
AND 
c4gw.Severity < 4 --enkel warnings 
--filter
AND
c4gW.Subgroup not like 'N/A%'
AND
c4gw.Subgroup not like 'Gate/Hold%'
AND
c4gw.object not like 'Plc%'
AND
c4gw.Subgroup not like 'global%'
AND
c4gw.subgroup not like 'Manual%'
AND
c4gw.subgroup not like 'Rack%'
AND 
c4gw.Subgroup not like 'Cube%'
GROUP BY 
 c4gW.location 
,c4gW.Robotname
,C4Gw.Errortype
,c4gW.Year
,c4gW.Week
,C4Gw.day
,c4gW.shift
,c4gW.Object
,c4gW.Subgroup
) as y 
where
y.Count > @minCountofWarning
--************************************************************************************--

--************************************************************************************--
--c3g warning
--************************************************************************************--
UNION
SELECT * FROM 
(
SELECT        
  c3gW.location 
, c3gW.Robotname 
, 'WARNING' as 'ErrorType'
, min(c3gW.timestamp) AS 'timestamp'
, min(c3gW.[Logcode]) as 'Logcode'
, min(c3gW.Logtekst) as 'Logtekst'
, NULL AS 'Downtime'
, count(c3gW.Logcode) AS 'Count'
, c3gW.Object
, c3gW.Subgroup
, min(c3gw.idx) as 'idx'

FROM GADATA.C3G.Error as c3gW
WHERE 
--target
c3gW.timestamp between @startdate and @endDate
AND 
c3gw.Severity < 4 --enkel warnings 
--filter
AND
c3gW.Subgroup not like 'N/A%'
AND
c3gw.object not like 'Plc%'
AND
c3gw.Subgroup not like 'global%'
AND
c3gw.subgroup not like 'Appl%'
AND
c3gw.subgroup not like 'Manual%'

GROUP BY 
 c3gW.location 
,c3gW.Robotname 
,c3gW.ErrorType
,c3gW.Year
,c3gW.Week
,c3gW.day
,c3gW.shift
,c3gW.Object
,c3gW.Subgroup
) as y 
where
y.Count > @minCountofWarning
--***********************************************************************************--

--************************************************************************************--
--Alerts (binnen dt range)
--************************************************************************************--
UNION
SELECT 
  a.location 
, a.Robotname 
, a.ErrorType
, a.timestamp
, null as 'Logcode'
, a.Logtekst +ISNULL(' |info: ' +CAST(REPLACE(ia.User_Comment,'***************************',' => ') as varchar(600)),'') as 'Logtekst'
, a.Dowtime
, NULL as 'count'
, a.Object
, a.Subgroup
, a.idx

FROM GADATA.volvo.Alerts as a 
left join GADATA.volvo.ia_Alert as ia on ia.id = a.idx
where a.timestamp between @startdate and @endDate

--************************************************************************************--

--************************************************************************************--
--Alerts (openstaand BUTIEN dt range)
--************************************************************************************--
UNION
SELECT 
  a.location 
, a.Robotname 
, a.ErrorType
, a.timestamp
, null as 'Logcode'
, a.Logtekst +ISNULL(' |info: ' +CAST(ia.User_Comment as varchar(600)),'') as 'Logtekst'
, a.Dowtime
, NULL as 'count'
, a.Object
, a.Subgroup
, a.idx
FROM GADATA.volvo.Alerts as a 
left join GADATA.volvo.ia_Alert as ia on ia.id = a.idx
where 
a.timestamp < @startdate 
AND
a.Subgroup LIKE '%OKREQ%' 
--************************************************************************************--

--************************************************************************************--
--shiftbook (binnen dt range)
--************************************************************************************--
UNION
SELECT 
  sb.location 
, sb.Robotname 
, sb.ErrorType
, sb.timestamp
, null as 'Logcode'
, sb.Logtekst 
 + ISNULL(' |info: ' + CAST(REPLACE(sb2.userComment,'***************************','=>') as varchar(8000)),'')  
 + ISNULL(char(10) + ' |WO: ' + CAST(sb2.wo as varchar(10)),'') as 'Logtekst'
, sb.Downtime
, NULL as 'count'
, sb.Object
, sb.Subgroup
, sb.idx
FROM Gadata.volvo.Shiftbook as sb 
left join GADATA.volvo.hShiftbook sb2 on sb2.id = sb.idx
where 
sb.timestamp between @StartDate and @EndDate 
--************************************************************************************--

--************************************************************************************--
--shiftbook (open buiten dt range)
--************************************************************************************--
UNION
SELECT 
  sb.location 
, sb.Robotname 
, sb.ErrorType
, sb.timestamp
, null as 'Logcode'
, sb.Logtekst + ISNULL(' |info: ' + CAST(REPLACE(sb2.userComment,'***************************','=>') as varchar(8000)),'')  as 'Logtekst'
, sb.Downtime
, NULL as 'count'
, sb.Object
, sb.Subgroup
, sb.idx
FROM Gadata.volvo.Shiftbook as sb 
left join GADATA.volvo.hShiftbook as sb2 on sb2.id = sb.idx
where 
sb.timestamp < @StartDate
AND 
sb.Subgroup not like '%COMP%'
--************************************************************************************--


--************************************************************************************--
--timeline
--************************************************************************************--
UNION
SELECT 
  t.location 
, t.Robotname 
, 'TIMELINE' as 'ErrorType'
, t.timestamp
, null as 'Logcode'
, 'ShiftRap for:  ' + cast(t.Year as varchar(4)) + 'W' + cast(t.Week as varchar(2)) + 'D' + cast(t.day as varchar(1)) + '   | above here starts the ' + t.Ploeg + ' shift' as 'Logtekst'
, t.downtime
, t.id as 'count'
, t.Object
, t.Subgroup
, null as 'idx'
FROM GADATA.volvo.Timeline as t where t.timestamp between @startdate and @endDate
--************************************************************************************--
) as output 

--joining of the RIGHT ASSET
LEFT OUTER JOIN equi.ASSETS as A on 
A.controller_type in('c3g','c4g') 
AND
A.LOCATION = output.Robotname

--set sort
ORDER BY output.timestamp desc
END