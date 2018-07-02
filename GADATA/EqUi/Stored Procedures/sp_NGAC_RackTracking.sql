



CREATE PROCEDURE [EqUi].[sp_NGAC_RackTracking]

--default parameters
--timeparameters
	   @StartDate as DATETIME = null,
	   @EndDate as DATETIME = null,
	   @daysBack as int = null,
	--Filterparameters.
	  -- @assets as varchar(10) = '%',
	   @locations as varchar(20) = '%',
	   @lochierarchy as varchar(20) = '%'

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
SELECT 
rt.*
,t.vyear
,t.vweek
,t.vday
,t.ploeg
FROM GADATA.NGAC.RackTracking as rt 
left join gadata.Volvo.L_timeline as t on rt.timestamp between t.starttime and t.endtime
where  
rt.LOCATION like @locations
and
rt.LocationTree like @lochierarchy
and rt.timestamp between @StartDate and @EndDate
order by rt.timestamp desc 
END