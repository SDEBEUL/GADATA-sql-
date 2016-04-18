


CREATE PROCEDURE [Volvo].[sp_AutoTrig1Hour]
AS
BEGIN
Print 'Test for [Volvo].[sp_AutoTrig1Hour]'
EXEC GADATA.volvo.sp_Alog  @rowcount = 0, @Request = '1 Hour auto Trig'

--comau robotpostions
exec [C4g].[sp_L_Robotpositions_REMOVE_DUP]
exec [C3G].[sp_L_Robotpositions_REMOVE_DUP] 
END