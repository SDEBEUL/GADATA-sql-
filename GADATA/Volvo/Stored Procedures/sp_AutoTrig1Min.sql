


CREATE PROCEDURE [Volvo].[sp_AutoTrig1Min]
AS
BEGIN

Print 'Test for [Volvo].[sp_AutoTrig1Min]'
EXEC GADATA.volvo.sp_Alog  @rowcount = 0, @Request = '1 Min auto Trig'

-- C3g
exec GADATA.C3G.sp_update_L
exec GADATA.C3G.sp_L_breakdown

--C4G
exec [C4G].[sp_update_L]
exec [C4G].sp_Update_L_breakdown
exec [C4G].sp_ReClass_L_breakdown

END