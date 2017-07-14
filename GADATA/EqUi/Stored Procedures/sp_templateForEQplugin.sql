


CREATE PROCEDURE [EqUi].[sp_templateForEQplugin]

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
   @TestBool1 as bit = 0,
   @TestBool2 as bit = 0,
   @TestDate1 as datetime = null,
   @TestDate2 as datetime  = null,
   @TestVarchar1 as varchar(100) = null,
   @TestVarchar2 as varchar(100) = null

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


--selection some random stuff 
SELECT *

FROM GADATA.equi.ASSETS as assets 
where 
assets.ASSETNUM like @assets
and 
assets.LOCATION like @locations
and
assets.LocationTree like @lochierarchy


END