
CREATE PROCEDURE [EqUi].[GetTipDressData]
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

SELECT [Date Time] as 'timestamp'
      ,[controller_name]
      ,[id]
      ,[rt_csv_file_id]
      ,[Tool_Nr]
      ,[Dress_Num]
      ,[Weld_Counter]
      ,[Dress_Reason]
      ,[Weld_Result]
      ,[Length_Fixed_Result]
      ,[Length_Move_Result]
      ,[Max_Wear_Fixed]
      ,[Wear_Fixed]
      ,[DiffFrLastWear_Fixed]
      ,[Max_Wear_Move]
      ,[Wear_Move]
      ,[DiffFrLastWear_Move]
      ,[MaxDiffFrLastMeas]
      ,[Current_TipWear]
      ,[TipWearRatio]
      ,[Time_DressCycleTime]
      ,[ErrorType]
      ,[ExtraInfo]
  FROM [GADATA].[NGAC].[TipDressLogFile]
  where controller_name like @Robot and Tool_Nr = 1 
  and [Date Time] between @startdate and @enddate
 
END