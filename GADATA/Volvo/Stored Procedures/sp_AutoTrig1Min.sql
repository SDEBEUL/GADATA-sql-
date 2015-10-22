


CREATE PROCEDURE [Volvo].[sp_AutoTrig1Min]
AS
BEGIN

Print 'Test for [Volvo].[sp_AutoTrig1Min]'
EXEC GADATA.volvo.sp_Alog  @rowcount = 0, @Request = '1 Min auto Trig'

-- C3g
exec GADATA.C3G.sp_update_L
--exec GADATA.C3G.sp_L_breakdown
exec GADATA.C3G.sp_L_breakdownBETA
--C4G
exec [C4G].[sp_update_L]
exec [C4G].sp_Update_L_breakdown
exec [C4G].sp_ReClass_L_breakdown
exec [Volvo].[LiveView]

--abb s4 
exec GADATA.abb.sp_Decode_AE_S4
exec GADATA.abb.sp_update_L_S4

--abb irc5
 exec GADATA.abb.sp_Decode_AE_IRC5
 exec GADATA.abb.sp_update_L_IRC5

END