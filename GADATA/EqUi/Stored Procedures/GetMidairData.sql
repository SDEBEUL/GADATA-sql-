
CREATE PROCEDURE [EqUi].[GetMidairData]
--timeparameters
	   @StartDate as DATETIME = '1900-01-01',
	   @EndDate as DATETIME = '2050-01-01',
	   @Robot as varchar(25) = null,
       @Tool as varchar(25) = null,
       @Weldgunname as varchar(25) = null --'321030WS01a'
AS
BEGIN

---------------------------------------------------------------------------------------
--Als er een weldgun name word gebruikt zoeken we de juiste robot en tool id op..
---------------------------------------------------------------------------------------

if (@Weldgunname is not null)
BEGIN
SET @Robot = (SELECT TOP 1 '%' + rws.Robot + '%' from GADATA.volvo.RobotWeldGunRelation as rws where rws.WeldgunName LIKE RTRIM(@Weldgunname)+'%')
SET @Tool = (SELECT TOP 1 '%Tool: ' + CAST(rws.ElectrodeNbr as varchar(2)) + '%' from GADATA.volvo.RobotWeldGunRelation as rws where rws.WeldgunName LIKE RTRIM(@Weldgunname)+'%')
END

SELECT 
       [timestamp]
	  ,[Robotname]
      ,[Tool]
      ,[SpotId]
      ,[ResisActual]
      ,[ResisRef]
  FROM [GADATA].[dbo].[MidairRef]

WHERE
[MidairRef].[timestamp] between   @startdate and @EndDate 
AND
[MidairRef].[Robotname] LIKE @Robot
AND
[MidairRef].[Tool] LIKE @Tool 

END