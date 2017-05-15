CREATE PROCEDURE [EQUI].[sp_GADATAFrontSBCU]
--default parameters
--timeparameters
	   @StartDate as DATETIME = null,
	   @EndDate as DATETIME = null,
	   @daysBack as int = null,
	--Filterparameters.
	   @locations as varchar(20) = '%' 

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
SET @EndDate = GETDATE()
END 
---------------------------------------------------------------------------------------
--c3g
SELECT * FROM GADATA.c3g.sbcuData as s
where s.tool_timestamp between   @startdate and @EndDate
AND s.RobotName LIKE @locations
END