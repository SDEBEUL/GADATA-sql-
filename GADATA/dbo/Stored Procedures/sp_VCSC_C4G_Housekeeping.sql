CREATE PROCEDURE [dbo].[sp_VCSC_C4G_Housekeeping]
AS
BEGIN
--replaces logtext in rt_alarm C4G
EXEC [sp_VCSC_C4G_Rt_alarm_logCleanup] 
--replaces logtext in rt_alarm C3G
exec [sp_VCSC_C3G_Rt_alarm_logCleanup]

--remove all data older then 100 days
DELETE FROM [dbo].[rt_value]
WHERE rt_value._timestamp < (getdate()-50)
--
DELETE FROM [dbo].[rt_sys_event]
WHERE [rt_sys_event]._timestamp < (getdate()-50)
--
DELETE FROM [dbo].[rt_not_saved]
WHERE [rt_not_saved]._timestamp < (getdate()-50)
END