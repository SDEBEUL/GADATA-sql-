CREATE PROCEDURE [C4G].[sp_prepState]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @RobotFilterWild as varchar(10) = '%',
   @LocationFilterWild as varchar(10) = '%'
AS
BEGIN


---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------

--to index sys event table based on time and robotid 
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#SysEventIdx') is not null) drop table #SysEventIdx
	SELECT *,
		 ROW_NUMBER() OVER (PARTITION BY x.controller_id ORDER BY x._timestamp DESC) AS rnDESC
		 INTO #SysEventIdx FROM 
	(
			--data from rt_sys_event table. 
			SELECT 
				rt_sys_event.id,
				rt_sys_event.controller_id,
				rt_sys_event._timestamp,
				rt_sys_event.sys_state,
				robotState = dbo.fn_robstate(rt_sys_event.sys_state) --calculates a robot state a running robot has 2 a non running one 0 
			FROM  GADATA.dbo.rt_sys_event  AS rt_sys_event
			WHERE rt_sys_event._timestamp  BETWEEN @StartDate AND @EndDate
	
	
			--data from L_operation (to catch robots goning offline)
			UNION
			SELECT 
				l_operation.id,
				l_operation.controller_id,
				l_operation._timestamp,
				sys_state = 262144, 
				robotState = 0
			FROM GADATA.dbo.l_operation AS l_operation
			WHERE (l_operation._timestamp  BETWEEN @StartDate AND @EndDate AND (l_operation.code = 4)) --connection lost 
	) AS x 
	
---------------------------------------------------------------------------------------
--to calculate time in state for each event. (passed events)
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#SysEventPast') is not null) drop table #SysEventPast
       SELECT 
         #SysEventIdx.id,
         #SysEventIdx.controller_id,
         #SysEventIdx._timestamp,
         #SysEventIdx.sys_state,
         #SysEventIdx.rnDESC,
         TimeInState = SyseventOffs._timestamp - #SysEventIdx._timestamp,  
         #SysEventIdx.robotState
       INTO #SysEventPast
       FROM #SysEventIdx
       
    JOIN    #SysEventIdx AS SyseventOffs 
    ON (#SysEventIdx.rnDESC = SyseventOffs.rnDESC + 1)  
              AND 
              (#SysEventIdx.controller_id = SyseventOffs.controller_id) 
              AND 
              (#SysEventIdx.rnDESC <> 1)

---------------------------------------------------------------------------------------
--SysEventIdx with rownumbers 1 to calc TimeInState (active event)
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#SysEventLive') is not null) drop table #SysEventLive
       (
       SELECT 
         #SysEventIdx.id,
         #SysEventIdx.controller_id,
         #SysEventIdx._timestamp,
         #SysEventIdx.sys_state,
         #SysEventIdx.rnDESC,
         TimeInState = (GETDATE()-#SysEventIdx._timestamp),
         #SysEventIdx.robotState
       INTO #SysEventLive
       FROM #SysEventIdx
   WHERE (#SysEventIdx.rnDESC = 1)
       )
---------------------------------------------------------------------------------------
--SysEventPast UNION with the SysEventLive table. (ongoing and past events)
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#SysEventTime') is not null)  DROP TABLE #SysEventTime
       select * into #SysEventTime from (
		   SELECT * FROM #SysEventPast
		   UNION 
		   SELECT * FROM #SysEventLive
       ) as x

---------------------------------------------------------------------------------------
--Select robot id's into table that are in an active breakdown 
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#BadRobots') is not null)  DROP TABLE #BadRobots
SELECT 
#SysEventTime.controller_id
, 'C4G|' as 'robstate' 
into #BadRobots FROM #SysEventTime
WHERE 
--robot that are down now
(
#SysEventTime.rnDESC = 1 
AND 
#SysEventTime.robotState = 0
AND 
#SysEventTime.controller_id NOT IN(4,5)
)
--robot that are in a running breakdown
OR
(
#SysEventTime.rnDESC = 1 
AND 
#SysEventTime.robotState = 2
AND
#SysEventTime.TimeinState < '1900-01-01 00:03:00.00'
AND 
#SysEventTime.controller_id NOT IN(4,5)
)
	  
---------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Qry Sys events 
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

SELECT  
              c_controller.location AS 'Location',
			  c_controller.controller_name AS 'Robotname',
              'C4G' AS 'Type',
			  'EVENT' AS 'Errortype',
			  convert(char(19),SysEventTime._timestamp,120) AS 'Timestamp',
              NULL AS 'Logcode',
              CAST(dbo.fn_robstate(SysEventTime.Sys_state) AS varchar(2)) AS 'Severity',
              'Time: ' + convert(Char(8),SysEventTime.timeinstate,108) + '  Code: ' + CAST(SyseventTime.Sys_state AS varchar) +   '  SysState: ' + (dbo.fn_decodeSysstate(SysEventTime.Sys_state)) AS 'Logtekst', --+ '  Code: ' + (CAST(SyseventTime.Sys_state) AS String) 
              NULL AS 'Downtime',
              DATEPART(YEAR, SysEventTime._timestamp) AS 'Year',
			  DATEPART(WEEK,SysEventTime._timestamp) AS 'Week',
			  GADATA.dbo.fn_volvoday(SysEventTime._timestamp,CAST(SysEventTime._timestamp AS time)) AS 'Day',
			  --DATEPART(WEEKDAY,SysEventTime._timestamp)AS 'Day',
			  GADATA.dbo.fn_volvoshift1(SysEventTime._timestamp,CAST(SysEventTime._timestamp AS time)) AS 'Shift',
			  NULL  AS 'Object',
			  NULL AS 'Subgroup',
              CAST(SysEventTime.rndesc AS int) AS 'idx'
			  

FROM    #SysEventTime AS SysEventTime 
--join the controller name
JOIN    c_controller ON (SysEventTime.controller_id = c_controller.id) 

--robot name filter 
WHERE  
(c_controller.controller_name LIKE @RobotFilterWild)
--Location Filter
AND
(ISNULL(c_controller.location,'') LIKE @LocationFilterWild )


---------------------------------------------------------------------------------------

ORDER BY   Timestamp DESC 

END