
CREATE PROCEDURE [c3g].[sp_GADATAFRont_cycletime]
--timeparameters
   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
--Filterparameters.
   @controller as varchar(25) = '%'
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
 c.location
,c.controller_name
,rt._timestamp
,rt.plcOrder
,rt.segment
,rt._timeMS

,T.Vyear
,T.Vweek
,T.Vday
,T.shift
,T.PLOEG
from GADATA.C3G.rt_CycleTime as rt 
left join GADATA.C3G.c_controller as c on c.id = rt.controller_id
left join GADATA.volvo.L_timeline as T on rt._timestamp between T.starttime and T.endtime
WHERE 
rt._timems is not null  
AND 
rt.plcorder not in (0,1) 
AND
rt._timestamp BETWEEN @StartDate AND @EndDate
AND 
c.controller_name LIKE @controller
AND 
rt._timeMS < 1000*60*5
ORDER BY rt._timestamp DESC 

 ---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Activity log (logs the execution of the Query to a table)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
DECLARE @rowcountmen as int 
SET @rowcountmen = @@rowcount
EXEC GADATA.volvo.sp_Alog  @rowcount = @rowcountmen, @Request = 'Running: [c3g].[sp_GADATAFRont_cycletime]'



END