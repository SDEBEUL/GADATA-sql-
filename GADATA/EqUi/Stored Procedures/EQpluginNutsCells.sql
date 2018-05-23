



CREATE PROCEDURE [EqUi].[EQpluginNutsCells]

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
   @ErrorDispLog as bit = 1,
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

select 
  c.controller_name		   AS 'Location' 
, c.CLassificationId     AS 'AssetID' 
, 'ErrDispLog'	   AS 'Logtype'
, rt.[Date Time]        AS 'timestamp'
, rt.[AlarmNo]     AS 'Logcode'
, [NGAC].[fn_GetSeverity](rt.[Txt 1])   AS 'Severity'
, [Txt 2]  AS 'Logtext'
,       NGAC.[AddifSomething]([Txt 2]) + 
		NGAC.[AddifSomething]([Txt 3]) + 
		NGAC.[AddifSomething]([Txt 4]) + 
		NGAC.[AddifSomething]([Txt 5]) + 
		NGAC.[AddifSomething]([Txt 6]) + 
		NGAC.[AddifSomething]([Txt 7]) + 
		NGAC.[AddifSomething]([Txt 8]) + 
		NGAC.[AddifSomething]([Txt 9]) + 
		NGAC.[AddifSomething]([Txt 10]) + 
		NGAC.[AddifSomething]([Txt 11]) + 
		+'Response: ' + [Action]   AS 'FullLogtext'


,rt.[Txt 1]
,rt.[Txt 2]
,rt.[Txt 3]
,rt.[Txt 4]
,rt.[Txt 5]
,rt.[Txt 6]
,rt.[Txt 7]
,rt.[Txt 8]
,rt.[Txt 9]
,LEFT(replace([txt 10],'A440','449'), 10) AS TRimSpotID --has the data. about the gun 
,rt.[Txt 11]

, RTRIM(ISNULL(null,'Undefined*'))  AS 'Classification'
, ISNULL(null,'Undefined*')		 AS 'Subgroup'
, REPLACE(rt.[Txt 1],'-','') AS 'Category'
, rt.id				 AS 'refId'
, c.LocationTree     As 'LocationTree'
, c.ClassificationTree as 'ClassTree'
, c.controller_name		AS 'controller_name'
, 'NGAC'		As 'controller_type'







from GADATA.NGAC.rt_ErrDispLog as rt
left join GADATA.NGAC.rt_csv_file as rt_csv on rt.rt_csv_file_id = rt_csv.id

LEFT JOIN NGAC.c_controller as c with (NOLOCK) on c.id = rt_csv.c_controller_id

where c.CLassificationId like 'UAWN+UAWB%' --only the nutcells
AND rt.[Date Time] between @startdate and @enddate
AND @ErrorDispLog = 1

ORDER BY rt.[Date Time] desc 



END