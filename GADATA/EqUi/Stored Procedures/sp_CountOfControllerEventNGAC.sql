





CREATE PROCEDURE [EqUi].[sp_CountOfControllerEventNGAC]

--default parameters
--timeparameters
	  @StartDate as DATETIME = null,
	  @EndDate as DATETIME = null,
	  @daysBack as int = null,
	--Filterparameters.
	  -- @assets as varchar(10) = '%',
	  -- @locations as varchar(20) = '%',
	  -- @lochierarchy as varchar(20) = '%', 
	
     /*
	--non default parms
   @TestBool1 as bit = 0,
   @TestBool2 as bit = 0,
   @TestDate1 as datetime = null,
   @TestDate2 as datetime  = null,
   @TestVarchar1 as varchar(100) = null,
   @TestVarchar2 as varchar(100) = null
   */
   @errornum as int = 28702, --filter op logcode control unit bat
   @Logtekst as varchar(1000) = '%The content of the alarm is defined by the Diagnosis ASE for this type.%',
   @LocationTree as varchar(200) = '%'

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
select 
 e.Location
,e.logcode
,e.FullLogtext
,count(e.Location) as 'count' --tel hoeveel keer de fout voorkomt.
,max(e.timestamp) as 'last time' --laatste keer dat de fout is voorgekomen
,e.LocationTree
from gadata.NGAC.ControllerEventLog as e 
left join GADATA.volvo.L_timeline as t on e.timestamp between t.starttime and t.endtime
where e.timestamp between @StartDate and @EndDate  
and 
e.LocationTree like @LocationTree
and
(
e.Logcode = @errornum 
OR
e.FullLogtext like @logtekst
)
group by e.location, e.logcode, e.FullLogtext, e.LocationTree
order by e.location 



END