


CREATE PROCEDURE [dbo.[sp_GADATAFRont_GcCurrentlog]
--timeparameters
   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
--Filterparameters.
   @Equipment as varchar(25) = '%'
AS
BEGIN

---------------------------------------------------------------------------------------
--Set default values of start and end date
---------------------------------------------------------------------------------------
if ((@StartDate is null) OR (@StartDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @StartDate = GETDATE()-40
END

if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()
END
---------------------------------------------------------------------------------------


select 
*
FROM
GADATA.dbo.rt_Danfloss_currentlog as rt 
WHERE 
rt._timestamp BETWEEN @StartDate AND @EndDate
AND 
rt._equipment LIKE @Equipment
END