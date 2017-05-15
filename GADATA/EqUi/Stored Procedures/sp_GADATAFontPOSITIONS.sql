
CREATE PROCEDURE [EqUi].[sp_GADATAFontPOSITIONS]
--default parameters
--timeparameters
	   @StartDate as DATETIME = null,
	   @EndDate as DATETIME = null,
	   @daysBack as int = null,
	--Filterparameters.
	   @locations as varchar(20) = '%' 
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


SELECT * FROM
(
--c3g pos
SELECT 
       r.controller_name as 'RobotName'
	  ,r.location
	  ,[_timestamp] as 'Detection Time'
      ,[file_timestamp] as 'Save Time'
      ,[Owner] as 'Programma'
      ,[Pos] as 'Positie'
      ,ROUND([X],2) as 'X'
      ,ROUND([Y],2) as 'Y'
      ,ROUND([Z],2) as 'Z'
      ,ROUND([a],2) as 'a'
      ,ROUND([e],2) as 'e'
      ,ROUND([r],2) as 'r'
      ,ROUND([ax7],2) as 'ax7'
      ,ROUND([ax8],2) as 'ax8'
      ,[Cnfg]
	  ,ROW_NUMBER() OVER (PARTITION BY r.controller_name, l.pos ORDER BY l._timestamp DESC) AS rnDESC
	  ,ROW_NUMBER() OVER (PARTITION BY r.controller_name, l.pos ORDER BY l._timestamp ASC) AS ModCount
  FROM [GADATA].c3g.[L_robotpositions] as l 
  left join GADATA.c3g.c_controller as r on r.id = l.controller_id

  WHERE 
  r.controller_name LIKE @locations
  ) as x 
  where x.rnDESC = 1 OR x.[Save Time] BETWEEN @StartDate AND @EndDate
--c4g pos 
UNION
SELECT * FROM
(
SELECT 
       c.controller_name as  'RobotName'
	  ,c.location as 'location'
	  ,[_timestamp] as 'Detection Time'
      ,[file_timestamp] as 'Save Time'
      ,[Owner] as 'Programma'
      ,[Pos] as 'Positie'
      ,ROUND([X],2) as 'X'
      ,ROUND([Y],2) as 'Y'
      ,ROUND([Z],2) as 'Z'
      ,ROUND([a],2) as 'a'
      ,ROUND([e],2) as 'e'
      ,ROUND([r],2) as 'r'
      ,ROUND([ax7],2) as 'ax7'
      ,ROUND([ax8],2) as 'ax8'
      ,[Cnfg]
	  ,ROW_NUMBER() OVER (PARTITION BY c.controller_name, l.pos ORDER BY l._timestamp DESC) AS rnDESC
	  ,ROW_NUMBER() OVER (PARTITION BY c.controller_name, l.pos ORDER BY l._timestamp ASC) AS ModCount
  FROM [GADATA].[C4g].[L_robotpositions] as l 
  left join GADATA.c4g.c_controller  as c on c.id = l.controller_id
  
  WHERE 
  c.controller_name LIKE @locations
  ) as x 
  where x.rnDESC = 1 OR x.[Save Time] BETWEEN @StartDate AND @EndDate
END