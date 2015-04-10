CREATE PROCEDURE [dbo].[sp_VCSC_C4G_Getbreakdown]
   @BreakdownIDX as int = 949980
AS
BEGIN

DECLARE @getrobot varchar(10)
set @getrobot = (select c_controller.controller_name from GADATA.dbo.c_controller where c_controller.id = (select L_breakdown.controller_id  FROM GADATA.dbo.L_breakdown where L_breakdown.idx = @BreakdownIDX))

DECLARE @getfrom datetime
set @getfrom =(select L_breakdown.StartOfBreakdown  FROM GADATA.dbo.L_breakdown where L_breakdown.idx = @BreakdownIDX)

DECLARE @getuntil datetime
set @getuntil =(select L_breakdown.EndOfBreakdown  FROM GADATA.dbo.L_breakdown where L_breakdown.idx = @BreakdownIDX)

EXEC GADATA.dbo.sp_VCSC_C4G_B4beta 
  @GetC3GError = 0
, @GetC4GError = 1
, @GetC4GAction = 0
, @GetC4GEvents = 1
, @GetC4GDowntimes = 1
, @GetC4GDownTBegin = 1
, @ExcludeGateStops = 0 
, @StartDate = @getfrom
, @EndDate = @getuntil
, @RobotFilterWild = @getrobot

END