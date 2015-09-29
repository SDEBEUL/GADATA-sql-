







CREATE VIEW [C4G].[sysstate]
AS
SELECT  
              C.location AS 'Location',
			  C.controller_name AS 'Robotname',
              'C4G' AS 'Type',
			  'EVENT' AS 'Errortype',
			  Y._timestamp AS 'Timestamp',
              NULL AS 'Logcode',
              NULL AS 'Severity',
              '  Code: ' + CAST(Y.Sys_state AS varchar) +   '  SysState: ' + (GADATA.dbo.fn_decodeSysstate(y.Sys_state)) AS 'Logtekst',
              NULL AS 'Downtime',
              T.Vyear AS 'Year',
			  T.Vweek AS 'Week',
			  T.Vday AS 'Day',
			 T.[Shift] AS 'Shift',
			  'Event'  AS 'Object',
			  'Event'  AS 'Subgroup',
              CAST(Y.id AS int) AS 'idx'

FROM  GADATA.dbo.rt_sys_event as Y
--join the controller name
LEFT JOIN    GADATA.dbo.c_controller as C ON (Y.controller_id = C.id) 
--join the timeline
LEFT JOIN GADATA.VOLVO.L_timeline AS T ON ( Y._timestamp BETWEEN T.starttime AND T.endtime)

--data from L_operation (to catch robots offline)
UNION
SELECT 
              C.location AS 'Location',
			  C.controller_name AS 'Robotname',
              'C4G' AS 'Type',
			  'EVENT' AS 'Errortype',
			  Y._timestamp AS 'Timestamp',
              NULL AS 'Logcode',
              NULL AS 'Severity',
              'Code: 0  SysState: Disconnected' AS 'Logtekst',
              NULL AS 'Downtime',
              T.Vyear AS 'Year',
			  T.Vweek AS 'Week',
			  T.Vday AS 'Day',
			  T.[Shift] AS 'Shift',
			  'Event'  AS 'Object',
			  'Event'  AS 'Subgroup',
              CAST(Y.id AS int) AS 'idx'
			FROM GADATA.dbo.l_operation  AS y
--join the controller name
LEFT JOIN    GADATA.dbo.c_controller as C ON (Y.controller_id = C.id) 
--join the timeline
LEFT JOIN GADATA.VOLVO.L_timeline AS T ON ( Y._timestamp BETWEEN T.starttime AND T.endtime)
WHERE (y.code = 4) --connection lost 