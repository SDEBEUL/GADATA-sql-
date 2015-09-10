CREATE PROCEDURE [C3G].[sp_L_breakdown_BETA]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @RobotFilterWild as varchar(10) = '%',
   @RobotFilterMaskStart as varchar(10) = '%',
   @RobotFilterMaskEnd as varchar(10) = '99999R99%',
   @OrderbyRobot as bit = null,
   @CalcBreakDowntags as bit = 0,
   @controller_id as int = 622
AS
BEGIN


---------------------------------------------------------------------------------------
print 'Running: [C3G].[sp_L_breakdown_BETA]'
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1

---------------------------------------------------------------------------------------
print'to index sys event table based on time and robotid'
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
				robotState = c3g.fn_robstate(rt_sys_event.sys_state) --A running robot has 1 a non running one 0  
			FROM  GADATA.C4G.rt_sys_event  AS rt_sys_event
			WHERE rt_sys_event._timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())
	
	) AS x 
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
print'UNION between passed events and current event. Joining events to get TIS "time in state"'
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#SysEventTime') is not null) drop table #SysEventTime
       (
      SELECT * into #SysEventTime from (
       --passed events
	   SELECT 
         #SysEventIdx.id,
         #SysEventIdx.controller_id,
         #SysEventIdx._timestamp,
         #SysEventIdx.sys_state,
         #SysEventIdx.rnDESC,
         TimeInState = SyseventOffs._timestamp - #SysEventIdx._timestamp,  
         #SysEventIdx.robotState
       FROM #SysEventIdx
		JOIN    #SysEventIdx AS SyseventOffs 
		ON (#SysEventIdx.rnDESC = SyseventOffs.rnDESC + 1)  
              AND 
              (#SysEventIdx.controller_id = SyseventOffs.controller_id) 
              AND 
              (#SysEventIdx.rnDESC <> 1)
		--current event
		UNION 
		SELECT 
         #SysEventIdx.id,
         #SysEventIdx.controller_id,
         #SysEventIdx._timestamp,
         #SysEventIdx.sys_state,
         #SysEventIdx.rnDESC,
         TimeInState = (GETDATE()-#SysEventIdx._timestamp),
         #SysEventIdx.robotState
       FROM #SysEventIdx
		WHERE (#SysEventIdx.rnDESC = 1)
       ) as x
       )
---------------------------------------------------------------------------------------
SELECT TOP 30 *,info = GADATA.c3g.fn_decodeSysstate(sys_state) FROM #SysEventTime where controller_id = @controller_id order by _timestamp desc 
---------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
print'Calculation of Start and stop events. (breakdown tags)'
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
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
         ROW_NUMBER() OVER (PARTITION BY #SysEventTime.controller_id ORDER BY #SysEventTime._timestamp DESC) AS StartStopIndx
       into #StartStopEvents
       FROM #SysEventTime
    JOIN    #SysEventTime AS LSysEventTime 
    
       ON     (
       --start events (overgang van Robstate 0->1) 
              (#SysEventTime.controller_id = LSysEventTime.controller_id) 
              AND
              (#SysEventTime.rnDESC = (LSysEventTime.rnDESC-1))
			  AND 
              (#SyseventTime.robotState = 1)
			  AND
			  (LSyseventTime.robotState = 0)
              )
  
       OR
              (
       --stop events (overgang Van Robstate 1->0)
              (#SysEventTime.controller_id = LSysEventTime.controller_id) 
              AND
              (#SysEventTime.rnDESC = (LSysEventTime.rnDESC-1))
			  AND 
              (#SyseventTime.robotState = 0)
			  AND
			  (LSyseventTime.robotState = 1)
              )  
       )
---------------------------------------------------------------------------------------
--SELECT TOP 10 *,info = GADATA.c4g.fn_decodeSysstate(sys_state) FROM #StartStopEvents where controller_id = @controller_id order by _timestamp desc 


--join start event with his stop event and join al the errors in that timeslot (make index on these errors)
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#SysBreakDwn') is not null) drop table #SysBreakDwn
(
       SELECT 
         #StartStopEvents.id,
         #StartStopEvents.controller_id,
         #StartStopEvents._timestamp as '_Eb', 
		 LStartStopEvents._timestamp as '_Sb',
		 DATEDIFF(Minute,'1900-01-01 00:00:00',[C3G].[fts_Downtime] (#StartStopEvents._timestamp,LStartStopEvents._timestamp)) as 'DT',
         LStartStopEvents.sys_state as 'TriggerState',
		 ROW_NUMBER() OVER (PARTITION BY #StartStopEvents.id ORDER BY rt_a._timestamp ASC) AS CauseIndx, --index op de mogelijke 'causes' idx 1 is normaal de trigger
		 GADATA.C3G.fn_decodeSysstate(LStartStopEvents.sys_state) as 'TrigStateinfo',
         --#StartStopEvents.rnDESC,
         --LStartStopEvents.TimeInState as 'RespT', 
		 --#StartStopEvents.robotState,
         --#StartStopEvents.StartStopIndx as 'upIdx',
		 --LStartStopEvents.StartStopIndx as 'DwnIdx',
		 rt_a._timestamp,
		 --rt_a.error_timestamp,
		 --rt_a.error_count,
		 rt_a.error_number,
		 rt_a.error_text

       INTO #SysBreakDwn
       FROM #StartStopEvents
--join last start event to 'next' stop event
     JOIN    #StartStopEvents AS LStartStopEvents 
       ON   (
       --start events (overgang van Robstate 0->1) 
              (#StartStopEvents.controller_id = LStartStopEvents.controller_id) 
              AND
              (#StartStopEvents.StartStopIndx = (LStartStopEvents.StartStopIndx-1))
			  AND 
              (#StartStopEvents.robotState = 1)
			  AND
			  (LStartStopEvents.robotState = 0)
             )

--Join al de mogelijke erros in het 'breakdown' timeslot
	LEFT JOIN GADATA.C4G.rt_alarm as rt_a
	   ON (
		(LStartStopEvents.controller_id = rt_a.controller_id) 
		AND
			(
			--voor fouten die we kunnen terug vinden hebben in de errorlog
				--fout moet zicht voordoen tussen de 3 seconden voor de trigger en het einde van de breakdown (gebruikt _timestamp = moment van insert)
				(rt_a._timestamp BETWEEN (LStartStopEvents._timestamp - '1900-01-01 00:00:03.00') AND #StartStopEvents._timestamp)
				AND
				(rt_a.[error_severity] >= 4) --moet ten minste severity 4 zijn 
			OR
			--voor fouten die we niet konden koppelen in de errorlog.
				--fout moet zicht voordoen tussen de 3 seconden voor de trigger en het einde van de breakdown (gebruikt error_timestamp = controller clock
				(rt_a.error_timestamp BETWEEN (LStartStopEvents._timestamp - '1900-01-01 00:00:03.00') AND #StartStopEvents._timestamp)
				AND
				(rt_a.[error_severity] = -1) -- -1 wil zeggen dat we het niet konden matchen in de errorlog
			)
		  )
 )
---------------------------------------------------------------------------------------

SELECT TOP 20 c.controller_name, bwn.* FROM #SysBreakDwn as bwn 
LEFT JOIN GADATA.C4G.c_controller as c on c.id = bwn.controller_id
order by _EB desc 
END