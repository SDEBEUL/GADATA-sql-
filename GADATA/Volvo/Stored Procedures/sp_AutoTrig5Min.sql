


CREATE PROCEDURE [Volvo].[sp_AutoTrig5Min]
AS
BEGIN
--normalize rt weldgun cylinder data
exec [C3G].[sp_normalize_GunCylinder]
--check for new alerts
exec GADATA.volvo.sp_AlertCheck

Print 'Test for [Volvo].[sp_AutoTrig5Min]'
EXEC GADATA.volvo.sp_Alog  @rowcount = 0, @Request = '5 Min auto Trig'
END