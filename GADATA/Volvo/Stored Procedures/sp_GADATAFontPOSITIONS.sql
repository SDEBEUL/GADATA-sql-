

CREATE PROCEDURE [Volvo].[sp_GADATAFontPOSITIONS]
--timeparameters
   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
--Filterparameters.
   @RobotFilterWild as varchar(10) = '%',
   @LocationFilterWild as varchar(20) = '%',
--COMAU C4G booleans
   @GetC4GSBCU as bit = 0, --TBT
--Comau C3G Booleans   
   @GetC3GSBCU as bit = 0 
AS
BEGIN

---------------------------------------------------------------------------------------
--Set default values of start and end date
---------------------------------------------------------------------------------------
if ((@StartDate is null) OR (@StartDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @StartDate = GETDATE()-1
END

if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()
END
---------------------------------------------------------------------------------------


SELECT * FROM
(
--c3g pos
SELECT 
       r.RobotName
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
	  ,ROW_NUMBER() OVER (PARTITION BY r.robotname, l.pos ORDER BY l._timestamp DESC) AS rnDESC
	  ,ROW_NUMBER() OVER (PARTITION BY r.robotname, l.pos ORDER BY l._timestamp ASC) AS ModCount
  FROM [GADATA].[RobotGA].[L_robotpositions] as l 
  left join GADATA.RobotGA.Robot as r on r.id = l.controller_id

  WHERE 
  r.location LIKE @LocationFilterWild
  AND 
  r.RobotName LIKE @RobotFilterWild
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
  c.location LIKE @LocationFilterWild
  AND 
  c.controller_name LIKE @RobotFilterWild
  ) as x 
  where x.rnDESC = 1 OR x.[Save Time] BETWEEN @StartDate AND @EndDate
END