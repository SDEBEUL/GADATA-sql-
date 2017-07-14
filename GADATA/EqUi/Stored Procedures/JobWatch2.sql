



CREATE PROCEDURE [EqUi].[JobWatch2]
--timeparameters
	   @StartDate as DATETIME = null,
	   @EndDate as DATETIME = null,
	   @daysBack as int = null
AS
BEGIN

--Set default values of start and end date
---------------------------------------------------------------------------------------
if ((@StartDate is null) OR (@StartDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @StartDate = GETDATE()-'1900-01-01 4:00:00'
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

select 
 JobPerformanceTrack.*
,datepart(WEEK,JobPerformanceTrack.testtime) as 'week'
,datepart(day,JobPerformanceTrack.testtime) as 'day'
,datepart(hour,JobPerformanceTrack.testtime) as 'hour'
 from  gadata.equi.JobPerformanceTrack
where testtime between @StartDate and @EndDate

END