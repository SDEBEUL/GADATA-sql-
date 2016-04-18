CREATE PROCEDURE [Volvo].[LiveView]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @daysback as int = 1,
   @RobotFilterWild as varchar(10) = '%',
   @RobotFilterMaskStart as varchar(10) = '%',
   @RobotFilterMaskEnd as varchar(10) = '%',
   @LocationFilterWild as varchar(20) = '%'


AS
BEGIN
---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------
--update the L_breakdown table 
---------------------------------------------------------------------------------------
--EXEC dbo.sp_VCSC_C4G_Update_L_breakdown_A1 
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
				robotState = c4g.fn_robstate(rt_sys_event.sys_state) --calculates a robot state a running robot has 2 a non running one 0 
			FROM  GADATA.c4g.rt_sys_event  AS rt_sys_event
			WHERE rt_sys_event._timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())

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


--
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--Calculation of Start and stop events. (breakdown tags)
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------

--first filter all Events that the robot was in RUN for longer than a time X 'start events'
--then filter all Events that that robot was in Run and whent to a fault state. 
--!this will give false positives that will be handeld later. 'stop events'
--then partition and index the result (need this to filter the false positves later)
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#StartStopEvents') is not null) drop table #StartStopEvents
       (
       SELECT 
         #SysEventTime.id,
         #SysEventTime.controller_id,
         #SysEventTime._timestamp,
         #SysEventTime.sys_state,
         #SysEventTime.rnDESC,
         #SysEventTime.TimeInState, 
         #SysEventTime.robotState,
         CombinedRobstate = (#SysEventTime.Robotstate + 1),
         ROW_NUMBER() OVER (PARTITION BY #SysEventTime.controller_id ORDER BY #SysEventTime.id DESC) AS StartStopIndx
       into #StartStopEvents
       FROM #SysEventTime
    JOIN    #SysEventTime AS LSysEventTime 
    
       ON 
	   --start event (robot oke maar wacht op 3 min resolutie) = storing nog bezig 
	         (
			  (#SysEventTime.controller_id = LSysEventTime.controller_id) 
              AND
              (#SysEventTime.rnDESC = LSysEventTime.rnDESC) 
              AND 
              (#SysEventTime.rnDESC = 1 ) -- current rob state 
			  AND 
              (#SyseventTime.robotState = 2)
			 )
		OR
       --start event (robot terug oke na 3 min draaien) = Storing opgelost 
              (
			  (#SysEventTime.controller_id = LSysEventTime.controller_id) 
              AND
              (#SysEventTime.rnDESC = LSysEventTime.rnDESC) 
              AND 
              (#SysEventTime.TimeInState > CAST('1900-01-01 00:03:00.00' AS DATETIME))
			  AND 
              (#SyseventTime.robotState = 2)
              )
       OR
              (
       --stop events (alle nullen mogen door) - Begin van sotring 
              (#SysEventTime.controller_id = LSysEventTime.controller_id) 
              AND
              (#SysEventTime.rnDESC = LSysEventTime.rnDESC) 
			  AND
              (#SysEventTime.robotState = 0)
              )
              )
---------------------------------------------------------------------------------------
/*
result 
id	controller_id	_timestamp	sys_state	rnDESC	TimeInState	robotState	CombinedRobstate	StartStopIndx
2346040	7	2015-02-13 12:41:12.343	50331652	1	1900-01-01 00:04:24.940	2	3	1
2346020	7	2015-02-13 12:36:03.337	1090519040	3	1900-01-01 00:05:06.003	0	1	2
2346013	7	2015-02-13 12:35:00.337	1694629896	4	1900-01-01 00:01:03.000	0	1	3
2346009	7	2015-02-13 12:34:57.400	620888072	5	1900-01-01 00:00:02.937	0	1	4
2345996	7	2015-02-13 12:33:48.333	1090519040	8	1900-01-01 00:00:06.000	0	1	5
2345992	7	2015-02-13 12:32:27.333	1694629896	9	1900-01-01 00:01:21.000	0	1	6
2345988	7	2015-02-13 12:32:24.373	620888072	10	1900-01-01 00:00:02.960	0	1	7
2342233	7	2015-02-12 23:43:02.840	50331652	13	1900-01-01 12:48:54.493	2	3	8
2342226	7	2015-02-12 23:42:53.840	1090519040	15	1900-01-01 00:00:05.997	0	1	9
2342221	7	2015-02-12 23:42:20.840	1694629896	16	1900-01-01 00:00:33.000	0	1	10
*/
--SELECT * FROM #StartStopEvents  ORDER BY _timestamp desc  

--Filter the false positve breakdowns 
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#SysBreakDwn') is not null) drop table #SysBreakDwn
       (
       SELECT 
         #StartStopEvents.id,
         #StartStopEvents.controller_id,
         #StartStopEvents._timestamp,
         #StartStopEvents.sys_state,
         #StartStopEvents.rnDESC,
         #StartStopEvents.TimeInState, 
         #StartStopEvents.robotState,
         #StartStopEvents.CombinedRobstate,
         #StartStopEvents.StartStopIndx,
         ROW_NUMBER() OVER (PARTITION BY #StartStopEvents.controller_id ORDER BY #StartStopEvents.id DESC) AS SysBreakDwnIndx,
		 rt_alarm.error_text,
		 rt_alarm.error_number,
		 --ISNULL(rt_alarm.error_text,'No valid error match') as error_text,
		 --ISNULL(rt_alarm.error_number,'90004') as error_number,
		 rt_alarm.error_id
       INTO #SysBreakDwn
       FROM #StartStopEvents
    JOIN  #StartStopEvents AS LStartStopEvents 
    
       ON 
              (
       --Resolved event mogen gewoon door zonder filter 
              (#StartStopEvents.CombinedRobstate = 3)
              AND
              (#StartStopEvents.controller_id = LStartStopEvents.controller_id) 
              AND 
              (#StartStopEvents.rnDESC = LStartStopEvents.rnDESC) 
              ) 
       OR 
              (
       --Start of event mogen enkel door als ze gevolgd worden in de statstop index door een 3 (anders was de storing al bezig)
              (#StartStopEvents.controller_id = LStartStopEvents.controller_id) 
              AND
              (#StartStopEvents.rnDESC = LStartStopEvents.rnDESC - 1) 
			  AND 
			  (#StartStopEvents.CombinedRobstate = 1)
              AND
              (LStartStopEvents.CombinedRobstate = 3 )
              )
	  OR   
	     --storing nog bezig 
		      (
              (#StartStopEvents.controller_id = LStartStopEvents.controller_id) 
              AND
              (#StartStopEvents.rnDESC = LStartStopEvents.rnDESC - 1) 
			  AND 
			  (#StartStopEvents.rnDESC = 1)
              ) 

--zwaar gefoefel om via timestamp te proberen catchen welke error in rt_alarm het systeem down heeft getrokken	
	LEFT JOIN GADATA.c4g.rt_alarm as rt_alarm 
	   ON (
		(#StartStopEvents.controller_id = rt_alarm.controller_id) 
		AND
		((rt_alarm._timestamp - '1900-01-01 00:00:01.00')  < #StartStopEvents._timestamp)
	    AND 
		(rt_alarm._timestamp > (#StartStopEvents._timestamp - '1900-01-01 00:00:05.00')) --rt_alarm is normaal altijd net iets sneller dan Rt_sysevent. --was 1.90
	    AND
		(rt_alarm.error_severity <> 2) --filter 
		AND
        (#StartStopEvents.CombinedRobstate = 1) 
	    )
       )
---------------------------------------------------------------------------------------

--Filter the false positve breakdowns + nog eens een nieuwe inx de breakdown index om later de stroings tijd makkelijk te kunnen bepalen.
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#SysBreakDwnTime') is not null) drop table #SysBreakDwnTime
       (
       SELECT 
         #SysBreakDwn.id,
         #SysBreakDwn.controller_id,
         #SysBreakDwn._timestamp,
         ISNULL(LSysBreakDwn.sys_state,#SysBreakDwn.sys_state) AS 'sys_state', --pass the Lstate (this will be the state that triggerd the breakdown
         #SysBreakDwn.rnDESC,
         #SysBreakDwn.TimeInState, 
         #SysBreakDwn.robotState,
         #SysBreakDwn.CombinedRobstate,
         #SysBreakDwn.StartStopIndx,
         #SysBreakDwn.SysBreakDwnIndx,
		 isnull(LSysBreakDwn._timestamp, getdate()) AS 'OKtimestamp',
         DOWNTIME = DATEDIFF(MINUTE,isnull(LSysBreakDwn._timestamp,getdate()),#SysBreakDwn._timestamp),
		 ISnull(LSysBreakDwn.error_text,#SysBreakDwn.error_text) as 'error_text',
		 ISnull(LsysBreakDwn.error_id,#sysBreakDwn.error_id) as 'error_id',
		 ISnull(LSysBreakDwn.error_number,#SysBreakDwn.error_number) as 'error_number'
       INTO #SysBreakDwnTime
       FROM #SysBreakDwn
	LEFT JOIN  #SysBreakDwn AS LSysBreakDwn 
       ON 
              (
           (#SysBreakDwn.controller_id = LSysBreakDwn.controller_id) 
              AND 
              (#SysBreakDwn.SysBreakDwnIndx = LSysBreakDwn.SysBreakDwnIndx - 1)
              AND
              (#SysBreakDwn.CombinedRobstate = 3) 
              )
       )
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------
--********************************************************************************************************************************************--
--last robot status 'livelist'
--********************************************************************************************************************************************--
if (OBJECT_ID('tempdb..#L_operationHeartBeat') is not null) drop table #L_operationHeartBeat
BEGIN
SELECT 
*
,ROW_NUMBER() OVER (PARTITION BY y.controller_id ORDER BY y._timestamp DESC) AS rnDESC
 INTO #L_operationHeartBeat FROM 
(			--data from rt_sys_event table. 
			SELECT 
				rt_sys_event.id,
				rt_sys_event.controller_id,
				rt_sys_event._timestamp,
				rt_sys_event.sys_state,
				robotState = c4g.fn_robstate(rt_sys_event.sys_state) --calculates a robot state a running robot has 2 a non running one 0 
			FROM  GADATA.c4g.rt_sys_event  AS rt_sys_event
			WHERE rt_sys_event._timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())
) as Y
END

--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--Output qry 
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--c4g down right now 
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--if (OBJECT_ID('GADATA.VOLVO.L_liveView') is not null) drop table GADATA.VOLVO.L_liveView
DELETE GADATA.volvo.L_liveView FROM GADATA.volvo.L_liveView
INSERT INTO GADATA.VOLVO.L_liveView
SELECT *  FROM
(
SELECT 
              c_controller.location AS 'Location',
			  c_controller.controller_name AS 'Robot',
              'C4G' AS 'Type',
			  'LIVE' as 'Errortype',
              convert(char(19),#SysBreakDwnTime.oktimestamp,120) AS 'Timestamp',
              #SysBreakDwnTime.error_number AS 'Logcode',
              0 AS 'Severity',
			  'S: ' + GADATA.c4g.fn_decodeSysstate(#SysBreakDwnTime.sys_state)  + '  |T: '  + ISNULL(#SysBreakDwnTime.error_text,GADATA.C4G.fn_decodeSysstate(#SysBreakDwnTime.sys_state))  AS 'Logtekst',
			 -- ISNULL('S: ' + CAST(GADATA.c4g.fn_decodeSysstate(#SysBreakDwnTime.sys_state) AS varchar) + '|T: '  + #SysBreakDwnTime.error_text,('S: ' + CAST(GADATA.c4g.fn_decodeSysstate(#SysBreakDwnTime.sys_state) AS varchar) ))  AS 'Logtekst',
			  downtime as 'DT',
              DATEPART(YEAR, #SysBreakDwnTime.oktimestamp) AS 'Year',
			  DATEPART(WEEK,#SysBreakDwnTime.oktimestamp) AS 'Week',
			  GADATA.dbo.fn_volvoday(#SysBreakDwnTime.oktimestamp,CAST(#SysBreakDwnTime.oktimestamp AS time)) AS 'day',
			  GADATA.dbo.fn_volvoshift1(#SysBreakDwnTime.oktimestamp,CAST(#SysBreakDwnTime.oktimestamp AS time)) AS 'Shift',
			  'N/A' AS 'Object',
			  'N/A' AS 'Subgroup',
              #SysBreakDwnTime.id			  
           
FROM #SysBreakDwnTime
--join the controller name
JOIN    c4g.c_controller ON (#SysBreakDwnTime.controller_id = c_controller.id) 

WHERE 
 (SysBreakDwnIndx = 1 AND CombinedRobstate <> 3) --laatste event en robot heeft geen resolved event 
  OR
 (SysBreakDwnIndx = 1  AND (_timestamp > getdate()-'1900-01-01 00:04:00:000') ) --laatste event of not geen 5 min aan het draaien 

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--COAMU C4G warnings (een bepaald aantal warnings op een object en alarm geven)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION 
select * from GADATA.C4G.WARNING as w where w.Downtime > 5

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--COAMU C3G warnings (een bepaald aantal warnings op een object en alarm geven)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION 
select * from GADATA.C3G.WARNING as w where w.Downtime > 5

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--ABB check data comm (geeft alarm als er 5 min geen data is)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT DISTINCT  
              'IT15582_vm1' AS 'Location',
			  'ABB OPC' AS 'Robot',
              x.type AS 'Type',
			  'LIVE' as 'Errortype',
              convert(char(19),(getdate()+'1900-01-02 00:00:0.00'),120) AS 'Timestamp',
              NULL AS 'Logcode',
              20 AS 'Severity',
			  'ABB OPC WARNING type: ' + x.type + '  NO DATA (30min) Last message: ' + convert(char(19),x.LastMessage,120) AS 'Logtekst',
			  NULL AS 'DT',
              NULL AS 'Year',
			  NULL AS 'Week',
			  NULL AS 'day',
			  NULL AS 'Shift',
			  null AS 'Object',
			  null AS 'Subgroup',
              NULL AS 'id'
 FROM
(SELECT 
 comm.Type
,comm.LastMessage
,ROW_NUMBER() OVER (PARTITION BY comm.type ORDER BY comm.LastMessage DESC) AS rnDESC
from GADATA.abb.LastCommList as comm
) as x 
where x.rnDESC = 1 
and x.LastMessage < (getdate() - '1900-01-01 00:30:00')
---------------------------------------------------------------------------------------

) as x 
ORDER BY   x.[Timestamp] DESC 
--*/
END