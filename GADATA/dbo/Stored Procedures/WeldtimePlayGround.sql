

CREATE PROCEDURE [dbo].[WeldtimePlayGround]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null


AS
BEGIN

--current data
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#SpotParms') is not null) drop table #SpotParms
BEGIN
SELECT 
 wp.*
,TPN.Name
INTO #SpotParms
FROM GADATA.dbo.WeldParameters as wp
left join GADATA.dbo.TimerParameterName as TPN on TPN.id = WP.ParameterNameID 
WHERE 
--parms allowed 
TPN.id in(49,50,59,66,69,70,131,132,185,154)
END
---------------------------------------------------------------------------------------

--old data
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#OLDSpotParms') is not null) drop table #OLDSpotParms
BEGIN
SELECT x.* INTO #OLDSpotParms FROM
(
SELECT 
 SDC.*
,TPN.Name
,ROW_NUMBER() OVER (PARTITION BY SDC.spotid, SDC.parameterID ORDER BY SDC.[datetime] ASC) AS 'rnAsc'
--olders parm will have value 1
FROM GADATA.dbo.SpotDataChange as SDC
left join GADATA.dbo.TimerParameterName as TPN on TPN.id = SDC.ParameterID
WHERE 
--parms allowed 
TPN.id in(49,50,59,66,69,70,132,185)
--AND 
-- SDC.[DateTime] > '2014-01-01 00:00:00'
) as x 
where x.rnAsc = 1
END
---------------------------------------------------------------------------------------


--current data
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#CURRENTSpotParmsJoined') is not null) drop table #CURRENTSpotParmsJoined
SELECT DISTINCT
  timer.Name as 'Timer'
, SPidx.SpotID as 'SpotID'
, parm1.Value as '1.WeldTime' 
, parm2.Value as '1.CoolTime'  
, parm3.Value as '2.weldtime'
, parm4.value as '2.cooltime'   
, parm5.value as '3.weldtime'
, parm6.value as '3.cooltime'
, parm7.value as 'holdtime'
, parm8.value as 'squeezetime'
, parm10.initial_weldtime as 'initial_weldtime'
,CASE  
     WHEN parm9.SpotID is not null THEN  'JA'   
     ELSE 'NENE' 
 END as 'Drukprofiel'  
,TotalTime = (parm1.Value 
+ parm2.Value 
+ parm3.Value 
+ parm4.value 
+ parm5.value 
+ parm6.value 
+ parm7.value 
+ parm8.value)

INTO #CURRENTSpotParmsJoined                                                                                                                      
FROM #SpotParms as SPidx
left join GADATA.dbo.spot on spot.ID = SPidx.SpotID
left join GADATA.dbo.timer on timer.ID = spot.TimerID 
--eerste parm '1. Weld Time'
left join #SpotParms as parm1 on 
parm1.SpotID = SPidx.SpotID 
AND
parm1.ParameterNameID = 49 
--

--tweede  parm 'cooltime 1'
left join #SpotParms as parm2 on 
parm2.SpotID = SPidx.SpotID 
AND
parm2.ParameterNameID = 50
--

--derde parm 'weldtime 2'
left join #SpotParms as parm3 on 
parm3.SpotID = SPidx.SpotID 
AND
parm3.ParameterNameID = 59
--

-- vierde parm 'cooltime2'
left join #SpotParms as parm4 on 
parm4.SpotID = SPidx.SpotID 
AND
parm4.ParameterNameID = 185
--

-- vijfde parm 'weldtime3'
left join #SpotParms as parm5 on 
parm5.SpotID = SPidx.SpotID 
AND
parm5.ParameterNameID = 69
--

--zesde parm 'cooltime3'
left join #SpotParms as parm6 on 
parm6.SpotID = SPidx.SpotID 
AND
parm6.ParameterNameID = 132
--

--zevende parm 'holdtime'
left join #SpotParms as parm7 on 
parm7.SpotID = SPidx.SpotID 
AND
parm7.ParameterNameID = 70
--

--achtste parm 'squeezetime'
left join #SpotParms as parm8 on 
parm8.SpotID = SPidx.SpotID 
AND
parm8.ParameterNameID = 66

--9 druk profiel 
left join #SpotParms as parm9 on 
parm9.SpotID = SPidx.SpotID 
AND
parm9.ParameterNameID in(131,154)
AND
parm9.value <> 0

--10 lijst origineel waarde Patrick
left join GADATA.dbo.Initial_weldtime$ as parm10 on 
parm10.Spotnr = SPidx.SpotID 

order by SPidx.SpotID asc
---------------------------------------------------------------------------------------

--OLD data
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#OLDSpotParmsJoined') is not null) drop table #OLDSpotParmsJoined
SELECT DISTINCT
  timer.Name as 'Timer'
