


CREATE PROCEDURE [Volvo].[sp_AutoTrig1Day]
AS
BEGIN
Print 'Test for [Volvo].[sp_AutoTrig1Day]'
EXEC GADATA.volvo.sp_Alog  @rowcount = 0, @Request = '1 Day auto Trig'

exec GADATA.C3G.sp_Housekeeping
exec GADATA.C4g.sp_Housekeeping
exec GADATA.ABB.sp_Housekeeping



---clean up activity log keep last 30 
DELETE GADATA.volvo.L_ActivityLog
select * from gadata.volvo.l_activitylog as l 
where l._timestamp < getdate()-30



END