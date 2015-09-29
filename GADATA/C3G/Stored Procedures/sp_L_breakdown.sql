
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
--SELECT TOP 30 *,info = GADATA.c3g.fn_decodeSysstate(sys_state) FROM #SysEventTime  order by _timestamp desc 
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


---------------------------------------------------------------------------------------
print'Preselect and join H_alarm with L_error.'
--also join rt_sys_events 0 and 1 (disconnect and controller side block) give this a servity of 11
--WATCH OUT ! I added id = 0 to the L_error table to represent the 2 events
--id	error_number	error_severity	error_text							Appl_id	Subgroup_id
--0		99010			11				Controller disconnected / Watchdog	1		1
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#Error') is not null) drop table #Error
(
SELECT * INTO  #Error
FROM
(
	SELECT 
	 L.id 
	,H._timestamp
	,H.c_timestamp
	,H.controller_id
	,H.error_id
	,L.[error_number]
	,L.[error_severity]
	,L.error_text 
	FROM GADATA.C3G.h_alarm as h 
	LEFT JOIN GADATA.C3G.L_error as L 
	on L.id = h.error_id 
	WHERE 
	H._timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE()) 
	AND 
	H.controller_id BETWEEN ISNULL(@controller_id,0) AND ISNULL(@controller_id,10000)
	AND L.[error_severity] <> -1

	UNION --union disconnect an watchdog events 
	SELECT  
	 0 as 'id' 
	,H._timestamp
	,H._timestamp as 'C_timestamp'
	,H.controller_id
	,H.sys_state as 'error_id'
	,H.sys_state as 'error_number'
	,11 as 'error_severity'
	,'Disconnected OR controller watchdog' as 'error_text'
	FROM GADATA.C3G.rt_sys_event as h 
	WHERE 
	H._timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE()) 
	AND 
	H.controller_id BETWEEN ISNULL(@controller_id,0) AND ISNULL(@controller_id,10000)
	AND 
	H.sys_state in(0,1)
) as x
)	
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
print'join start event with his stop event and join al the errors in that timeslot (make index on these errors)'
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
		 ROW_NUMBER() OVER (PARTITION BY #StartStopEvents.id ORDER BY T_a._timestamp ASC) AS TriggerIndx, --index op de mogelijke 'trigger errors' idx 1 is normaal de trigger
		 ROW_NUMBER() OVER (PARTITION BY #StartStopEvents.id ORDER BY H_a.[error_severity] Desc) AS ReclassIndx, --index om makkelijk de zwaarste fout uit een storing te kunnen halen.
		 T_a.id as 'Terror_id', --Trigger error id 
		 T_a.[error_number] as 'Terror_number',
		 H_a.id as 'Rerror_id', --Reclassification error id 
		 H_a.[error_number] as 'Rerror_number'
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
--Join mogelijke errors in 'Trigger' timeslot => Dit is de poging om de errorcode te vinden die als 'trigger' van de breakdown kan worden gezien.
---------------------------------------------------------
	LEFT JOIN #Error as T_a
	   ON (
		(LStartStopEvents.controller_id = T_a.controller_id) 
		AND
		--fout moet zicht voordoen tussen de 30 seconden voor of + 1 min na de trigger (gebruikt _timestamp = moment van insert)
		(T_a.C_timestamp BETWEEN (LStartStopEvents._timestamp - '1900-01-01 00:00:30.00') AND LStartStopEvents._timestamp + '1900-01-01 00:01:00.00')
		AND
		(T_a.[error_severity] >= 4) --een trigger fout moet minsten severity 4 zijn
	      )
---------------------------------------------------------

--Join al de mogelijke erros in het 'breakdown' timeslot
---------------------------------------------------------
	LEFT JOIN #Error as h_a
	   ON (
		(LStartStopEvents.controller_id = h_a.controller_id) 
		AND
		--fout moet zicht voordoen tussen de 30 seconden voor de trigger en het einde van de breakdown (gebruikt _timestamp = moment van insert)
		(h_a.C_timestamp BETWEEN (LStartStopEvents._timestamp - '1900-01-01 00:00:30.00') AND #StartStopEvents._timestamp)
	      )
---------------------------------------------------------
 )
---------------------------------------------------------------------------------------
--select * from #SysBreakDwn
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
Print'Output qry (and check for new items in hystorian)' 
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
INSERT into GADATA.C3G.h_breakdown 
SELECT    
         #SysBreakDwn.controller_id as 'controller_id',
         #SysBreakDwn._Eb as 'EndOfBreakdown', 
		 #SysBreakDwn._Sb as 'StartOfBreakdown',
		--DATEDIFF(SECOND,'1900-01-01 00:00:00',[C3G].[fts_Downtime] (#SysBreakDwn._Eb,#SysBreakDwn._Sb)) as 'DT', --for debug 
         #SysBreakDwn.TriggerState as 'Trig_state',
		 --GADATA.C3G.fn_decodeSysstate(#SysBreakDwn.TriggerState) as 'Triginfo', --for debug 
		 #SysbreakDwn.id as 'Trig_id',
		 #SysBreakDwn.repst as 'Rt',
		 --#SysBreakDwn.TriggerIndx, --for debug 
		 --#SysBreakDwn.ReclassIndx, --for debug 
		 #SysBreakDwn.Terror_id as 'error_id',
		 --ET.error_text as 'Trigger', --for debug 
		 LSysBreakDwn.Rerror_id as 'RC_error_id'
		 --ER.error_text as 'Reclass'  --for debug 
FROM #SysBreakDwn
--join the best reclassifciation
LEFT JOIN #SysBreakDwn as LSysBreakDwn 
 ON
 (
 (#SysBreakDwn.id =  LSysBreakDwn.id) 
 AND
 (#SysBreakDwn.controller_id = LSysBreakDwn.controller_id)
 AND
 (ISNULL(#SysBreakDwn.TriggerIndx,0) <= 1) --reclasificeer enkel de trigger fout 0 = geen trigger error gekoppeld 1 = hoogst waarschijnlijke trigger
 AND
 (LSysBreakDwn.ReclassIndx = 1) --Koppel de beste reclasificatie (hoogste serv)
 AND
 (ISNULL(#SysBreakDwn.Terror_number,0) <> LSysBreakDwn.Rerror_number) --Reclass kan niet zelfde fout zijn als trigger 
 )
----------------------------------------------------------------

--join the history to filter new records
LEFT JOIN GADATA.C3G.h_breakdown as H on
(
H.controller_id = #SysBreakDwn.controller_id
AND
H.Trig_id = #SysBreakDwn.id
)
WHERE
--Only Root cause errors  
ISNULL(#SysBreakDwn.TriggerIndx,0) <= 1 
AND
--only ad new records
(H.id IS NULL)

ORDER BY EndOfBreakdown DESC 

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Activity log (logs the execution of the Query to a table)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
DECLARE @rowcountmen as int 
SET @rowcountmen = @@rowcount
Print'GADATA.C4G.sp_Activitylog Newrecords:' + CONVERT(varchar(10),@rowcountmen) 
DECLARE @RequestString as varchar(255)
SET @RequestString = 'Running: [C3G].[sp_Update_L_breakdown] Cid: ' + CONVERT(varchar(10),isnull(@controller_id,0))
EXEC GADATA.volvo.sp_Alog  @rowcount = @rowcountmen, @Request = @RequestString
---------------------------------------------------------------------------------------
END