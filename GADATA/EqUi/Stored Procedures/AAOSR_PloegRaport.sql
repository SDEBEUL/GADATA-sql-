



CREATE PROCEDURE [EqUi].[AAOSR_PloegRaport]

--default parameters
    --timeparameters
	   @StartDate as DATETIME = null,
	   @EndDate as DATETIME = null,
	   @daysBack as int = null,
	--Filterparameters.
	   @assets as varchar(10) = '%',
	   @locations as varchar(20) = '%',
	   @lochierarchy as varchar(20) = '%', 
	--non default parms
	   @UseOwnership as bit = 1,
	   @minDowntime as int = 20,
       @minCountOfDowtime as int = 3,
       @minCountofWarning as int = 4,
       @USER as varchar(20) = null,
       @Sortmode as int = 1 --1 shift 2 day 3 week
--gives the right permission when a low level user only has execution rights
with execute as owner
AS
BEGIN

---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--Set default values of start and end date
---------------------------------------------------------------------------------------
if ((@StartDate is null) OR (@StartDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @StartDate = GETDATE()-'1900-01-01 12:00:00'
END

if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()
END
--for days back mode
if (@daysBack is not null)
BEGIN
SET @StartDate = GETDATE() - @daysBack
END 
---------------------------------------------------------------------------------------
EXEC gadata.volvo.[sp_GADATAFrontShiftRap]
--timeparameters
    @StartDate = @StartDate
   ,@EndDate = @EndDate
--Filterparameters.
   ,@RobotFilterWild = @locations
  -- ,@LocationFilterWild 
   ,@UseOwnership = @UseOwnership
--tuning parmas
   ,@minDowntime = @minDowntime
   ,@minCountOfDowtime = @minCountOfDowtime
   ,@minCountofWarning = @minCountofWarning
   ,@USER = @USER
   ,@Sortmode = @Sortmode
END