



CREATE PROCEDURE [EqUi].[sp_NGAC_tipdressdata]

--default parameters
--timeparameters
	   @StartDate as DATETIME = null,
	   @EndDate as DATETIME = null,
	   @daysBack as int = null,
	--Filterparameters.
	   @locations as varchar(20) = '%',
	   @lochierarchy as varchar(20) = '%'


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
--selection some random stuff 
SELECT tipdresslogfile.controller_name
      ,[Date Time]
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
      ,[Dress_Time1]
      ,[Dress_Pressure1]
      ,[Dress_Time2]
      ,[Dress_Pressure2]
      ,[CleanDress_Time]
      ,[CleanDress_Pressure]
      ,[Time_DressCycleTime]
      ,[ErrorType]
      ,[ExtraInfo]
      ,[GunTCP_X]
      ,[GunTCP_Y]
      ,[GunTCP_Z]
	  ,a.LocationTree

FROM [GADATA].[NGAC].[TipDressLogFile]
LEFT JOIN GADATA.EqUi.ASSETS a on a.LOCATION = TipDressLogFile.controller_name

WHERE [Date Time] between @StartDate and @EndDate
AND a.LocationTree like @lochierarchy
AND a.LOCATION like @locations


END