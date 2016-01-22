
CREATE PROCEDURE [Volvo].[sp_AutoTrig5Min]
AS
BEGIN
--normalize rt weldgun cylinder data
exec [C3G].[sp_normalize_GunCylinder]
--check for new alerts
exec GADATA.volvo.sp_AlertCheck

--abb s4 
exec GADATA.abb.sp_Decode_AE_S4
exec GADATA.abb.sp_update_L_S4

--abb irc5
 exec GADATA.abb.sp_Decode_AE_IRC5
 exec GADATA.abb.sp_update_L_IRC5

--abb global
exec GADATA.abb.sp_UPDATE_abb_APPL_Subgroup

--comau robotpostions
exec [C4g].[sp_L_Robotpositions_REMOVE_DUP]

Print 'Test for [Volvo].[sp_AutoTrig5Min]'
EXEC GADATA.volvo.sp_Alog  @rowcount = 0, @Request = '5 Min auto Trig'
END