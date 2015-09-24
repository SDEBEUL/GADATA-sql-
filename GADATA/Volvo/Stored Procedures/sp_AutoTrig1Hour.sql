


CREATE PROCEDURE [Volvo].[sp_AutoTrig1Hour]
AS
BEGIN
Print 'Test for [Volvo].[sp_AutoTrig1Hour]'
EXEC GADATA.volvo.sp_Alog  @rowcount = 0, @Request = '1 Hour auto Trig'
END