, SPidx.SpotID as 'SpotID'
, parm1.OldValue as '1.WeldTime' 
, parm2.OldValue as '1.CoolTime'  
, parm3.OldValue as '2.weldtime'
, parm4.OldValue as '2.cooltime'   
, parm5.OldValue as '3.weldtime'
, parm6.OldValue as '3.cooltime'
, parm7.OldValue as 'holdtime'
, parm8.OldValue as 'squeezetime'
INTO #OLDSpotParmsJoined                                                                                                                       
FROM #OLDSpotParms as SPidx
left join GADATA.dbo.spot on spot.ID = SPidx.SpotID
left join GADATA.dbo.timer on timer.ID = spot.TimerID 
--eerste parm '1. Weld Time'
left join #OLDSpotParms as parm1 on 
parm1.SpotID = SPidx.SpotID 
AND
parm1.ParameterID = 49 
--

--tweede  parm 'cooltime 1'
left join #OLDSpotParms as parm2 on 
parm2.SpotID = SPidx.SpotID 
AND
parm2.ParameterID = 50
--

--derde parm 'weldtime 2'
left join #OLDSpotParms as parm3 on 
parm3.SpotID = SPidx.SpotID 
AND
parm3.ParameterID = 59
--

-- vierde parm 'cooltime2'
left join #OLDSpotParms as parm4 on 
parm4.SpotID = SPidx.SpotID 
AND
parm4.ParameterID = 185
--

-- vijfde parm 'weldtime3'
left join #OLDSpotParms as parm5 on 
parm5.SpotID = SPidx.SpotID 
AND
parm5.ParameterID = 69
--

--zesde parm 'cooltime3'
left join #OLDSpotParms as parm6 on 
parm6.SpotID = SPidx.SpotID 
AND
parm6.ParameterID = 132
--

--zevende parm 'holdtime'
left join #OLDSpotParms as parm7 on 
parm7.SpotID = SPidx.SpotID 
AND
parm7.ParameterID = 70
--

--achtste parm 'squeezetime'
left join #OLDSpotParms as parm8 on 
parm8.SpotID = SPidx.SpotID 
AND
parm8.ParameterID = 66

order by SPidx.SpotID asc
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#history') is not null) drop table #history
BEGIN
select DISTINCT
active.*
,isnull(old.[1.WeldTime],active.[1.WeldTime]) as [orignal1.WeldTime]
,isnull(old.[1.CoolTime],active.[1.CoolTime]) as [orignal1.CoolTime]
,isnull(old.[2.weldtime],active.[2.weldtime]) as [orignal2.weldtime] 
,isnull(old.[2.CoolTime],active.[2.cooltime]) as [orignal2.cooltime]
,isnull(old.[3.weldtime],active.[3.WeldTime]) as [orignal3.WeldTime]
,isnull(old.[3.cooltime],active.[3.cooltime]) as [orignal3.cooltime]
,isnull(old.holdtime,active.holdtime) as orignalholdtime
,isnull(old.squeezetime,active.squeezetime) as orignalsqueezetime
,OrignalTotalTime = (
+isnull(old.[1.WeldTime],active.[1.WeldTime])
+isnull(old.[1.CoolTime],active.[1.CoolTime]) 
+isnull(old.[2.weldtime],active.[2.weldtime]) 
+isnull(old.[2.CoolTime],active.[2.cooltime]) 
+isnull(old.[3.weldtime],active.[3.WeldTime]) 
+isnull(old.[3.cooltime],active.[3.cooltime]) 
+isnull(old.holdtime,active.holdtime) 
+isnull(old.squeezetime,active.squeezetime) 
)
into #history
FROM #CURRENTSpotParmsJoined as active
left join #OLDSpotParmsJoined as old on old.SpotID = active.SpotID
END
---------------------------------------------------------------------------------------

/*
--resultaat 1
--totaal beeld 
select DISTINCT 
*
,verhogingMS =  x.TotalTime - x.OrignalTotalTime
,verhogingMSinitial = x.TotalTime - x.initial_weldtime
from #history as x 


--resutaat 2
--deltas 

select DISTINCT
x.Timer
,x.SpotID
,x.TotalTime as 'currentWeldTime'
,X.OrignalTotalTime as 'orignalTotaltime'
,verhogingMS =  x.TotalTime - x.OrignalTotalTime
,verhogingMSinitial = x.TotalTime - x.initial_weldtime
from #history as x
*/

--resultaat 3 
-- per timer 
select DISTINCT
x.Timer
,SUM(x.TotalTime) as 'currentWeldTime'
,SUM(X.OrignalTotalTime) as 'orignalTotaltime'
,SUM(x.initial_weldtime) as 'InititalTotaltime'
,SUM(x.TotalTime - x.OrignalTotalTime) as 'verhogingMS'
,SUM(x.TotalTime - x.initial_weldtime) as 'verhogingMSinitial'
from #history as x
group by x.Timer

END