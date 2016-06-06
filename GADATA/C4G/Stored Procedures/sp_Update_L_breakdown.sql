CREATE PROCEDURE [C4G].[sp_Update_L_breakdown]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @RobotFilterWild as varchar(10) = '%',
   @RobotFilterMaskStart as varchar(10) = '%',
   @RobotFilterMaskEnd as varchar(10) = '99999R99%',
   @OrderbyRobot as bit = null,
   @CalcBreakDowntags as bit = 0,
   @controller_id as int = 122
AS
BEGIN


---------------------------------------------------------------------------------------
print 'Running: [C4G].[sp_Update_L_breakdown]'
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1

---------------------------------------------------------------------------------------
print'to index sys event table based on time and robotid'
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#SysEventIdx') is not null) drop table #SysEventIdx
			--data from rt_sys_event table. 
			SELECT 
				rt_sys_event.id,
				rt_sys_event.controller_id,
				rt_sys_event._timestamp,
				rt_sys_event.sys_state,
				robotState = c4g.fn_robstate(rt_sys_event.sys_state), --calculates a robot state. A running robot has 2 a non running one 0 
				ROW_NUMBER() OVER (PARTITION BY rt_sys_event.controller_id ORDER BY rt_sys_event._timestamp DESC) AS rnDESC
	        INTO #SysEventIdx
			FROM  GADATA.C4G.rt_sys_event  AS rt_sys_event
			WHERE rt_sys_event._timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE()) 
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
--SELECT TOP 10 *,info = GADATA.C4G.fn_decodeSysstate(sys_state) FROM #SysEventTime where controller_id =  @controller_id order by _timestamp desc 
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
print'Pull dataset van H_alarm/L_error. (to speed up performance)'
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#C4Gerror') is not null) drop table #C4Gerror
       (
	   SELECT 
	    H.id
	   ,H._timestamp
	   ,H.controller_id
	   ,H.error_id
	   --,L.[error_number]
	   ,L.[error_severity]
	   --,L.error_text
	   --,L.Appl_id
	   --,L.Subgroup_id
       into #C4Gerror
       FROM GADATA.C4G.h_alarm as H
	   LEFT JOIN GADATA.c4G.L_error as L on L.id = H.error_id
	   WHERE H._timestamp BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())
	   )
---------------------------------------------------------------------------------------
--SELECT TOP 10 * FROM #C4Gerror where controller_id =  @controller_id order by _timestamp desc 
---------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
print'Calculation of Start and stop events. (breakdown tags)'
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
		-- #C4Gerror.error_text,
		-- #C4Gerror.error_number,
		-- #C4Gerror.error_severity,
		 #C4Gerror.error_id
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
	LEFT JOIN #C4Gerror 
	   ON (
		(#StartStopEvents.controller_id = #C4Gerror.controller_id) 
		AND
		((#C4Gerror._timestamp - '1900-01-01 00:00:01.00')  < #StartStopEvents._timestamp)
	    AND 
		(#C4Gerror._timestamp > (#StartStopEvents._timestamp - '1900-01-01 00:00:05.00')) --rt_alarm is normaal altijd net iets sneller dan Rt_sysevent. --was 1.90
	    AND
		(#C4Gerror.[error_severity] <> 2) --filter 
		AND
        (#StartStopEvents.CombinedRobstate = 1) 
	    )
       )
---------------------------------------------------------------------------------------


Print'Filter the false positve breakdowns' -- + nog eens een nieuwe inx de breakdown index om later de stroings tijd makkelijk te kunnen bepalen.
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#SysBreakDwnTime') is not null) drop table #SysBreakDwnTime
       (
       SELECT 
         #SysBreakDwn.id as 'Trig_id',
         #SysBreakDwn.controller_id,
         #SysBreakDwn._timestamp,
         ISNULL(LSysBreakDwn.sys_state,#SysBreakDwn.sys_state) AS 'Trig_state', --(state that triggerd the breakdown)
         --#SysBreakDwn.TimeInState, 
		 LSysBreakDwn.TimeInState as 'Rt',
		 --#SysBreakDwn.robotState,
         --#SysBreakDwn.CombinedRobstate,
         --#SysBreakDwn.StartStopIndx,
         --#SysBreakDwn.SysBreakDwnIndx,
		 LSysBreakDwn._timestamp AS 'OKtimestamp',
         --DOWNTIME = DATEDIFF(MINUTE,LSysBreakDwn._timestamp,#SysBreakDwn._timestamp),
		 --LSysBreakDwn.error_text,
		 --LsysBreakDwn.error_severity,
		 --LSysBreakDwn.error_number,
		 LsysBreakDwn.error_id
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
--SELECT TOP 10 * FROM #SysBreakDwnTime where controller_id =  @controller_id order by _timestamp desc 
---------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
Print'Output qry' 
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------

INSERT into GADATA.C4G.h_breakdown 
SELECT    
              BD.controller_id,
              BD._timestamp AS 'EndOfBreakdown',
			  BD.OKtimestamp AS 'StartOfBreakdown',
			  BD.Trig_state,
			  BD.Trig_id,
			  BD.Rt,
			  --BD.error_text, --
              --BD.error_number, --
			  --BD.error_serverty, --
			  BD.error_id,
			  Null

FROM #SysBreakDwnTime AS BD
--join the history to filter new records
LEFT JOIN GADATA.C4G.h_breakdown as H on
(
H.controller_id = bd.controller_id
AND
H.Trig_id = bd.Trig_id
)

WHERE 
--only add to table if a cause was detected 
BD.error_id is not null
--only ad new records
AND
(H.id IS NULL)
--bd.controller_id like @controller_id
--ORDER BY   _timestamp DESC 


---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Activity log (logs the execution of the Query to a table)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
DECLARE @rowcountmen as int 
SET @rowcountmen = @@rowcount
DECLARE @RequestString as varchar(255)
SET @RequestString = 'Running: [C4G].[sp_Update_L_breakdown]'
EXEC GADATA.volvo.sp_Alog  @rowcount = @rowcountmen, @Request = @RequestString
---------------------------------------------------------------------------------------

END