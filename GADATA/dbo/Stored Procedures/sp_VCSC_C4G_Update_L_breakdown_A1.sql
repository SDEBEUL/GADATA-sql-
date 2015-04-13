CREATE PROCEDURE [dbo].[sp_VCSC_C4G_Update_L_breakdown_A1]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @RobotFilterWild as varchar(10) = '%',
   @RobotFilterMaskStart as varchar(10) = '%',
   @RobotFilterMaskEnd as varchar(10) = '99999R99%',
   @OrderbyRobot as bit = null,
   @CalcBreakDowntags as bit = 0
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
				robotState = dbo.fn_robstate(rt_sys_event.sys_state) --calculates a robot state. A running robot has 2 a non running one 0 
			FROM  GADATA.dbo.rt_sys_event  AS rt_sys_event
			WHERE rt_sys_event._timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())
	
			--data from L_operation (to catch robots offline)
			UNION
			SELECT 
				l_operation.id,
				l_operation.controller_id,
				l_operation._timestamp,
				sys_state = 262144, 
				robotState = 0
			FROM GADATA.dbo.l_operation AS l_operation
			WHERE (l_operation._timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())) AND (l_operation.code = 4) --connection lost 
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
if (OBJECT_ID('tempdb..#SysEventTime') is not null) drop table #SysEventTime
       (
       select * into #SysEventTime from (
		   SELECT * FROM #SysEventPast
		   UNION 
		   SELECT * FROM #SysEventLive
       ) as x
       )
---------------------------------------------------------------------------------------


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
    
       ON (
       --start event (robot terug oke na 3 min draaien) 
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
       --stop events (alle nullen mogen door)
              (#SysEventTime.controller_id = LSysEventTime.controller_id) 
              AND
              (#SysEventTime.rnDESC = LSysEventTime.rnDESC) 
			  AND
              (#SysEventTime.robotState = 0)
              )
       )
---------------------------------------------------------------------------------------

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

--zwaar gefoefel om via timestamp te proberen catchen welke error in rt_alarm het systeem down heeft getrokken	
	LEFT JOIN GADATA.dbo.rt_alarm as rt_alarm 
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
		 LSysBreakDwn._timestamp AS 'OKtimestamp',
         DOWNTIME = DATEDIFF(MINUTE,LSysBreakDwn._timestamp,#SysBreakDwn._timestamp),
		 LSysBreakDwn.error_text,
		 LsysBreakDwn.error_id,
		 LSysBreakDwn.error_number
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
             -- AND
             -- (LSysBreakDwn.CombinedRobstate = 1)
              )
       )
---------------------------------------------------------------------------------------
--build a temp table with robots that are down right now 
/*
if (OBJECT_ID('tempdb..#LiveList') is not null) drop table #LiveList
SELECT 
c_controller.controller_name
,#SysBreakDwnTime._timestamp
,downtimes = datediff(second,#SysBreakDwnTime._timestamp,GETDATE())
--INTO #LiveList 
FROM #SysBreakDwnTime 
join c_controller on c_controller.id = #SysBreakDwnTime.controller_id
where  
(#SysBreakDwnTime.SysBreakDwnIndx = 1) 
AND 
(#SysBreakDwnTime.OKtimestamp is null) 
AND 
((#SysBreakDwnTime.rnDESC <> 1) OR ((#SysBreakDwnTime.rndesc = 1) AND (#SysBreakDwnTime.TimeInState < '1900-01-01 00:00:03.00')))
ORDER BY #SysBreakDwnTime._timestamp DESC 
*/
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--Output qry 
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------

--this makes sure only unique records can be added to the table.
--needs to be run when the table gets created.
/*
CREATE UNIQUE NONCLUSTERED INDEX [IndexTableUniqueRows] ON gadata.dbo.L_breakdown
(
    idx ASC

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = ON, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
*/

INSERT into L_breakdown --this ADDs data to the table 
SELECT  
              SysBreakDwnTime.controller_id,
              SysBreakDwnTime._timestamp AS 'EndOfBreakdown',
			  SysBreakDwnTime.OKtimestamp AS 'StartOfBreakdown',
              ISNULL(c_logtekst.error_number, SysBreakDwnTime.error_number),
              ISNULL(c_logtekst.error_text, SysBreakDwnTime.error_text),
              CAST(SysBreakDwnTime.id AS int) AS 'idx'
			  
--INTO gadata.dbo.L_breakdown --this is to create the table 
FROM #SysBreakDwnTime AS SysBreakDwnTime
-- join logtekst replacement system
LEFT JOIN c_logtekst on (c_logtekst.id = SysBreakDwnTime.error_id)

WHERE 
--only add to table if a cause was detected 
 ISNULL(c_logtekst.error_number, SysBreakDwnTime.error_number) is not null
ORDER BY   _timestamp DESC 

/* --sdebeul table was lost somewhere? why ? killed this 'option' 15w16d1
insert into GADATA.dbo.L_updatelog (BreakdownCount,_timestamp)
Values (@@ROWCOUNT,getdate())
*/
END