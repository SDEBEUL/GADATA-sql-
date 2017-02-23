


CREATE PROCEDURE [GLUE].[sp_GADATAGLUEcockpit6]
--timeparameters
   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @Teamstername as varchar(25) = null
AS
BEGIN

---------------------------------------------------------------------------------------
--Set default values of start and end date
---------------------------------------------------------------------------------------
if ((@StartDate is null) OR (@StartDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @StartDate = GETDATE()-40
END

if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()
END

--pull parmater changes from view
SELECT 
 P.location
,P.robotname 
,P.ErrorType
,P.Timestamp
,P.Logtekst
,P.downtime
,P.year
,P.week
,P.day
,P.shift
,null as vultijd_s
,1 as 'parm'
,null as 'RefAVG'
,null as 'RefSTDEC'
,null as 'UCLnumber'
,null as 'UCL3'
,null as 'UCL4'
,null as 'UCL5'
,null as 'UCLx'
,null as 'RefDp'
,null as 'RefSS'
FROM [GADATA].[GLUE].[Operator_layoutRD3] as p
WHERE 
P.robotname like @Teamstername
AND
P.timestamp between @startdate and @EndDate


--pull breakdowns for teamster object from robot db for both C4G and c4g
UNION 
SELECT 
 b3.location
,b3.robotname 
,b3.ErrorType
,b3.Timestamp
,b3.Logtekst
,1 as 'downtime'
,b3.year
,b3.week
,b3.day
,b3.shift
,null as vultijd_s
,null as 'parm'
,null as 'RefAVG'
,null as 'RefSTDEC'
,null as 'UCLnumber'
,null as 'UCL3'
,null as 'UCL4'
,null as 'UCL5'
,null as 'UCLx'
,null as 'RefDp'
,null as 'RefSS'
FROM Gadata.c3g.breakdown as b3 
where 
b3.robotname like '%' + REPLACE(@Teamstername,'SH','R') + '%'
AND
b3.timestamp between @startdate and @EndDate
AND b3.object like '%GLUE%'
UNION 
SELECT 
 b4.location
,b4.robotname 
,b4.ErrorType
,b4.Timestamp
,b4.Logtekst
,1 as 'downtime'
,b4.year
,b4.week
,b4.day
,b4.shift
,null as vultijd_s
,null as 'parm'
,null as 'RefAVG'
,null as 'RefSTDEC'
,null as 'UCLnumber'
,null as 'UCL3'
,null as 'UCL4'
,null as 'UCL5'
,null as 'UCLx'
,null as 'RefDp'
,null as 'RefSS'
FROM Gadata.c4g.breakdown as b4
where 
b4.robotname like '%' + REPLACE(@Teamstername,'SH','R') + '%'
AND
b4.timestamp between @startdate and @EndDate
AND b4.object like '%GLUE%'

--join a timeline to make excel happy

/*
UNION
SELECT 
 T.location
,T.robotname 
,T.ErrorType
,T.Timestamp
,T.Logtekst
,T.downtime
,T.year
,T.week
,T.day
,T.shift
,null as 'filltime'
FROM GADATA.Volvo.Timeline AS T
WHERE
t.timestamp between @startdate and @enddate
*/
--join value of avg filltime for each shit.will need to change layout...

UNION

SELECT DISTINCT
 G.location as 'location'
,C.Name as 'Robotname'
,null as 'Errortype'
,D.c_timestamp as 'Timestamp'
,null as 'Logtekst'
,null as 'DOWNTIME'
,T.[vYear] as 'year'
,T.[vWeek] as 'week'
,T.[vday] as 'day'
,T.[Shift] as 'shift'
,CAST(ROUND(d.vultijd_ms/1000.0,5) AS DECIMAL(6,6)) as vultijd_s
,null as 'parm'
,ROUND(ref.avg,2) as 'RefAVG'
,ROUND(ref.Stdev,2) as 'RefSTDEC'
,ref.UCLnumber as 'UCLnumber'
,ROUND(ref.UCL3,2) as 'UCL3'
,ROUND(ref.UCL4,2) as 'UCL4'
,ROUND(ref.UCL5,2) as 'UCL5'
,ROUND(ref.UCLx,2) as 'UCLx'
,ref.nDataPoints as 'RefDp'
,ref.SampleStart as 'RefSS'

FROM [GADATA].[GLUE].[vultijden_viewers] AS D 
left join GADATA.glue.controller as C ON D.Controller_id = C.ID
left join glue.c_controller as G on G.controller_name=C.Name
LEFT OUTER JOIN GADATA.VOLVO.L_timeline AS T ON D.c_timestamp between t.starttime and t.endtime
left join GLUE.VULTIJDreferentie3 as ref on ref.Controller = C.Name
where
D.couten > 20 
AND 
D.vultijd_ms < 60000 
AND 
D.vultijd_ms > 100 
AND 
C.name like '%' + @Teamstername + '%'
AND
D.c_timestamp between @startdate and @EndDate

END