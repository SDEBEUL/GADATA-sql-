
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
--Set default values of start and end date
---------------------------------------------------------------------------------------
if ((@StartDate is null) OR (@StartDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @StartDate = GETDATE()-'1900-01-01 23:00:00'
END

if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()
END
---------------------------------------------------------------------------------------
print'Joining events to get TIS "time in state"'
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#SysEventTime') is not null) drop table #SysEventTime
SELECT 
 rt_e.id
,rt_e.controller_id
,rt_e._timestamp
,ISNULL(rt_e.c_timestamp,rt_e._timestamp) as 'c_timestamp' --because c_timestamp is not passed for non controller side events (disco/watchdogs)
,rt_e.sys_state
,ROW_NUMBER() OVER (PARTITION BY rt_e.controller_id ORDER BY rt_e._timestamp DESC) AS 'rnDesc'
,ISNULL((lag(_timestamp) OVER (PARTITION BY rt_e.controller_id ORDER BY _timestamp desc)-_timestamp),getdate()-_timestamp) as 'TimeInState'
,robotState = c3g.fn_robstate(rt_e.sys_state) --A running robot has 1 a non running one 0  
INTO #SysEventTime
FROM GADATA.C3G.rt_sys_event as rt_e
WHERE rt_e._timestamp  BETWEEN @StartDate AND @EndDate
--SELECT TOP 30 *,info = GADATA.c3g.fn_decodeSysstate(sys_state) FROM #SysEventTime  order by _timestamp desc 
---------------------------------------------------------------------------------------
print'Calculation of Start and stop events. (breakdown tags / windows)'
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#StartStopEvents') is not null) drop table #StartStopEvents
       (
       SELECT 
         #SysEventTime.id,
         #SysEventTime.controller_id,
         #SysEventTime._timestamp,
		 #SysEventTime.c_timestamp,
         #SysEventTime.sys_state,
         #SysEventTime.rnDESC,
         #SysEventTime.TimeInState, 
         #SysEventTime.robotState,
         ROW_NUMBER() OVER (PARTITION BY #SysEventTime.controller_id ORDER BY #SysEventTime._timestamp DESC) AS StartStopIndx
       into #StartStopEvents
       FROM #SysEventTime
    JOIN    #SysEventTime AS LSysEventTime 
       ON     (
       --start events (change from Robstate 0->1) 
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
       --stop events (change from  Robstate 1->0)
              (#SysEventTime.controller_id = LSysEventTime.controller_id) 
              AND
              (#SysEventTime.rnDESC = (LSysEventTime.rnDESC-1))
			  AND 
              (#SyseventTime.robotState = 0)
			  AND
			  (LSyseventTime.robotState = 1)
              )  
	    OR
			 (
		--stop event (robot is currently down) 
		     (#SysEventTime.controller_id = LSysEventTime.controller_id) 
			 AND
			 (#SysEventTime.rnDESC = 1)
			 AND
			 (LSysEventTime.rnDESC = 1)
			 AND
			 (#SysEventTime.robotState = 0)
			 )
       )
--SELECT TOP 10 *,info = GADATA.c4g.fn_decodeSysstate(sys_state) FROM #StartStopEvents order by _timestamp desc 
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
	H._timestamp  BETWEEN @StartDate AND @EndDate
	AND 
	L.[error_severity] <> -1

	UNION --union disconnect an watchdog events 
	SELECT  
	 0 as 'id' 
	,H._timestamp
	,H._timestamp as 'C_timestamp'
	,H.controller_id
	,H.sys_state as 'error_id'
	,H.sys_state as 'error_number'
	,9 as 'error_severity' --changed from 11 to 9 because stuff like drive brake locked is 11..
	,'Disconnected OR controller watchdog' as 'error_text'
	FROM GADATA.C3G.rt_sys_event as h 
	WHERE 
	H._timestamp  BETWEEN @StartDate AND @EndDate 
	AND 
	H.sys_state in(-1,1)
) as x
)	
---------------------------------------------------------------------------------------
print'join start event with his stop event and join al the errors in that timeslot (make index on these errors)'
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#SysBreakDwn') is not null) drop table #SysBreakDwn
(
       SELECT 
         #StartStopEvents.id,
         #StartStopEvents.controller_id,
         #StartStopEvents.c_timestamp as '_Eb', 
		 LStartStopEvents.c_timestamp as '_Sb',
         LStartStopEvents.sys_state as 'TriggerState',
		 LStartStopEvents.TimeInState as 'repst',
		 ROW_NUMBER() OVER (PARTITION BY #StartStopEvents.id ORDER BY T_a.c_timestamp ASC) AS TriggerIndx, 
		 --index op de mogelijke 'trigger errors' idx 1 is normaal de trigger
		 --aan deze index een sorteer functie op dt toegevoegd. er werd soms onlogisch Relass gemaakt. (test SDB 16w10d04)
		 ROW_NUMBER() OVER (PARTITION BY #StartStopEvents.id ORDER BY H_a.c_timestamp, H_a.[error_severity] Desc) AS ReclassIndx, 
		 --index om makkelijk de zwaarste fout uit een storing te kunnen halen.
		 T_a.id as 'Terror_id', --Trigger error id 
		 T_a.[error_number] as 'Terror_number',
		 T_a.[error_severity] as 'Terror_serverity',
		 T_a.error_text as 'Terror_text',
		 H_a.id as 'Rerror_id', --Reclassification error id 
		 H_a.[error_number] as 'Rerror_number',
		 H_a.[error_severity] as 'Herror_serverity',
		 H_a.error_text as 'Rerror_text',
		 #StartStopEvents.robotState as 'BreakdownFinishedBit', --als deze bit 0 is is de storing nog bezig 
		 #StartStopEvents.sys_state  as 'ActiveState' --only for use in ongoing breakdowns (current state of the system)
       INTO #SysBreakDwn
       FROM #StartStopEvents
--join last start event to 'next' stop event
     JOIN    #StartStopEvents AS LStartStopEvents 
       ON   
	   (
	         (
       --koppel start van storing aan einde storing (overgang van Robstate 0->1) Storing is afgelopen 
              (#StartStopEvents.controller_id = LStartStopEvents.controller_id) 
              AND
              (#StartStopEvents.StartStopIndx = (LStartStopEvents.StartStopIndx-1))
			  AND 
              (#StartStopEvents.robotState = 1)
			  AND
			  (LStartStopEvents.robotState = 0)
             )
		OR
		--Koppel begin van een storing aan het laatst ontvangen event. (berekenen van sotring die nog bezig is ... voor live vieuw)
		     (
			  (#StartStopEvents.controller_id = LStartStopEvents.controller_id) 
              AND
              (#StartStopEvents.StartStopIndx = (LStartStopEvents.StartStopIndx-1))
			  AND 
              (#StartStopEvents.robotState = 0) --punt einde storing
			  AND
			  (#StartStopEvents.rnDESC = 1) --active event 
			  AND
			  (LStartStopEvents.robotState = 0) --punt begin storing
			 )
		)
--Join mogelijke errors in 'Trigger' timeslot => Dit is de poging om de errorcode te vinden die als 'trigger' van de breakdown kan worden gezien.
---------------------------------------------------------
	LEFT JOIN #Error as T_a
	   ON (
		(LStartStopEvents.controller_id = T_a.controller_id) 
		AND
		--fout moet zicht voordoen tussen de 3 min voor of + 1 min na de trigger (gebruikt _timestamp = moment van insert)
		(T_a.C_timestamp BETWEEN (LStartStopEvents.c_timestamp - '1900-01-01 00:03:00.00') AND LStartStopEvents.c_timestamp + '1900-01-01 00:01:00.00')
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
		--fout moet zicht voordoen tussen de 3 min voor de trigger en het einde van de breakdown (gebruikt _timestamp = moment van insert)
		(h_a.C_timestamp BETWEEN (LStartStopEvents.c_timestamp - '1900-01-01 00:03:00.00') AND #StartStopEvents.c_timestamp)
	      )
---------------------------------------------------------
 )
--select * from #SysBreakDwn
--------------------------------------------------------------------------------------------------------------------------
Print'Output qry (and check for new items in hystorian) FOR FINISED BREAKDOWNS' 
--------------------------------------------------------------------------------------------------------------------------
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
		 --#SysBreakDwn.Terror_text as 'Trigger', --for debug 
		 LSysBreakDwn.Rerror_id as 'RC_error_id'
		 --#SysBreakDwn.Rerror_text as 'Reclass',  --for debug 
		 --#SysBreakDwn.BreakdownFinishedBit --for debug
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
 AND
 (ISNULL(#SysBreakDwn.Terror_serverity,0) <= LSysBreakDwn.Herror_serverity) --Reclass must be higer serv than trigger
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
--Only Breakdown that are finised 
AND
#SysBreakDwn.BreakdownFinishedBit = 1
AND
--only ad new records
(H.id IS NULL)


ORDER BY EndOfBreakdown DESC 
--------------------------------------------------------------------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
Print'Output qry (and check for new items in hystorian) FOR ONGOINING BREAKDOWNS' 
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
--first clear the 'rt_breakdown' table
DELETE GADATA.C3G.rt_breakdown FROM GADATA.C3G.rt_breakdown
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO GADATA.C3G.rt_breakdown
SELECT    
         #SysBreakDwn.controller_id as 'controller_id',
         getdate() as 'EndOfBreakdown', 
		 #SysBreakDwn._Sb as 'StartOfBreakdown',
		 -- DATEDIFF(SECOND,'1900-01-01 00:00:00',[C3G].[fts_Downtime] (getdate(),#SysBreakDwn._Sb)) as 'DT', --for debug 
         #SysBreakDwn.TriggerState as 'Trig_state',
		 --GADATA.C3G.fn_decodeSysstate(#SysBreakDwn.TriggerState) as 'Triginfo', --for debug 
		 #SysbreakDwn.id as 'Trig_id',
		 #SysBreakDwn.repst as 'Rt',
		 --#SysBreakDwn.TriggerIndx, --for debug 
		 --#SysBreakDwn.ReclassIndx, --for debug 
		 #SysBreakDwn.Terror_id as 'error_id',
		 --#SysBreakDwn.Terror_text as 'Trigger', --for debug 
		 LSysBreakDwn.Rerror_id as 'RC_error_id',
		 --#SysBreakDwn.Rerror_text as 'Reclass',  --for debug 
		 --#SysBreakDwn.BreakdownFinishedBit --for debug
		 #SysBreakDwn.ActiveState
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
 AND
 (ISNULL(#SysBreakDwn.Terror_serverity,0) <= LSysBreakDwn.Herror_serverity) --Reclass must be higer serv than trigger
 )
----------------------------------------------------------------
WHERE
--Only Root cause errors  
ISNULL(#SysBreakDwn.TriggerIndx,0) <= 1 
--Only Breakdown that are still bussy 
AND
#SysBreakDwn.BreakdownFinishedBit = 0

END