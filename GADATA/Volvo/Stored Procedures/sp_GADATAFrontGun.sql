


CREATE PROCEDURE [Volvo].[sp_GADATAFrontGun]
--timeparameters
   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
--Filterparameters.
   @RobotFilterWild as varchar(10) = '%',
   @LocationFilterWild as varchar(20) = '%',
--COMAU C4G booleans
   @GetC4GSBCU as bit = 0, --TBT
--Comau C3G Booleans   
   @GetC3GSBCU as bit = 0 
--gives the right permission when a low level user only has execution rights
with execute as owner
AS
BEGIN

---------------------------------------------------------------------------------------
--Set default values of start and end date
---------------------------------------------------------------------------------------
if ((@StartDate is null) OR (@StartDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @StartDate = GETDATE()-1
END

if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()
END


SELECT * FROM GADATA.C3G.weldgunCylinder as h
where 
h._timestamp between   @startdate and @EndDate 
AND
h.controller_name LIKE @RobotFilterWild

 ---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Activity log (logs the execution of the Query to a table)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
DECLARE @rowcountmen as int 
SET @rowcountmen = @@rowcount
EXEC GADATA.volvo.sp_Alog  @rowcount = @rowcountmen, @Request = 'Running: [Volvo].[sp_GADATAFrontGun]'

END
GO
GRANT EXECUTE
    ON OBJECT::[Volvo].[sp_GADATAFrontGun] TO [db_frontendUser]
    AS [GADATA];



