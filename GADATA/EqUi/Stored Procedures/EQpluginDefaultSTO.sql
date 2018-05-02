

CREATE PROCEDURE [EqUi].[EQpluginDefaultSTO]

--default parameters
--timeparameters
	   @StartDate as DATETIME = null,
	   @EndDate as DATETIME = null,
	   @daysBack as int = null,
	--Filterparameters.
	   @assets as varchar(10) = '%',
	   @locations as varchar(20) = '%',
	   @lochierarchy as varchar(20) = '%',
	--optional
	   @timeline as bit = 1,
	   @StoBreakDown as bit = 0,
	   @StoError as bit = 1

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
--template ! 
SELECT
--asset
  output.Location       AS 'Location' 
, output.AssetID		as 'AssetID'
--log part
, output.Logtype		AS 'Logtype'
, output.Logcode		AS 'Logcode'
, output.Severity		AS 'Severity'
, output.logtext		AS 'logtext'
, output.Downtime/60		AS 'Downtime(min)'
--date time part
, CONVERT(char(19),output.[timestamp], 120) AS 'timestamp' --cast to timeformat excel likes 
, CONVERT(char(19),output.[timestamp], 108) AS 'time' 
, timeline.Vyear		     AS 'Year'
, timeline.Vweek		     AS 'Week'
, timeline.Vday		     AS 'Day'
, timeline.[shift]           AS 'Shift'
, timeline.PLOEG		     As 'Ploeg'
--classifcation part
, output.Classification  AS 'Classification'
, output.Subgroup  AS 'Subgroup'
, output.Category  AS 'Category'
, output.refId	AS 'refId'
, output.LocationTree   As 'LocationTree'
, output.ClassTree		As 'ClassTree'
, output.controller_name AS 'controller_name'
, output.controller_type  As 'controller_type'
FROM
(
--*******************************************************************************************************--
--timeline
--*******************************************************************************************************--
SELECT 
 'TIMELINE' AS 'Location' 
,'TIMELINE'	AS 'AssetID'
,'TIMELINE' AS 'Logtype'
, T.starttime + '1900-01-01 00:00:01' AS 'timestamp' --add 1s because else dubble match on join with weeknumbers
, Null      AS 'Logcode'
, Null      AS 'Severity'
, 'Begin of Shift: ' + T.[shift] + '  Ploeg:'+ T.PLOEG       AS 'logtext'
, 'Begin of Shift: ' + T.[shift] + '  Ploeg:'+ T.PLOEG       AS 'FullLogtext'
, NULL      AS 'Response'
, NULL      AS 'Downtime'
, 'TIMELINE'		AS 'Classification'
, 'TIMELINE'		AS 'Subgroup'
, ''		AS 'Category'
, T.id		AS 'refId'
, ''		As 'LocationTree'
, ''		AS 'ClassTree'
, ''		AS 'controller_name'
, ''		As 'controller_type'

FROM  Volvo.L_timeline as T 
where 
T.starttime BETWEEN @StartDate AND @EndDate
AND
@timeline = 1

--*******************************************************************************************************--
UNION
-----------------------------------------------------------------------------------
--Sto Error Data 
---------------------------------------------------------------------------------------
SELECT * FROM GADATA.STO.Error as e
WHERE
--Asset Filters
    isnull(e.AssetID,'%') like @assets
and isnull(e.LOCATION,e.controller_name) like @locations
--and A.controller_name like @locations
and isnull(e.LocationTree,'%') like @lochierarchy
--Time Filter
and CAST(e.[TIMESTAMP] as datetime) BETWEEN @StartDate AND @EndDate
--enable
and @StoError = 1

) as output
left join gadata.volvo.l_timeline as timeline on output.timestamp between timeline.starttime and timeline.endtime
order by output.timestamp desc 

END