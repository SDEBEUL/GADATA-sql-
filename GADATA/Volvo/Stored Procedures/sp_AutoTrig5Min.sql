









CREATE PROCEDURE [Volvo].[sp_AutoTrig5Min]
AS
BEGIN


--normalize rt weldgun cylinder data
exec [C3G].[sp_normalize_GunCylinder] --4
--remove dups from c3g toollog system
exec [C3G].[sp_rt_toollog_REMOVE_DUP] --37
--check for new alerts
exec GADATA.volvo.sp_AlertCheck --3:51
--c4g process sbcu data 
--exec GADATA.C4G.sp_update_ToolLog

--exec gadata.[C3G].[sp_normalize_CycleTime] --6
--abb s4 
exec GADATA.abb.sp_Decode_AE_S4 --1
exec GADATA.abb.sp_update_L_S4 --4
--abb irc5
exec GADATA.abb.sp_Decode_AE_IRC5 --1
exec GADATA.abb.sp_update_L_IRC5 --
--abb global
exec GADATA.abb.sp_update_Lerror_classifcation

print 'test for glue import'/*
--start
EXEC GADATA.GLUE.sp_update_L_Alarm --20
EXEC GADATA.GLUE.sp_update_L_Operator --19*/
EXEC GADATA.GLUE.sp_vultijd --58
EXEC GADATA.GLUE.sp_vultijd2 --6:24 en nog ni klaar
/*EXEC GADATA.GLUE.sp_vultijd_viewer --1:13
EXEC GADATA.GLUE.sp_vultijd_gemiddelde --10
EXEC GADATA.QUISS.sp_QUISS_data --1*/
--end

Print 'Test for [Volvo].[sp_AutoTrig5Min]'
EXEC GADATA.volvo.sp_Alog  @rowcount = 0, @Request = '5 Min auto Trig'

END