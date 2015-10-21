


CREATE PROCEDURE [Volvo].[sp_AutoTrig1Day]
AS
BEGIN
Print 'Test for [Volvo].[sp_AutoTrig1Day]'
EXEC GADATA.volvo.sp_Alog  @rowcount = 0, @Request = '1 Day auto Trig'

exec GADATA.C3G.sp_Housekeeping
exec GADATA.C4g.sp_Housekeeping
END