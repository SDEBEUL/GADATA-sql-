CREATE PROCEDURE [dbo].[sp_VCSC_C4G_LiveView_a1]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @RobotFilterWild as varchar(10) = '%',
   @RobotFilterMaskStart as varchar(10) = '%',
   @RobotFilterMaskEnd as varchar(10) = '88999R99%',
   @LocationFilterWild as varchar(20) = '%',

   @OrderbyRobot as bit = null,
  
   @GetC4GAction as bit = 1,
   @GetC4Gerror as bit = 1,
   @GetC4GEvents as bit = 0,
   @GetC4GDowntimes as bit = 1,
   @GetC4GDownTBegin as bit = 1,
   @GetC4GCollisions as bit = 0,
   @GetC4GSpeedCheck as bit = 1,
   @GetC3GError as bit = 1,
   @GetModification as bit = 0,

   @ExcludeGateStops as bit = 1,
   @MinLogserv as int = 10,
   @minDowntime as int = 4
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
				robotState = dbo.fn_robstate(rt_sys_event.sys_state) --calculates a robot state a running robot has 2 a non running one 0 
			FROM  GADATA.dbo.rt_sys_event  AS rt_sys_event
			WHERE rt_sys_event._timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())
			AND @GetC4GEvents = 0
	
			--data from L_operation (to catch robots goning offline)
			UNION
			SELECT 
				l_operation.id,
				l_operation.controller_id,
				l_operation._timestamp,
				sys_state = 262144, 
				robotState = 0
			FROM GADATA.dbo.l_operation AS l_operation
			WHERE (l_operation._timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())) AND (l_operation.code = 4) --connection lost 
			AND @GetC4GEvents = 0
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
	WHERE @GetC4GEvents = 0
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
   	     AND @GetC4GEvents = 0
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
--Runs an update of the 'actionlog' timeoffset table  (builds a instance of #C4GActionLogtimediff)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--create temp table in daterange to 'guess' the best timeoffset for action log 
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#C4GActionLogtimedifftemp') is not null) drop table #C4GActionLogtimedifftemp
SELECT 
 --c_controller.controller_name
 --,rt_alarm._timestamp as 'realtime'
 --,rt_alarm.error_timestamp as 'controllertime'
  rt_alarm.controller_id
 ,timeoffset = (rt_alarm._timestamp - rt_alarm.error_timestamp)
 ,ROW_NUMBER() OVER (PARTITION BY rt_alarm.controller_id ORDER BY rt_alarm._timestamp DESC) AS rnDESC
INTO #C4GActionLogtimedifftemp
FROM GADATA.dbo.c_controller
JOIN GADATA.dbo.rt_alarm on c_controller.id = rt_alarm.controller_id

WHERE 
--reference pool
(rt_alarm._timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE()))
--error must be a realtime alarm.
AND
(rt_alarm.error_is_alarm = 1)

if (OBJECT_ID('tempdb..#C4GActionLogtimediff') is not null) drop table #C4GActionLogtimediff
SELECT #C4GActionLogtimedifftemp.controller_id, #C4GActionLogtimedifftemp.timeoffset  
INTO #C4GActionLogtimediff 
FROM #C4GActionLogtimedifftemp
WHERE rnDESC = 1 

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------
--create temp table for C4G speedcheck
---------------------------------------------------------------------------------------

