CREATE PROCEDURE [dbo].[MinitabTest]
   @Robot as varchar(16) = '55100R02' --test 
   ,@Tool_id as varchar(16) = '1'
AS
BEGIN

SELECT
 rt_toollog.tool_timestamp, 
 rt_toollog.Dsetup
 FROM GADATA.RobotGA.Robot Robot, GADATA.RobotGA.rt_toollog rt_toollog 
 WHERE rt_toollog.controller_id = Robot.ID 
 AND 
 Robot.RobotName = @Robot
 AND
 rt_toollog.tool_id = @Tool_id 

ORDER BY rt_toollog.tool_timestamp ASC

END



