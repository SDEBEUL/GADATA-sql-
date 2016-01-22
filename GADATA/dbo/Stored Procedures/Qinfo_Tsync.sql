CREATE PROCEDURE [dbo].[Qinfo_Tsync]
   @Robot as varchar(16) = '54020R01'
   ,@ErrCode as int = null
   ,@ErrID as int = null
   ,@opt1 as varchar(2000) = null
   ,@user as varchar(16) = null
AS
BEGIN
DECLARE @robType varchar(20)
SET @robType = (select robots.controller_type from GADATA.Volvo.Robots where Robots.controller_name = @robot) 

--case of C3G robot
IF @robType = 'c3g'
BEGIN
SELECT
'LastCall:' = (Select top 1 L_timesync._timestamp from robotga.L_timesync where L_timesync.Robot = @Robot order by _timestamp desc) 
,'LastConfrim:' = (Select top 1 L_timesync.RobotAcktime from robotga.L_timesync where L_timesync.Robot = @Robot order by _timestamp desc)
,'LastRobotTime:' = (Select top 1 L_timesync.Robottime from robotga.L_timesync where L_timesync.Robot = @Robot order by _timestamp desc) 
,'FirstCall:' = (Select top 1 L_timesync._timestamp from robotga.L_timesync where L_timesync.Robot = @Robot order by _timestamp ASC)
,'CountSyncs:' = (Select top 1 count(L_timesync._timestamp) from robotga.L_timesync where L_timesync.Robot = @Robot ) 
, '_' = '_______________________________'
,'GADATAoffset: ' = (SELECT ActiveState.C_timestamp-ActiveState.Timestamp From GADATA.C3G.ActiveState where ActiveState.Robotname LIKE @Robot)
END


IF @robType = 'c4g'
BEGIN
DECLARE @controller_id as int
SET @controller_id  = (SELECT TOP 1 id FROM GADATA.C4G.c_controller where ltrim(rtrim(c_controller.controller_name)) = ltrim(rtrim(@robot)))
DECLARE @offset as datetime
SET @offset = (SELECT TOP 1 C_timestamp-_timestamp FROM GADATA.C4G.h_alarm where h_alarm.controller_id = @controller_id and error_is_alarm = 1 order by id desc)
END
SELECT
 'Controller_id: ' = @controller_id
,'CurrentOffset: ' = @offset
,'CurrentOffsetinMin: ' = DATEDIFF(minute,'1900-01-01',@offset)
,'ServerTime: ' = GETDATE()
,'RobotTime: ' = Getdate() + @offset
, '_' = '_______________________________'
,'For This Errid: ' = @ErrID
,'Controllertime for this error: ' = (SELECT TOP 1 c_timestamp FROM GADATA.C4G.h_alarm where id = @ErrID) 
END