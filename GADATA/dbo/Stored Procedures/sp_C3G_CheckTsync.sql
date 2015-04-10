CREATE PROCEDURE [dbo].[sp_C3G_CheckTsync]

AS
BEGIN
if (OBJECT_ID('tempdb..#TestTsync') is not null)  DROP TABLE #TestTsync
       select * into #TestTsync from GADATA.RobotGA.L_timesync WHERE L_timesync._timestamp > getdate()-2

select DISTINCT
Robot.RobotName
from GADATA.RobotGA.Robot
LEFT Join #TestTsync on #TestTsync.robot = Robot.RobotName
WHERE #TestTsync._timestamp is null
END