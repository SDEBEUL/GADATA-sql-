

--function to drop all non alpha numc from a string 
/*
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[udf_GetNumeric]
(@strAlphaNumeric VARCHAR(256))
RETURNS VARCHAR(256)
AS
BEGIN
DECLARE @intAlpha INT
SET @intAlpha = PATINDEX('%[^0-9]%', @strAlphaNumeric)
BEGIN
WHILE @intAlpha > 0
	BEGIN
 
		SET @strAlphaNumeric =  STUFF(@strAlphaNumeric, @intAlpha, 1, '' )
		SET @intAlpha = PATINDEX('%[^0-9]%', @strAlphaNumeric )
	END
END
RETURN ISNULL(@strAlphaNumeric,0)
END
*/

--str search funtion that returns boolean if exists 
/*
CREATE FUNCTION dbo.udf_StringConains
(@instr VARCHAR(256)
,@Search VARCHAR(256)
)
RETURNS int
AS
BEGIN
DECLARE @result int
IF  CHARINDEX(@Search, @instr ) > 0     
set @result = 1
ELSE    
set @result = 0
RETURN ISNULL(@result,0)
END
GO
*/

CREATE PROCEDURE [dbo].[sp_Decode_rackfaults]
AS
--USE GADATA
---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1

BEGIN
SELECT  DISTINCT
    Robot.RobotName
   ,rt_alarm.error_number
   ,isnull(rt_alarm.error_text,RobotLogText.LogText) as 'error_text'
  -- ,RobotLog.DateTime
   ,dbo.udf_StringConains(robotlogtext.logtext, 'Cancel for') as 'Cancel'
 --,dbo.udf_GetNumeric(robotlogtext.logtext) as 'numbers' 
   ,SUBSTRING(dbo.udf_GetNumeric(robotlogtext.logtext),1,1) as 'RACK'
   ,SUBSTRING(dbo.udf_GetNumeric(robotlogtext.logtext),2,1) as 'ROW'
   ,SUBSTRING(dbo.udf_GetNumeric(robotlogtext.logtext),3,1) as 'PART'
   ,DATEPART(week,rt_alarm.error_timestamp) AS 'WEEK'
   ,GADATA.dbo.fn_volvoday(rt_alarm.error_timestamp,CAST(rt_alarm.error_timestamp AS time)) AS 'DAY'
   ,GADATA.dbo.fn_volvoshift(rt_alarm.error_timestamp,CAST(rt_alarm.error_timestamp AS time)) AS 'SHIFT'
   ,DATEPART(hour,rt_alarm.error_timestamp) AS 'HOUR'
   ,DATEPART(MINUTE,rt_alarm.error_timestamp) AS 'MINUTE'
  

FROM gadata.RobotGA.rt_alarm
JOIN RobotGA.RobotLogText on robotlogtext.id = rt_alarm.controller_id
JOIN RobotGA.Robot on rt_alarm.controller_id = robot.ID

WHERE 
(
robot.robotname LIKE '%13030R57%'
AND 
rt_alarm.error_number = 43900
)

/*
group by 
robot.RobotName,
robotlogtext.LogText,
dateadd(minute, 1440 + (datediff(minute, 0, RobotLog.DateTime)) / 1440, 0)
*/

END