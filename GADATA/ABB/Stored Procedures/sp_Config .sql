CREATE PROCEDURE [ABB].[sp_Config ]
AS
begin
--********************************************************************************--
--trigger management															  --
--********************************************************************************--
DISABLE TRIGGER ABB_IRC5_normalize_trigger ON gadata.abb.rt_alarm_IRC5;
DISABLE TRIGGER ABB_IRC5_message_trigger ON gadata.dbo.rt_message;
--********************************************************************************--
DISABLE TRIGGER ABB_S4_normalize_trigger ON gadata.abb.rt_alarm_S4;
DISABLE TRIGGER ABB_s4_message_trigger ON gadata.dbo.rt_message_ABB_s4;
--********************************************************************************--
DISABLE TRIGGER ABB_L_error_Apply_appl_subgroups ON gadata.abb.L_error;
--********************************************************************************--
Select* from sys.triggers
--********************************************************************************--
--********************************************************************************--

end