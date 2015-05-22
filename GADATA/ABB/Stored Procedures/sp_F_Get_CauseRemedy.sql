CREATE PROCEDURE [ABB].[sp_F_Get_CauseRemedy]
   @H_alarmID as int
AS
begin
select top 1 
'CAUSE: ' + ISNULL(L_Cause.cause_text,'not available') + 'REMEDY: ' + ISNULL(L_Cause.cause_text,'not available') as 'ERRinfo'
from GADATA.abb.h_alarm
LEFT join abb.L_Cause on L_cause.id = h_alarm.cause_id
LEFT join abb.L_Remedy on L_Remedy.id = h_alarm.remedy_id
WHERE h_alarm.id = @H_alarmID


end