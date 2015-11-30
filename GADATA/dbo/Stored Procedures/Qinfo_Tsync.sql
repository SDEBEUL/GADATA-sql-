CREATE PROCEDURE [dbo].[Qinfo_Tsync]
   @Robot as varchar(16) = '54020R01'
   ,@ErrCode as int = null
     ,@ErrID as int = null
AS
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