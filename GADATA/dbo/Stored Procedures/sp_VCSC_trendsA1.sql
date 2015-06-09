CREATE PROCEDURE [dbo].[sp_VCSC_trendsA1]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @Daysback as int = 1,
   @RobotFilterWild as varchar(10) = '%',
   @ApplFilterWild  as varchar(10) = '%',
   @ObjectFilterWild as varchar(10) = '%'
AS
BEGIN


---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G Qry Breakdowns (begin van een storing)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
SELECT  
			  c_controller.controller_name AS 'Robotname',
              'C4G' AS 'Type',
			  'Storing',
              convert(char(19),rt_alarm._timestamp,120) AS 'Timestamp',
              rt_alarm.error_number AS 'Logcode',
              NULL AS 'Severity',
              ISNULL(rt_alarm.error_text,'-----------Breakdown Tag-----------') AS 'Logtekst',
			  NULL as 'DOWNTIME',
              DATEPART(YEAR, rt_alarm._timestamp) AS 'Year',
			  DATEPART(WEEK,rt_alarm._timestamp) AS 'Week',
			  GADATA.dbo.fn_volvoday(rt_alarm._timestamp,CAST(rt_alarm._timestamp AS time)) AS 'day',
			  GADATA.dbo.fn_volvoshift1(rt_alarm._timestamp,CAST(rt_alarm._timestamp AS time)) AS 'Shift',
			  c_logclass1.appl AS 'Object',
			  c_logclass1.subgroup AS 'Subgroup',
              rt_alarm.id
			        
FROM GADATA.dbo.rt_alarm
--join the controller name
JOIN    c_controller ON (rt_alarm.controller_id = c_controller.id) 

--try and get an error classification
LEFT JOIN GADATA.dbo.c_logclass1 as c_logclass1 ON 
(
(rt_alarm.error_number BETWEEN c_logclass1.error_codeStart AND c_logclass1.error_codeEnd)
OR
(rt_alarm.error_text LIKE RTRIM(c_logclass1.error_tekst))
)
WHERE 
--Datetime filter
 rt_alarm._timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-@daysback) AND ISNULL(@EndDate,GETDATE())
AND
(c_controller.controller_name LIKE @RobotFilterWild)
AND 
(c_logclass1.appl LIKE @ApplFilterWild)
AND
(c_logclass1.subgroup LIKE @ObjectFilterWild)
AND 
(c_logclass1.appl NOT LIKE '%Safety%')

---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C3G Alarm information (error log)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT 
			  Robot.RobotName AS 'Robotname',
              'C3G' AS 'Type',
			  'ERROR' AS 'Errortype',
              rt_alarm.error_timestamp AS 'timestamp',
              rt_alarm.error_number AS 'Logcode',
              rt_alarm.error_severity AS 'Severity',
              isnull(rt_alarm.error_text,RobotLogText.LogText) AS 'Logtekst',
              NULL AS 'Downtime',
			  DATEPART(YEAR, rt_alarm.error_timestamp) AS 'Year',
			  DATEPART(WEEK,rt_alarm.error_timestamp) AS 'Week',
			  GADATA.dbo.fn_volvoday(rt_alarm.error_timestamp,CAST(rt_alarm.error_timestamp AS time)) AS 'day',
			  GADATA.dbo.fn_volvoshift1(rt_alarm.error_timestamp,CAST(rt_alarm.error_timestamp AS time)) AS 'Shift',
			  c_logclass1.appl AS 'Object',
			  c_logclass1.subgroup AS 'Subgroup',
              CAST(rt_alarm.id AS int) AS 'idx'
			  
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
(isnull(RobotGA.rt_alarm.error_text,RobotLogText.LogText) LIKE RTRIM(c_logclass1.error_tekst))
) 
WHERE
--only C3G robots
Robotga.robot.Type = 1
AND 
--date time filter
rt_alarm.error_timestamp  BETWEEN ISNULL(@StartDate,GETDATE()-@daysback) AND ISNULL(@EndDate,GETDATE())
--robot name filter
AND  
(Robot.RobotName LIKE @RobotFilterWild)
AND 
(c_logclass1.appl LIKE @ApplFilterWild)
AND
(c_logclass1.subgroup LIKE @ObjectFilterWild)
AND 
(c_logclass1.appl NOT LIKE '%Safety%')

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--timeline
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT 
			  'Timeline' AS 'Robotname',
              'Timeline' AS 'Type',
			  'Timeline' AS 'Errortype',
              L_timeline.starttime AS 'timestamp',
              NULL AS 'Logcode',
              NULL AS 'Severity',
              'Begin of shift' AS 'Logtekst',
              NULL AS 'Downtime',
			  L_timeline.Vyear AS 'Year',
			  L_timeline.Vweek AS 'Week',
			  L_timeline.Vday AS 'day',
			  L_timeline.shift AS 'Shift',
			  'Timeline' AS 'Object',
			  'Timeline' AS 'Subgroup',
              NULL AS 'idx'
			  
FROM    GADATA.VOLVO.L_timeline
WHERE
--date time filter
L_timeline.starttime  BETWEEN ISNULL(@StartDate,GETDATE()-@daysback) AND ISNULL(@EndDate,GETDATE())
---------------------------------------------------------------------------------------
ORDER BY   Timestamp DESC 
END