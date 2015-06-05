CREATE PROCEDURE [C4G].[sp_get_C4G]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @Daysback as int = 1,
   @RobotFilterWild as varchar(10) = '%',
   @RobotFilterMaskStart as varchar(10) = '%',
   @RobotFilterMaskEnd as varchar(10) = '99999R99%',
   @LocationFilterWild as varchar(20) = '%',
   @OrderbyRobot as bit = null
AS
BEGIN
---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------
SET @StartDate = GETDATE() - @Daysback
SET @Enddate = GETDATE()


SELECT * FROM GADATA.C4G.ERROR AS E
WHERE 
E.Robotname LIKE @RobotFilterWild
AND 
E.[timestamp] BETWEEN @StartDate AND @Enddate
UNION
SELECT * FROM GADATA.C4G.[ACTION] AS A
WHERE 
A.Robotname LIKE @RobotFilterWild
AND 
A.[timestamp] BETWEEN @StartDate AND @Enddate

order by [timestamp] desc 


END