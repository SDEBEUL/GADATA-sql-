


CREATE PROCEDURE [dbo].[sp_GADATAFRont_GcCurrentlog]
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
SET @StartDate = GETDATE()-30
END

if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()
END
---------------------------------------------------------------------------------------
select 
 rt.ID
,CONVERT(char(19),rt._timestamp, 120) AS '_timestamp'
,rt._equipment
,rt._current
,T.Vyear
,T.Vweek
,T.Vday
,T.shift
,T.PLOEG
FROM
GADATA.dbo.rt_Danfloss_currentlog as rt 
left join GADATA.volvo.L_timeline as T on rt._timestamp between T.starttime and T.endtime
WHERE 
rt._timestamp BETWEEN @StartDate AND @EndDate
AND 
rt._equipment LIKE @Equipment
ORDER BY rt._timestamp DESC 

 ---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Activity log (logs the execution of the Query to a table)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
DECLARE @rowcountmen as int 
SET @rowcountmen = @@rowcount
EXEC GADATA.volvo.sp_Alog  @rowcount = @rowcountmen, @Request = 'Running: [dbo].[sp_GADATAFRont_GcCurrentlog]'



END