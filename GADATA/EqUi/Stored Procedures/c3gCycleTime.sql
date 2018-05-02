



CREATE PROCEDURE [EqUi].[c3gCycleTime]

--default parameters
--timeparameters
	   @StartDate as DATETIME = null,
	   @EndDate as DATETIME = null,
	   @daysBack as int = null,
	--Filterparameters.
	   @locations as varchar(20) = '87%'


--gives the right permission when a low level user only has execution rights
--with execute as owner
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

--********************************TRIGGER NORMALISATION***********************************--
EXEC GADATA.[C3G].[sp_normalize_CycleTime]
--****************************************************************************************--


SELECT c.controller_name
      ,rt.id
      ,rt.[_timestamp]
      ,rt.[value]
      ,rt.[datatype]
      ,rt.[_timeMS]
      ,rt.[plcOrder]
      ,rt.[segment]
	  ,datepart(hour,rt._timestamp) as 'hour'
	  	  ,datepart(WEEKDAY,rt._timestamp) as 'day'
		  	  ,datepart(week,rt._timestamp) as 'week'
	  ,a.Station
	  ,70000 as 'LCT'
	  ,case 
	  WHEN rt.plcOrder = 2 THEN 'a441'
	  	  WHEN rt.plcOrder = 3 THEN 'a441AutoDress'
		  	  WHEN rt.plcOrder = 20 THEN '555'
			  	  WHEN rt.plcOrder = 21 THEN '555AutoDress'
	  ELSE 'noDef'
	  END  as 'job'
	  , PERCENTILE_DISC(0.05) WITHIN GROUP (ORDER BY [_timeMS]) OVER (PARTITION BY rt.controller_id, rt.[plcOrder],rt.segment, datepart(week,rt._timestamp)) as't05'
	  , PERCENTILE_DISC(0.50) WITHIN GROUP (ORDER BY [_timeMS]) OVER (PARTITION BY rt.controller_id, rt.[plcOrder],rt.segment, datepart(week,rt._timestamp)) as't50'
	  , PERCENTILE_DISC(0.90) WITHIN GROUP (ORDER BY [_timeMS]) OVER (PARTITION BY rt.controller_id, rt.[plcOrder],rt.segment, datepart(week,rt._timestamp)) as't90'
	  , PERCENTILE_DISC(0.95) WITHIN GROUP (ORDER BY [_timeMS]) OVER (PARTITION BY rt.controller_id, rt.[plcOrder],rt.segment, datepart(week,rt._timestamp)) as't95'
  FROM [GADATA].[C3G].[rt_CycleTime] as rt 
  left join GADATA.C3G.c_controller as c on c.id = rt.controller_id
  left join GADATA.equi.ASSETS as a on a.controller_name = c.controller_name and a.ASSETNUM like 'URC%'
  where c.controller_name like @locations
  AND rt._timestamp between @StartDate and @EndDate
  AND rt._timeMS < 700000*2
  and plcOrder <> 1
  order by id desc 

end