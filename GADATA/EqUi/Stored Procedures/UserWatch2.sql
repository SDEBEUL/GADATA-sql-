

CREATE PROCEDURE [EqUi].[UserWatch2]
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
 UserPerformanceTrack.*
,datepart(WEEK,UserPerformanceTrack.testtime) as 'week'
,datepart(day,UserPerformanceTrack.testtime) as 'day'
,datepart(hour,UserPerformanceTrack.testtime) as 'hour'
 from  gadata.equi.UserPerformanceTrack
where testtime between @StartDate and @EndDate


END