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


--if (OBJECT_ID('GADATA.VOLVO.L_liveView') is not null) drop table GADATA.VOLVO.L_liveView
DELETE GADATA.volvo.L_liveView FROM GADATA.volvo.L_liveView
INSERT INTO GADATA.VOLVO.L_liveView
SELECT * 
--INTO  GADATA.volvo.L_liveView
 FROM
(
--*******************************************************************************************************--
--c4g down right now 
--*******************************************************************************************************--
SELECT 
  isnull(a.LOCATION,c.controller_name+'#')		   AS 'Location' 
, a.CLassificationId   AS 'AssetID'
,'LIVE'		   AS 'Logtype'
,  H.oktimestamp      AS 'timestamp'
,  H.[error_number]	      AS 'Logcode'
,  null			AS 'Severity'
,  'S: ' + GADATA.c4g.fn_decodeSysstate(H.sys_state)  + 
   '  |T: '  + ISNULL(H.error_text,GADATA.C4G.fn_decodeSysstate(H.sys_state))  
AS 'logtext'
, null 	AS 'Response(s)' 
, ABS(H.downtime)AS 'Downtime(s)'
, RTRIM(ISNULL(cc.Classification,'Undefined*'))  AS 'Classification'
, ISNULL(cs.Subgroup,'Undefined*')					   AS 'Subgroup'
, H.id				 AS 'refId'
, a.LocationTree     As 'LocationTree'
, a.ClassificationTree as 'ClassTree'
, c.controller_name		AS 'controller_name'
, 'c4g'		As 'controller_type'

FROM  #SysBreakDwnTime AS H 
LEFT OUTER JOIN C4G.L_error AS L ON L.id = H.error_id 
LEFT OUTER JOIN VOLVO.c_Classification as cc on cc.id = L.c_ClassificationId
LEFT OUTER JOIN VOLVO.c_Subgroup as cs on cs.id = L.c_SubgroupId
--joining of the RIGHT ASSET
LEFT OUTER JOIN equi.ASSETS as A on 
A.controller_type = 'c4g' --join the right 'data controller type'
AND
A.controller_id = h.controller_id --join the right 'data controller id'
AND 
A.CLassificationId LIKE '%' + RTRIM(ISNULL(cc.Classification,'UR')) + '%' --join only the asset with the right classification. (if not classified data goes to robot)
AND
A.controller_ToolID = 1 --temp until we find a multi tool support sollution
--
LEFT JOIN c4g.c_controller as c on c.id = h.controller_id

WHERE 
 (SysBreakDwnIndx = 1 AND H.CombinedRobstate <> 3) --laatste event en robot heeft geen resolved event 
  OR
 (SysBreakDwnIndx = 1  AND (H._timestamp > getdate()-'1900-01-01 00:04:00:000') ) --laatste event of not geen 5 min aan het draaien 
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--supervisie slowspeed c4g
--*******************************************************************************************************--
SELECT
  isnull(a.LOCATION,c.controller_name+'#')		   AS 'Location' 
, a.CLassificationId   AS 'AssetID'
,'SLOWSpeed'		   AS 'Logtype'
,  getdate()    AS 'timestamp'
,  null	      AS 'Logcode'
,  null			AS 'Severity'
, 'WARNING ROBOT SPEED $GEN_ovr:= ' + rtv.value + ' Since: ' + CONVERT(char(19),rtv._timestamp, 120) AS  Logtekst
, null 	AS 'Response(s)' 
, null AS 'Downtime(s)'
, ''  AS 'Classification'
, ''					   AS 'Subgroup'
, null				 AS 'refId'
, a.LocationTree     As 'LocationTree'
, a.ClassificationTree as 'ClassTree'
, c.controller_name		AS 'controller_name'
, 'c4g'		As 'controller_type'
FROM  
(
Select 
*
,ROW_NUMBER() OVER (PARTITION BY rtv.controller_id ORDER BY rtv._timestamp DESC) AS rndesc
FROM
GADATA.C4G.rt_GEN_OVR as rtv
where rtv.variable_id = 11 
) as rtv 
--joining of the RIGHT ASSET
LEFT OUTER JOIN equi.ASSETS as A on 
A.controller_type = 'c4g' --join the right 'data controller type'
AND
A.controller_id = rtv.controller_id --join the right 'data controller id'
AND 
A.CLassificationId LIKE '%URC%'
--
LEFT JOIN c4g.c_controller as c on c.id = rtv.controller_id
WHERE 
rtv.rndesc = 1
AND
rtv.value <> 100

--*******************************************************************************************************--
union
--*******************************************************************************************************--
--supervisie c3G
--*******************************************************************************************************--
SELECT  
  isnull(a.LOCATION,c.controller_name+'#')		   AS 'Location' 
, a.CLassificationId   AS 'AssetID'
,'LIVE'		   AS 'Logtype'
, H.EndOfBreakdown     AS 'timestamp'
, ISNULL(ISNULL(LR.[error_number],L.[error_number]),H.Trig_state)       AS 'Logcode'
,  null			AS 'Severity'
, 'S: '+ GADATA.C3G.[fn_ShortSysstate](H.Active_state) + 
  '  |T: ' + ISNULL(('|R: ' + LR.error_text), Isnull(L.error_text,'Fail: ' + GADATA.C3G.fn_decodeSysstate(H.Trig_state))) 
  AS 'Logtekst'
, DATEDIFF(second,'1900-01-01 00:00:00', H.Rt)		AS 'Response(s)' 
, DATEDIFF(second, H.StartOfBreakdown, H.EndOfBreakdown)AS 'Downtime(s)'
, RTRIM(ISNULL(ISNULL(Rcc.Classification, cc.Classification),'Undefined*'))  AS 'Classification'
, ISNULL(ISNULL(ISNULL(Rcs.Subgroup,cs.Subgroup),GADATA.[C3G].[fn_GetSubgroupFromSysstate2](H.Trig_state)),'Undefined*')  AS 'Subgroup'
, H.id				 AS 'refId'
, a.LocationTree     As 'LocationTree'
, a.ClassificationTree as 'ClassTree'
, c.controller_name		AS 'controller_name'
, 'c3g'		As 'controller_type'
 
FROM   GADATA.C3G.rt_breakdown as H 

LEFT OUTER JOIN C3G.L_error AS L ON L.id = H.error_id 
LEFT OUTER JOIN C3G.L_error as LR ON LR.ID = H.RC_error_id
LEFT OUTER JOIN VOLVO.c_Classification as cc on cc.id = L.c_ClassificationId
LEFT OUTER JOIN VOLVO.c_Subgroup as cs on cs.id = L.c_SubgroupId
LEFT OUTER JOIN VOLVO.c_Classification as Rcc on Rcc.id = LR.c_ClassificationId
LEFT OUTER JOIN VOLVO.c_Subgroup as Rcs on Rcs.id = LR.c_SubgroupId
--joining of the RIGHT ASSET
LEFT OUTER JOIN equi.ASSETS as A on 
A.controller_type = 'c3g' --join the right 'data controller type'
AND
A.controller_id = h.controller_id --join the right 'data controller id'
AND 
A.CLassificationId LIKE '%' + RTRIM(ISNULL(ISNULL(Rcc.Classification, cc.Classification),'UR')) + '%' --join only the asset with the right classification. (if not classified data goes to robot)
AND
A.controller_ToolID = 1 --temp until we find a multi tool support sollution
--
LEFT JOIN c3g.c_controller as c on c.id = h.controller_id
--*******************************************************************************************************--


--*******************************************************************************************************--
--END
--*******************************************************************************************************--
--*******************************************************************************************************--
) as x 

ORDER BY   x.[Timestamp] DESC 
--*/
END