--dump data into temp table to create rnDESC idx
if (@GetC4GSpeedCheck = 1) 
if (OBJECT_ID('tempdb..#C4GSpeedchecktemp') is not null) drop table #C4GSpeedchecktemp
(
SELECT 
_timestamp,
controller_id,
value,
ROW_NUMBER() OVER (PARTITION BY controller_id, variable_id ORDER BY _timestamp DESC) AS rnDESC
INTO #C4GSpeedchecktemp
FROM GADATA.dbo.rt_value
WHERE 
(rt_value.variable_id = 1) --$GEN_OVER
AND 
(GADATA.dbo.rt_value._timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())) 
)
--BREAK
if (@GetC4GSpeedCheck = 1) 
if (OBJECT_ID('tempdb..#C4GSpeedcheck') is not null) drop table #C4GSpeedcheck
(
SELECT
#C4GSpeedchecktemp.controller_id,
#C4GSpeedchecktemp._timestamp AS 'TimestampNOK',
lrt_value_rn_desc._timestamp AS 'TimestampOK',
DATEDIFF(HOUR, ISNULL(Lrt_value_rn_desc._timestamp,getdate()), #C4GSpeedchecktemp._timestamp) AS 'hours',
#C4GSpeedchecktemp.value AS 'ActiveSpeed',
Lrt_value_rn_desc.value AS 'OldSpeedValue'
INTO #C4GSpeedcheck
FROM #C4GSpeedchecktemp
LEFT JOIN #C4GSpeedchecktemp AS Lrt_value_rn_desc ON
(
(#C4GSpeedchecktemp.controller_id = Lrt_value_rn_desc.controller_id )
AND
(Lrt_value_rn_desc.value <> 100) 
AND 
(#C4GSpeedchecktemp.rnDESC = Lrt_value_rn_desc.rnDESC - 1)
AND
(#C4GSpeedchecktemp.value IN ( 100, null))
)

WHERE 
--robots that are not 100% now
(
(#C4GSpeedchecktemp.rnDESC = 1)
AND
(#C4GSpeedchecktemp.value <> 100)
)
OR --robots that where less than 100% for more than 1 hour 
(
(DATEDIFF(hour, Lrt_value_rn_desc._timestamp, #C4GSpeedchecktemp._timestamp) > 1)
AND
(#C4GSpeedchecktemp.value = 100)
)
)


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
				robotState = dbo.fn_robstate(rt_sys_event.sys_state) --calculates a robot state a running robot has 2 a non running one 0 
			FROM  GADATA.dbo.rt_sys_event  AS rt_sys_event
			WHERE rt_sys_event._timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())
	
			--data from L_operation (to catch robots goning offline)
			UNION
			SELECT 
				l_operation.id,
				l_operation.controller_id,
				l_operation._timestamp,
				sys_state = 262144, 
				CASE l_operation.code
				 WHEN 4 THEN -1
				 WHEN 5 THEN 0
				END as 'robotState'
			FROM GADATA.dbo.l_operation AS l_operation
			WHERE 
			(l_operation._timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())) AND (l_operation.code in (4,5)) --connection lost / regain 
) as Y
END

--********************************************************************************************************************************************--
--Last loading of a controller in a center...
--********************************************************************************************************************************************--
if (OBJECT_ID('tempdb..#L_operationServiceCenter') is not null) drop table #L_operationServiceCenter
BEGIN
SELECT [ID]
      ,[_timestamp]
      ,[code]
      ,[Vcsc_name]
      ,[controller_id]
      ,[Description]
	  ,(ROW_NUMBER() OVER (PARTITION BY L_operation.controller_id, L_operation.code ORDER BY L_operation._timestamp DESC)) As rnDesc
  INTO #L_operationServiceCenter
  FROM [GADATA].[dbo].[L_operation]
  where (code = 3)
END
--********************************************************************************************************************************************--


--********************************************************************************************************************************************--
--Get last event recieve from each controller from sys_event
--********************************************************************************************************************************************--
if (OBJECT_ID('tempdb..#L_operationActRobState') is not null) drop table #L_operationActRobState
BEGIN
SELECT
#L_operationHeartBeat.controller_id
,#L_operationHeartBeat._timestamp
,#L_operationHeartBeat.sys_state
,#L_operationHeartBeat.robotState
,#L_operationHeartBeat.rnDESC
,#L_operationServiceCenter.Vcsc_name
INTO #L_operationActRobState
FROM #L_operationHeartBeat
LEFT JOIN #L_operationServiceCenter on 
(#L_operationHeartBeat.controller_id = #L_operationServiceCenter.controller_id)
AND
(#L_operationServiceCenter.rndesc = 1)

WHERE 
(#L_operationHeartBeat.rnDESC =1)
END


--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--Output qry 
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G Qry Breakdowns (einde van storings met storings tijd)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

SELECT   
              c_controller.location AS 'Location',
			  c_controller.controller_name AS 'Robot',
              'C4G' AS 'Type',
			  'BREAKDOWN' As 'Errortype',
              convert(char(19),L_breakdown.EndOfBreakdown,120) AS 'Timestamp',
              L_breakdown.error_number AS 'Logcode',
              NULL AS 'Severity',
              ISNULL(L_breakdown.error_text,'-----------Breakdown Tag-----------') AS 'Logtekst1',
			  DT = DATEDIFF(MINUTE,L_breakdown.StartOfBreakdown,L_breakdown.EndOfBreakdown),
              DATEPART(YEAR, L_breakdown.StartOfBreakdown) AS 'Year',
			  DATEPART(WEEK,L_breakdown.StartOfBreakdown) AS 'Week',
			  GADATA.dbo.fn_volvoday(L_breakdown.StartOfBreakdown,CAST(L_breakdown.StartOfBreakdown AS time)) AS 'day',
			 -- DATEPART(WEEKDAY,L_breakdown.StartOfBreakdown)AS 'day',
			  GADATA.dbo.fn_volvoshift1(L_breakdown.StartOfBreakdown,CAST(L_breakdown.StartOfBreakdown AS time)) AS 'Shift',
			  c_logclass1.appl AS 'Object',
			  c_logclass1.subgroup AS 'Subgroup',
			  
			  --debug collums
              --SysBreakDwn.sys_state,
              --CAST(SysBreakDwn.rnDESC AS int) AS 'rnDESC',
              L_breakdown.idx
              --CAST(SysBreakDwn.SysBreakDwnIndx AS int) AS 'SSidx'
			  
            
FROM GADATA.dbo.L_breakdown
--join the controller name
JOIN    c_controller ON (L_breakdown.controller_id = c_controller.id) 
--try and get an error classification
LEFT JOIN GADATA.dbo.c_logclass1 as c_logclass1 ON 
(
(L_breakdown.error_number BETWEEN c_logclass1.error_codeStart AND c_logclass1.error_codeEnd)
OR
(L_breakdown.error_text LIKE c_logclass1.error_tekst)
)

WHERE 
--Datetime filter
 L_breakdown.StartOfBreakdown  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())
AND
--robot name filter 
((c_controller.controller_name BETWEEN    @RobotFilterMaskStart AND @RobotFilterMaskEnd))
AND
(c_controller.controller_name LIKE @RobotFilterWild)
--Location Filter
AND
(ISNULL(c_controller.location,'') LIKE @LocationFilterWild )
AND
--Exclude Gatestops 
((@ExcludeGateStops = 1 AND (ISNULL(c_logclass1.subgroup,'') NOT LIKE '%Gate/Hold%')) OR @ExcludeGateStops =0)
AND
--enable bit
(@GetC4GDowntimes = 1)
--filter small breakdowns 
AND DATEDIFF(MINUTE,L_breakdown.StartOfBreakdown,L_breakdown.EndOfBreakdown) > @minDowntime 
---------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G Qry Slowspeed (Robot that are running slow)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT  
              c_controller.location AS 'Location',
			  c_controller.controller_name AS 'Robot',
              'C4G' AS 'Type',
			  'SLOWSPEED',
			     CASE 
				 --case robot stil slow event ongoing
                    WHEN #C4GSpeedcheck.TimestampOK is null THEN  convert(char(19),ISNULL(#C4GSpeedcheck.TimestampOK,getdate()),120) 
                 --case robot already back on 100% 
				    ELSE convert(char(19),#C4GSpeedcheck.TimestampNOK,120) 
                 END AS 'Timestamp',
			  '99003' AS 'Logcode',
              '20' AS 'Severity',
              'CurrentSpeed: ' + #C4GSpeedcheck.ActiveSpeed + ' Slowspeed: '  + ISNULL(#C4GSpeedcheck.OldSpeedValue,'##') +  ' Since:  ' + convert(char(19),ISNULL(#C4GSpeedcheck.TimestampOK,#C4GSpeedcheck.TimestampNOK),120) + ' Hours: ' + CAST(#C4GSpeedcheck.hours as varchar(4)) AS 'Logtekst',
			  NULL as 'DT',
              DATEPART(YEAR, ISNULL(#C4GSpeedcheck.TimestampOK,getdate())) AS 'Year',
			  DATEPART(WEEK,ISNULL(#C4GSpeedcheck.TimestampOK,getdate())) AS 'Week',
			  GADATA.dbo.fn_volvoday(ISNULL(#C4GSpeedcheck.TimestampOK,getdate()),CAST(ISNULL(#C4GSpeedcheck.TimestampOK,getdate()) AS time)) AS 'day',
			  GADATA.dbo.fn_volvoshift1(ISNULL(#C4GSpeedcheck.TimestampOK,getdate()),CAST(ISNULL(#C4GSpeedcheck.TimestampOK,getdate()) AS time)) AS 'Shift',
			  'speed' AS 'Object',
			  'speed' AS 'Subgroup',
			  --debug collums
              --SysBreakDwn.sys_state,
              --CAST(SysBreakDwn.rnDESC AS int) AS 'rnDESC',
              1 AS 'idx'
              --CAST(SysBreakDwn.SysBreakDwnIndx AS int) AS 'SSidx'
			  
            
FROM #C4GSpeedcheck
--join the controller name
JOIN    c_controller ON (#C4GSpeedcheck.controller_id = c_controller.id) 
WHERE 
--robot name filter 
((c_controller.controller_name BETWEEN    @RobotFilterMaskStart AND @RobotFilterMaskEnd))
AND
(c_controller.controller_name LIKE @RobotFilterWild)
--Location Filter
AND
(ISNULL(c_controller.location,'') LIKE @LocationFilterWild )
AND
--enable bit
(@GetC4GSpeedCheck = 1)

---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G Alarm information (error log)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT 
              c_controller.location AS 'Location',
			  c_controller.controller_name AS 'Robot',
              'C4G' AS 'Type',
			  'ERROR' AS 'Errortype',
              convert(char(19),(rt_alarm._timestamp + '1900-01-01 00:00:05.00'),120) AS 'timestamp',--  because the err event is always a little bit quicker than the Sys event
              ISNULL(c_logtekst.error_number, rt_alarm.error_number) AS 'Logcode',
			  ISNULL(c_logtekst.error_severity, rt_alarm.error_severity) AS 'Severity',
			  ISNULL(c_logtekst.error_text,rt_alarm.error_text) AS 'Logtekst',
			  NULL AS 'DT',
			  DATEPART(YEAR, rt_alarm._timestamp) AS 'Year',
			  DATEPART(WEEK,rt_alarm._timestamp) AS 'Week',
			  GADATA.dbo.fn_volvoday(rt_alarm._timestamp,CAST(rt_alarm._timestamp AS time)) AS 'day',
			  --DATEPART(WEEKDAY,rt_alarm._timestamp) AS 'Day',
			  GADATA.dbo.fn_volvoshift1(rt_alarm._timestamp,CAST(rt_alarm._timestamp AS time)) AS 'Shift',
			  c_logclass1.appl AS 'Object',
			  c_logclass1.subgroup AS 'Subgroup',
              --debug collums
              --NULL, --SysEventTime.sys_state,
              --NULL AS 'rnDESC',
              CAST(rt_alarm.id AS int) AS 'idx'
              --NULL AS 'SSidx'
			  
FROM    GADATA.dbo.rt_alarm rt_alarm
--join the controller name
JOIN    c_controller ON (rt_alarm.controller_id = c_controller.id)
--join logtekst table
LEFT JOIN c_logtekst ON (c_logtekst.id = rt_alarm.error_id)

--try and get an error classification
LEFT JOIN GADATA.dbo.c_logclass1 as c_logclass1 ON 
(
(isnull(c_logtekst.error_number, rt_alarm.error_number) BETWEEN c_logclass1.error_codeStart AND c_logclass1.error_codeEnd)
OR
(isnull(c_logtekst.error_text, rt_alarm.error_text) LIKE c_logclass1.error_tekst)
) 

WHERE 
--datetime filter
rt_alarm._timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())
AND
--robot name filter 
 (c_controller.controller_name BETWEEN    @RobotFilterMaskStart AND @RobotFilterMaskEnd )
 AND  
 (c_controller.controller_name LIKE @RobotFilterWild)
 --Location Filter
 AND
(ISNULL(c_controller.location,'') LIKE @LocationFilterWild )
 AND
 --Exclude Gatestops 
(
(@ExcludeGateStops = 1 AND (ISNULL(c_logclass1.subgroup,'') NOT LIKE '%Gate/Hold%')) 
OR 
@ExcludeGateStops =0
)
--exclude certin logcodes 
AND 
not rt_alarm.error_number in (24505)
 --minimum log serverity
 AND
 (rt_alarm.error_severity  > (@MinLogserv-1))
 --Enable bit 
 AND
 (@GetC4Gerror = 1)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C3G Alarm information (error log)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT 
              Robot.location AS 'Location',
			  Robot.RobotName AS 'Robot',
              'C3G' AS 'Type',
			  'ERROR' AS 'Errortype',
              rt_alarm.error_timestamp AS 'timestamp',
              rt_alarm.error_number AS 'Logcode',
              rt_alarm.error_severity AS 'Severity',
              isnull(rt_alarm.error_text,RobotLogText.LogText) AS 'Logtekst',
              NULL AS 'DT',
			  DATEPART(YEAR, rt_alarm.error_timestamp) AS 'Year',
			  DATEPART(WEEK,rt_alarm.error_timestamp) AS 'Week',
			  --DATEPART(WEEKDAY,RobotLog.DateTime) AS 'Day',
			  GADATA.dbo.fn_volvoday(rt_alarm.error_timestamp,CAST(rt_alarm.error_timestamp AS time)) AS 'day',
			  GADATA.dbo.fn_volvoshift1(rt_alarm.error_timestamp,CAST(rt_alarm.error_timestamp AS time)) AS 'Shift',
			  c_logclass1.appl AS 'Object',
			  c_logclass1.subgroup AS 'Subgroup',
              --debug collums
              --NULL, --SysEventTime.sys_state,
              --NULL AS 'rnDESC',
              CAST(rt_alarm.id AS int) AS 'idx'
              --NULL AS 'SSidx'
			  
FROM    GADATA.RobotGA.rt_alarm
--join the controller name
JOIN    GADATA.RobotGA.Robot ON (rt_alarm.controller_id = Robot.id)
--joint the logtekst
LEFT JOIN GADATA.RobotGA.RobotLogText ON (rt_alarm.error_text_id = RobotLogText.id)

--try and get an error classification
LEFT JOIN GADATA.dbo.c_logclass1 as c_logclass1 ON 
(
(rt_alarm.error_number BETWEEN c_logclass1.error_codeStart AND c_logclass1.error_codeEnd)
OR
(RobotLogText.LogText LIKE c_logclass1.error_tekst)
) 


WHERE
--only C3G robots
Robotga.robot.Type = 1

AND 
--date time filter
rt_alarm.error_timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())
AND
--robot name filter 
(Robot.RobotName BETWEEN    @RobotFilterMaskStart AND @RobotFilterMaskEnd )
AND  
(Robot.RobotName LIKE @RobotFilterWild)
--Location Filter
AND
(ISNULL(Robot.location,'') LIKE @LocationFilterWild ) 
AND
 --Exclude Gatestops 
(
(@ExcludeGateStops = 1 AND (ISNULL(c_logclass1.subgroup,'') NOT LIKE '%Gate/Hold%')) 
OR 
@ExcludeGateStops =0
)
--minimum log serverity
AND
(rt_alarm.error_severity  > (@MinLogserv-1))
--enable bit
AND
@GetC3GError = 1

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--c4g down right now 
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT  
              c_controller.location AS 'Location',
			  c_controller.controller_name AS 'Robot',
              'C4G' AS 'Type',
			  'BEZIG',
              convert(char(19),#SysBreakDwnTime.oktimestamp,120) AS 'Timestamp',
              #SysBreakDwnTime.error_number AS 'Logcode',
              20 AS 'Severity',
              ISNULL('State: ' + CAST(GADATA.dbo.fn_decodeSysstate(#SysBreakDwnTime.sys_state) AS varchar) + '|  Err: '  + #SysBreakDwnTime.error_text,'State: ' + CAST(GADATA.dbo.fn_decodeSysstate(#SysBreakDwnTime.sys_state) AS varchar)) AS 'Logtekst',
			  downtime as 'DT',
              DATEPART(YEAR, #SysBreakDwnTime.oktimestamp) AS 'Year',
			  DATEPART(WEEK,#SysBreakDwnTime.oktimestamp) AS 'Week',
			  GADATA.dbo.fn_volvoday(#SysBreakDwnTime.oktimestamp,CAST(#SysBreakDwnTime.oktimestamp AS time)) AS 'day',
			 -- DATEPART(WEEKDAY,L_breakdown.StartOfBreakdown)AS 'day',
			  GADATA.dbo.fn_volvoshift1(#SysBreakDwnTime.oktimestamp,CAST(#SysBreakDwnTime.oktimestamp AS time)) AS 'Shift',
			  c_logclass1.APPL AS 'Object',
			  c_logclass1.subgroup AS 'Subgroup',
			  
			  --debug collums
              --SysBreakDwn.sys_state,
              --CAST(SysBreakDwn.rnDESC AS int) AS 'rnDESC',
              #SysBreakDwnTime.id
              --CAST(SysBreakDwn.SysBreakDwnIndx AS int) AS 'SSidx'
			  
            
FROM #SysBreakDwnTime
--join the controller name
JOIN    c_controller ON (#SysBreakDwnTime.controller_id = c_controller.id) 
--try and get an error classification
LEFT JOIN GADATA.dbo.c_logclass1 as c_logclass1 ON 
(
(#SysBreakDwnTime.error_number BETWEEN c_logclass1.error_codeStart AND c_logclass1.error_codeEnd)
OR
(#SysBreakDwnTime.error_text LIKE c_logclass1.error_tekst)
)

WHERE 
SysBreakDwnIndx = 1 and OKtimestamp > (getdate()-'1900-01-01 00:0:5.00') AND (error_text is not null OR sys_state = 262144) -- AND downtime > 5 

---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------
UNION
SELECT DISTINCT  
              NULL AS 'Location',
			  L_operation.Vcsc_name AS 'Robot',
              'C4G' AS 'Type',
			  'BEZIG',
              convert(char(19),(getdate()+'1900-01-02 00:0:0.00'),120) AS 'Timestamp',
              NULL AS 'Logcode',
              20 AS 'Severity',
			  CASE 
			  WHEN #L_operationActRobState.vcsc_name LIKE '%%' THEN 'Serivce center OK'
			  ELSE  '!!!! NO DATA FOR 60 minutes might be down !!!!  NOK'
			  END AS 'Logtekst',
			  NULL AS 'DT',
              NULL AS 'Year',
			  NULL AS 'Week',
			  NULL AS 'day',
			  NULL AS 'Shift',
			  null AS 'Object',
			  null AS 'Subgroup',
              NULL AS 'id'

FROM GADATA.dbo.L_operation
LEFT JOIN #L_operationActRobState ON
(#L_operationActRobState.Vcsc_name = L_operation.Vcsc_name)
AND
(#L_operationActRobState._timestamp  > (GETDATE()-'1900-01-01 01:00:00.00'))

WHERE #L_operationActRobState.vcsc_name is null
---------------------------------------------------------------------------------------

ORDER BY   Timestamp DESC --robotname,
--*/


END