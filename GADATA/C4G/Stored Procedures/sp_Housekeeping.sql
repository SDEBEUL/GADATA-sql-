
CREATE PROCEDURE [C4G].[sp_Housekeeping]
AS
BEGIN

--remove all data older then 100 days
DELETE FROM [c4g].[rt_value]
WHERE rt_value._timestamp < (getdate()-50)
--
DELETE FROM [c4g].[rt_sys_event]
WHERE [rt_sys_event]._timestamp < (getdate()-50)
--
DELETE FROM [c4g].[rt_not_saved]
WHERE [rt_not_saved]._timestamp < (getdate()-50)
--
DELETE FROM [c4g].rt_file
WHERE rt_file._timestamp < (getdate()-50)
 
--
DELETE FROM [c4g].rt_GEN_OVR
WHERE rt_GEN_OVR._timestamp < (getdate()-30)
--
DELETE FROM [c4g].rt_collLog
WHERE rt_collLog._timestamp < (getdate()-14)

end