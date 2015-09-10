
CREATE PROCEDURE [C3G].[sp_L_breakdown]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @controller_id as int = null
AS
BEGIN


---------------------------------------------------------------------------------------
print 'Running: [C3G].[sp_L_breakdown]'
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
			FROM  GADATA.C3G.rt_sys_event  AS rt_sys_event
			WHERE rt_sys_event._timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE()) 
			      AND 
				  rt_sys_event.controller_id BETWEEN ISNULL(@controller_id,0) AND ISNULL(@controller_id,10000)
	
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
SELECT TOP 30 *,info = GADATA.c3g.fn_decodeSysstate(sys_state) FROM #SysEventTime order by _timestamp desc 
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
         LStartStopEvents.sys_state as 'TriggerState',
		 LStartStopEvents.TimeInState as 'repst',
		 ROW_NUMBER() OVER (PARTITION BY #StartStopEvents.id ORDER BY H_a._timestamp ASC) AS CauseIndx, --index op de mogelijke 'causes' idx 1 is normaal de trigger
		 ROW_NUMBER() OVER (PARTITION BY #StartStopEvents.id ORDER BY L_e.[error_severity] Desc) AS ReclassIndx, --index om makkelijk de zwaarste fout uit een storing te kunnen halen.
		 H_a.id as 'error_id',
		 L_e.[error_number],
		 L_e.[error_severity],
		 L_e.error_text

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
	LEFT JOIN GADATA.C3G.h_alarm as h_a
	   ON (
		(LStartStopEvents.controller_id = h_a.controller_id) 
		AND
		--fout moet zicht voordoen tussen de 3 seconden voor de trigger en het einde van de breakdown (gebruikt _timestamp = moment van insert)
		(h_a._timestamp BETWEEN (LStartStopEvents._timestamp - '1900-01-01 00:00:03.00') AND #StartStopEvents._timestamp)
		AND
        (h_a.controller_id BETWEEN ISNULL(@controller_id,0) AND ISNULL(@controller_id,10000))
		  )
     LEFT JOIN GADATA.C3G.L_error as L_e 
	   ON ( 
		(l_e.id = h_a.error_id) 
		AND 
		(L_e.[error_severity] >= 4)
	      )
 )
---------------------------------------------------------------------------------------
SELECT  
         #SysBreakDwn.id,
         #SysBreakDwn.controller_id,
         #SysBreakDwn._Eb, 
		 #SysBreakDwn._Sb,
		 DATEDIFF(Minute,'1900-01-01 00:00:00',[C3G].[fts_Downtime] (#SysBreakDwn._Eb,#SysBreakDwn._Sb)) as 'DT',
         #SysBreakDwn.TriggerState,
		 GADATA.C3G.fn_decodeSysstate(#SysBreakDwn.TriggerState) as 'Triginfo',
		 #SysBreakDwn.repst,
		 #SysBreakDwn.CauseIndx,
		 #SysBreakDwn.ReclassIndx,
		 #SysBreakDwn.error_id,
		 #SysBreakDwn.[error_number],
		 #SysBreakDwn.[error_severity],
		 #SysBreakDwn.error_text,
		 LSysBreakDwn.error_id as 'Rerror_id',
		 LSysBreakDwn.error_text as 'Rtext'
FROM #SysBreakDwn

--join the best reclassifciation
LEFT JOIN #SysBreakDwn as LSysBreakDwn
 ON
 (
 ( #SysBreakDwn.id =  LSysBreakDwn.id)
 AND
 (#SysBreakDwn.CauseIndx = 1)
 AND
 (LSysBreakDwn.ReclassIndx = 1)
 AND
 (LSysBreakDwn.CauseIndx <> 1)
 )

order by _EB desc 
END