





CREATE PROCEDURE [Volvo].[sp_AutoTrig5Min]
AS
BEGIN


--normalize rt weldgun cylinder data
exec [C3G].[sp_normalize_GunCylinder]
--remove dups from c3g toollog system
exec [C3G].[sp_rt_toollog_REMOVE_DUP]
--check for new alerts
exec GADATA.volvo.sp_AlertCheck
--c4g process sbcu data 
--exec GADATA.C4G.sp_update_ToolLog
exec gadata.[C3G].[sp_normalize_CycleTime]
--abb s4 
exec GADATA.abb.sp_Decode_AE_S4
exec GADATA.abb.sp_update_L_S4
--abb irc5
 exec GADATA.abb.sp_Decode_AE_IRC5
 exec GADATA.abb.sp_update_L_IRC5
--abb global
exec GADATA.abb.sp_UPDATE_abb_APPL_Subgroup

print 'test for glue import'
--start
EXEC GADATA.GLUE.sp_update_L_Alarm
EXEC GADATA.GLUE.sp_update_L_Operator
EXEC GADATA.GLUE.sp_vultijd
EXEC GADATA.GLUE.sp_vultijd2
EXEC GADATA.GLUE.sp_vultijd_viewer
--end

Print 'Test for [Volvo].[sp_AutoTrig5Min]'
EXEC GADATA.volvo.sp_Alog  @rowcount = 0, @Request = '5 Min auto Trig'

END