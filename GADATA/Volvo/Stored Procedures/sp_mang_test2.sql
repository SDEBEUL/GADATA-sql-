
CREATE PROCEDURE [Volvo].[sp_mang_test2]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null
AS
BEGIN


---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------

SET @EndDate = getdate()
SET @StartDate = '2015-11-01 00:00:00.000' -- getdate()-80
---------------------------------------------------------------------------------------
--first we need to build a preselect tabel that contains the nuber of robot or appl insances per zone.
--this is 
--A to fix a performance issue
--B make sure we do not make any grouping faults (because the data has to FIRST union from the 2 schemas and THEN group)
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#tCountedRobots') is not null) drop table #tCountedRobots

SELECT 
 x.id
,x.Plant
,x.Area
,x.Location 
,x.controller_name
,x.generation
,y.RobotsInZone
INTO #tCountedRobots
FROM
(
select * from GADATA.C3G.c_controller
UNION
select * from GADATA.C4G.c_controller
) as x 

left join 
(select 
 robots.location
,count(*) as 'RobotsInZone'
from 
(
select * from GADATA.c3g.c_controller
UNION
SELECT * from GADATA.c4g.c_controller
) as robots
GROUP BY location) as y 
on y.location = x.location
---------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------
--c3g and C4g 
-------------------------------------------------------------------------------------------------------------------------------
SELECT 
 x.Plant
