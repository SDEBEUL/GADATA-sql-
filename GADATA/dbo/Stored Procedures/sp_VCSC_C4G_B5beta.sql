--Sp calls the new system... LEGANCY SUPPORT 
CREATE PROCEDURE [dbo].[sp_VCSC_C4G_B5beta]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @Daysback as int = 1,
   @RobotFilterWild as varchar(10) = '%',
   @RobotFilterMaskStart as varchar(10) = '%',
   @RobotFilterMaskEnd as varchar(10) = '99999R99%',
   @LocationFilterWild as varchar(20) = '%',

   @OrderbyRobot as bit = null,
  
   @GetC4GAction as bit = 1,
   @GetC4Gerror as bit = 1,
   @GetC4GEvents as bit = 0,
   @GetC4GDowntimes as bit = 1,
   @GetC4GDownTBegin as bit = 1,
   @GetC4GCollisions as bit = 0,
   @GetC4GSpeedCheck as bit = 0,
   @GetC3GError as bit = 1,
   @GetModification as bit = 0,

   @ExcludeGateStops as bit = 0,
   @MinLogserv as int = 0
AS
BEGIN
EXEC GADATA.Volvo.sp_GADATAFront
--timeparameters
   @StartDate  = @StartDate,
   @EndDate  = @EndDate,
--BooleanParms
   @Timeline  = 0,
   @ExcludeGateStops  = @ExcludeGateStops,
--Filterparameters.
   @RobotFilterWild = @RobotFilterWild,
   @LocationFilterWild = @LocationFilterWild,
--COMAU C4G booleans
   @GetC4GAction = @GetC4GAction,
   @GetC4Gerror= @GetC4Gerror,
   @GetC4GEvents = @GetC4GEvents,
   @GetC4GDowntimes = @GetC4GDowntimes,
   @GetC4GDownTBegin = @GetC4GDownTBegin,
   @GetC4GCollisions = @GetC4GCollisions,
--Comau C3G Booleans   
   @GetC3GError =  @GetC4Gerror,
--optional pars
   @MinLogserv = @MinLogserv, 

--blocked pars 
   @GetC4GSBCU = 0,  
   @GetTimerWear = 0,
   @GetC4GSpeedCheck = 0

EXEC GADATA.volvo.sp_Alog  @rowcount = 0, @Request = 'Running: [dbo].[sp_VCSC_C4G_B5beta] => DUMMYCALL'

END