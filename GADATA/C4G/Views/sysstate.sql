




CREATE VIEW [C4G].[sysstate]
AS

WITH Y AS
(
SELECT      
*
, ROW_NUMBER() OVER (PARTITION BY x.controller_id ORDER BY x._timestamp DESC) AS rnDESC
FROM            

(
/*data from rt_sys_event table. */ 
SELECT 
  rt_sys_event.id
, rt_sys_event.controller_id
, rt_sys_event._timestamp
, rt_sys_event.sys_state
, robotState = dbo.fn_robstate(rt_sys_event.sys_state)
/*calculates a robot state a running robot has 2 a non running one 0 */ 
FROM GADATA.dbo.rt_sys_event AS rt_sys_event
where _timestamp between getdate()-1 and getdate()
/*data from L_operation (to catch robots goning offline)*/ 
UNION
SELECT        
  l_operation.id
, l_operation.controller_id
, l_operation._timestamp
, sys_state = 262144
, robotState = 0
FROM            GADATA.dbo.l_operation AS l_operation
WHERE (l_operation.code = 4)/*connection lost */ 
) 

AS x
)

--Calc time in state for passed events. (not current event) 
SELECT  
              C.location AS 'Location',
			  C.controller_name AS 'Robotname',
              'C4G' AS 'Type',
			  'EVENT' AS 'Errortype',
			  convert(char(19),Y._timestamp,120) AS 'Timestamp',
              NULL AS 'Logcode',
              CAST(dbo.fn_robstate(Y.Sys_state) AS varchar(2)) AS 'Severity',
              'Time: ' + convert(Char(8),(YL._timestamp - Y._timestamp),108) + '  Code: ' + CAST(Y.Sys_state AS varchar) +   '  SysState: ' + (dbo.fn_decodeSysstate(y.Sys_state)) AS 'Logtekst',
              NULL AS 'Downtime',
              T.Vyear AS 'Year',
			  T.Vweek AS 'Week',
			  T.Vday AS 'Day',
			 T.[Shift] AS 'Shift',
			  'Event'  AS 'Object',
			  'Event'  AS 'Subgroup',
              CAST(Y.rndesc AS int) AS 'idx'

FROM  Y 
--join the controller name
LEFT JOIN    GADATA.dbo.c_controller as C ON (Y.controller_id = C.id) 
--join the timeline
LEFT JOIN GADATA.VOLVO.L_timeline AS T ON ( Y._timestamp BETWEEN T.starttime AND T.endtime)
--join each event on next event (for TIS)     
JOIN  Y AS YL ON 
(Y.rnDESC = YL.rnDESC + 1)  
AND 
(Y.controller_id = YL.controller_id) 
AND 
(Y.rnDESC <> 1)

---Calc time in state for ongoning event (last current event)
UNION
SELECT  
              C.location AS 'Location',
			  C.controller_name AS 'Robotname',
              'C4G' AS 'Type',
			  'EVENT' AS 'Errortype',
			  convert(char(19),Y._timestamp,120) AS 'Timestamp',
              NULL AS 'Logcode',
              CAST(dbo.fn_robstate(Y.Sys_state) AS varchar(2)) AS 'Severity',
              'Time: ' + convert(Char(8),(GETDATE() - Y._timestamp),108) + '  Code: ' + CAST(Y.Sys_state AS varchar) +   '  SysState: ' + (dbo.fn_decodeSysstate(y.Sys_state)) AS 'Logtekst',
              NULL AS 'Downtime',
              T.Vyear AS 'Year',
			  T.Vweek AS 'Week',
			  T.Vday AS 'Day',
			 T.[Shift] AS 'Shift',
			  'Event'  AS 'Object',
			  'Event'  AS 'Subgroup',
              CAST(Y.rndesc AS int) AS 'idx'

FROM  Y 
--join the controller name
LEFT JOIN    GADATA.dbo.c_controller as C ON (Y.controller_id = C.id) 
--join the timeline
LEFT JOIN GADATA.VOLVO.L_timeline AS T ON (Y._timestamp BETWEEN T.starttime AND T.endtime)
WHERE (Y.rnDESC = 1)