,x.Area as 'zone'
,x.Location
,x.RobotsInZone
,x.Year
,x.QUARTER
,datepart(month,x.StartOfBreakdown) as 'month'
,x.Week
,min(x.StartOfBreakdown) as 'dtRef'
,ROUND((SUM(CAST(x.DownTs as float))),2) as 'SumOfDtM'  
,ROUND((SUM(CAST(x.DownTs as float))) / x.RobotsInZone,2) As 'SumofDtM/CountRobotInZone'
,Count(x.Downts) as 'CountOfDt'
,ROUND(Count(CAST(x.Downts as float)) / x.RobotsInZone,2) as 'CountofDt/CountRobotInZone' 
,ROUND((Avg(CAST(x.downts as float))),2) as 'AvgofDtM'
,ROUND((SUM(CAST(x.ResponseT as float)) ),2)as 'SumOfRespM'  
,ROUND((SUM(CAST(x.ResponseT as float))) / x.RobotsInZone,2) As 'SumofRespM/CountRobotInZone'
,ROUND((Avg(CAST(x.ResponseT as float))),2) as 'AvgofRespM'
,ROUND((SUM(CAST(x.ReolveT as float))),2) as 'SumOfResoM'  
,ROUND((SUM(CAST(x.ReolveT as float))) / x.RobotsInZone,2) As 'SumofResoM/CountRobotInZone'
,ROUND((Avg(CAST(x.ReolveT as float))),2) as 'AvgofResoM'
FROM (

--SELECT * FROM(
---------------------------------------------------------------------------------------
--c4g 
---------------------------------------------------------------------------------------
SELECT 
  c.Plant
, isnull(c.Area, 'tbt') as 'Area'
, c.Location 
, c.RobotsInZone
, T.Vyear AS 'Year'
, DATEPART(QUARTER, H.StartOfBreakdown) as 'QUARTER'
, T.Vweek AS 'Week'
, DATEDIFF(SECOND, H.StartOfBreakdown, H.EndOfBreakdown) AS 'DownTs'
, DATEDIFF(SECOND,'1900-01-01 00:00:00.00',H.Rt) as 'ResponseT' --response en resolve tijden direct meenemen om LDB content te houden.... 
, DATEDIFF(SECOND,(H.StartOfBreakdown +  H.Rt),H.EndOfBreakdown) as 'ReolveT'
, h.StartOfBreakdown
, l.error_text
FROM   GADATA.C4G.h_breakdown as H 
INNER JOIN #tCountedRobots as C ON H.controller_id = c.id and c.generation = 4
--join L_error (normal cause)
LEFT OUTER JOIN GADATA.C4G.L_error  AS L ON 
L.id = H.error_id 
--appl (normal cause)
LEFT OUTER JOIN
GADATA.C4g.c_Appl as LA ON (LA.id =L.Appl_id) 
 LEFT OUTER JOIN
gadata.c4g.C_subgroup as LS ON (LS.id = L.subgroup_id) 
--timeline						 --
LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
H.EndOfBreakdown BETWEEN T.starttime AND T.endtime

where
(LS.subgroup NOT LIKE '%Gate/Hold%') --geen gatestops (enkel rootcause storingen gebruiken)
AND
(LS.subgroup NOT LIKE '%Water%') --koelwaterfouten eraf. (opstart)
AND
(T.ploeg NOT LIKE 'WE') --niet in weekend
AND
((H.EndOfBreakdown - H.StartOfBreakdown) < '1900-01-01 03:00:00.00') --storingen meer dan X uur eraf. (ook weekend probs)
AND
(H.StartOfBreakdown BETWEEN  @StartDate and @EndDate)
AND
(H.StartOfBreakdown < H.EndOfBreakdown)
AND 
(c.location  LIKE '%%') --locatie moet gekend zijn 
AND 
(c.Area is not null)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--c3g 
---------------------------------------------------------------------------------------
UNION
SELECT 
  c.Plant
, isnull(c.Area, 'tbt') as 'Area'
, c.Location 
, c.RobotsInZone
, T.Vyear AS 'Year'
, DATEPART(QUARTER, H.StartOfBreakdown) as 'QUARTER'
, T.Vweek AS 'Week'
, DATEDIFF(SECOND, H.StartOfBreakdown, H.EndOfBreakdown) AS 'DownTs'
, DATEDIFF(SECOND,'1900-01-01 00:00:00.00',H.Rt) as 'ResponseT' --response en resolve tijden direct meenemen om LDB content te houden.... 
, DATEDIFF(SECOND,(H.StartOfBreakdown +  H.Rt),H.EndOfBreakdown) as 'ReolveT'
, h.StartOfBreakdown
, L.error_text
FROM   GADATA.C3G.h_breakdown as H 
INNER JOIN #tCountedRobots as C ON H.controller_id = c.id and c.generation = 3
--join L_error (normal cause)
LEFT OUTER JOIN GADATA.C3G.L_error  AS L ON 
L.id = H.error_id 
--appl (normal cause)
LEFT OUTER JOIN
GADATA.C3G.c_Appl as LA ON (LA.id =L.Appl_id) 
--subgroup (normal cause)
 LEFT OUTER JOIN
gadata.C3G.C_subgroup as LS ON (LS.id = L.subgroup_id) 
--timeline						 --
LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
H.EndOfBreakdown BETWEEN T.starttime AND T.endtime

where
(LS.subgroup NOT LIKE '%Gate/Hold%') --geen gatestops (enkel rootcause storingen gebruiken)
AND
(LS.subgroup NOT LIKE '%Water%') --koelwaterfouten eraf. (opstart)
AND
(LA.APPL NOT LIKE '%N/A%') --niet gekende objecten weg
AND
(T.ploeg NOT LIKE 'WE') --niet in weekend
AND
(LA.APPL NOT LIKE 'Database%')
AND
((H.EndOfBreakdown - H.StartOfBreakdown) < '1900-01-01 03:00:00.00') --storingen meer dan X uur eraf. (ook weekend probs)
AND
(H.StartOfBreakdown BETWEEN  @StartDate and @EndDate)
AND
(H.StartOfBreakdown < H.EndOfBreakdown)
AND 
(c.location  LIKE '%%') --locatie moet gekend zijn 
AND 
(c.Area is not null)
---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
) as x 

WHERE x.week not in(53) -- domme week 53 


GROUP BY 
  x.plant
, x.area
, x.location 
, x.RobotsInZone
, x.year 
, x.QUARTER
, x.week 
,datepart(month,x.StartOfBreakdown)
END