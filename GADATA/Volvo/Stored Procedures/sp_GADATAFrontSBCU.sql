
CREATE PROCEDURE [Volvo].[sp_GADATAFrontSBCU]
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
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--enable c3g and c4g if no data request. (to support front end < 1.16
---------------------------------------------------------------------------------------
if ((@GetC3GSBCU = 0) AND (@GetC4GSBCU = 0))
BEGIN
SET @GetC3GSBCU = 1
SET @GetC4GSBCU = 1
END
---------------------------------------------------------------------------------------

--c3g
SELECT * FROM GADATA.c3g.sbcuData as s
where s.tool_timestamp between   @startdate and @EndDate
AND s.RobotName LIKE @RobotFilterWild
AND @GetC3GSBCU = 1 
--c4g
UNION
SELECT * FROM GADATA.c4g.sbcuData as s
where s.tool_timestamp between   @startdate and @EndDate
AND s.RobotName LIKE @RobotFilterWild
AND @GetC4GSBCU = 1 

 ---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Activity log (logs the execution of the Query to a table)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
DECLARE @rowcountmen as int 
SET @rowcountmen = @@rowcount
EXEC GADATA.volvo.sp_Alog  @rowcount = @rowcountmen, @Request = 'Running: [Volvo].[sp_GADATAFrontSBCU]'
END