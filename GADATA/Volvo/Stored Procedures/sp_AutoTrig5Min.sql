


CREATE PROCEDURE [Volvo].[sp_AutoTrig5Min]
AS
BEGIN

Print 'Test for [Volvo].[sp_AutoTrig5Min]'
EXEC GADATA.volvo.sp_Alog  @rowcount = 0, @Request = '5 Min auto Trig'
END