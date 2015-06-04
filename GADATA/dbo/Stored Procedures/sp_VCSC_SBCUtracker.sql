CREATE PROCEDURE [dbo].[sp_VCSC_SBCUtracker]
   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @RobotFilterWild as varchar(10) = '%'
AS
BEGIN
---------------------------------------------------------------------------------------
--set first day of the week to monday (german std) -- test 
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------


if (OBJECT_ID('tempdb..#toollogtemp') is not null) drop table #toollogtemp

SELECT 
	   tool_timestamp
      ,controller_id
      ,tool_id
      ,[Dmeas]
      ,[Dsetup]
      ,[ToolX]
      ,[ToolY]
      ,[ToolZ]
      ,[ToolA]
      ,[ToolE]
      ,[ToolR]
	  ,[Longcheck]
	  ,[TcpUpdate]
	  ,ROW_NUMBER() OVER (PARTITION BY [rt_toollog].controller_id, [rt_toollog].tool_id ORDER BY tool_timestamp DESC) AS rnDESC
	  ,ROW_NUMBER() OVER (PARTITION BY [rt_toollog].controller_id, [rt_toollog].tool_id ORDER BY tool_timestamp ASC) AS rnASC
  INTO #toollogtemp
  FROM [GADATA].[RobotGA].[rt_toollog]
  WHERE tool_timestamp BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())
  
  
 SELECT  
  robot.robotname
 ,#toollogtemp.tool_timestamp
 ,DATEDIFF(hour,Ltoollogtemp.tool_timestamp,#toollogtemp.tool_timestamp) AS 'TBM'
 ,DATEPART(YEAR, #toollogtemp.tool_timestamp) AS 'Year'
 ,DATEPART(WEEK,#toollogtemp.tool_timestamp) AS 'Week'
 ,GADATA.dbo.fn_volvoday(#toollogtemp.tool_timestamp,CAST(#toollogtemp.tool_timestamp AS time)) AS 'Day'
 ,#toollogtemp.tool_id
      ,ROUND(#toollogtemp.[Dmeas],2)  AS 'Dmeas'
      ,ROUND(#toollogtemp.[Dsetup],2) As 'Dsetup'
      ,ROUND(#toollogtemp.[ToolX],2)  AS '$toolX'
      ,ROUND(#toollogtemp.[ToolY],2)  AS '$ToolY'
      ,ROUND(#toollogtemp.[ToolZ],2)  AS '$ToolZ'
      ,ROUND(#toollogtemp.[ToolA],2)  As '$ToolA'
      ,ROUND(#toollogtemp.[ToolE],2)  AS '$ToolE'
      ,ROUND(#toollogtemp.[ToolR],2)  AS '$ToolR'
	  ,'$toolMeasX' = ROUND((#toollogtemp.[ToolX] - Ltoollogtemp.[ToolX]),2)
      ,'$toolMeasY' = ROUND((#toollogtemp.[ToolY] - Ltoollogtemp.[ToolY]),2)
      ,'$toolMeasZ' = ROUND((#toollogtemp.[ToolZ] - Ltoollogtemp.[ToolZ]),2)
	  ,#toollogtemp.Longcheck as 'LC'
	  ,#toollogtemp.TcpUpdate as 'U'
	  --,#toollogtemp.rnDESC
	  

--calculaties zijn overgenomen uit module H_wearX van J Roets.
--delta tov vorige meting 
--Z wear waarde berekeken
 ,TMeasZ = ROUND(ABS( ((Ltoollogtemp.[ToolX] - #toollogtemp.[ToolX]) * (COS(#toollogtemp.[ToolA]) * SIN(#toollogtemp.[ToolE])) + (Ltoollogtemp.[ToolY] - #toollogtemp.[ToolY])
														   * (SIN(#toollogtemp.[ToolA]) * SIN(#toollogtemp.[ToolE])) + (Ltoollogtemp.[ToolZ] - #toollogtemp.[ToolZ])
														   * COS(#toollogtemp.[ToolE]))),2)
--x afwijking berekenen
 ,TMeasX =  ROUND(ABS( (Ltoollogtemp.[ToolX] - #toollogtemp.[ToolX])  * (COS(#toollogtemp.[ToolA]) * COS(#toollogtemp.[ToolE]) * COS(#toollogtemp.[ToolR]) - SIN(#toollogtemp.[ToolA]) * SIN(#toollogtemp.[ToolR])))
		+ ( (Ltoollogtemp.[ToolY] - #toollogtemp.[ToolY])  * (SIN(#toollogtemp.[ToolA]) * COS(#toollogtemp.[ToolE]) * COS(#toollogtemp.[ToolR]) + COS(#toollogtemp.[ToolA]) * SIN(#toollogtemp.[ToolR])))
		+ ( (Ltoollogtemp.[ToolZ] - #toollogtemp.[ToolZ])  * (-SIN(#toollogtemp.[ToolE]) * COS(#toollogtemp.[ToolR]))),2)
--Y afwijking berekenen
 ,TMeasY =  ROUND(ABS( (Ltoollogtemp.[ToolX] - #toollogtemp.[ToolX])  * (-COS(#toollogtemp.[ToolA]) * COS(#toollogtemp.[ToolE]) * SIN(#toollogtemp.[ToolR]) - SIN(#toollogtemp.[ToolA]) * COS(#toollogtemp.[ToolR])))
		+ ( (Ltoollogtemp.[ToolY] - #toollogtemp.[ToolY])  * (-SIN(#toollogtemp.[ToolA]) * COS(#toollogtemp.[ToolE]) * SIN(#toollogtemp.[ToolR]) + COS(#toollogtemp.[ToolA]) * COS(#toollogtemp.[ToolR])))
		+ ( (Ltoollogtemp.[ToolZ] - #toollogtemp.[ToolZ])  * (SIN(#toollogtemp.[ToolE]) * SIN(#toollogtemp.[ToolR]))),2)


--delta tov init value 
--Z wear waarde berekeken
 ,TSetupZDev = ROUND(( ((Ftoollogtemp.[ToolX] - #toollogtemp.[ToolX]) * (COS(#toollogtemp.[ToolA]) * SIN(#toollogtemp.[ToolE])) + (Ftoollogtemp.[ToolY] - #toollogtemp.[ToolY])
	    													   * (SIN(#toollogtemp.[ToolA]) * SIN(#toollogtemp.[ToolE])) + (Ftoollogtemp.[ToolZ] - #toollogtemp.[ToolZ])
		    												   * COS(#toollogtemp.[ToolE]))),2)
--x afwijking berekenen
,TSetupXDev =  ROUND(ABS( (Ftoollogtemp.[ToolX] - #toollogtemp.[ToolX])  * (COS(#toollogtemp.[ToolA]) * COS(#toollogtemp.[ToolE]) * COS(#toollogtemp.[ToolR]) - SIN(#toollogtemp.[ToolA]) * SIN(#toollogtemp.[ToolR])))
    		+ ( (Ftoollogtemp.[ToolY] - #toollogtemp.[ToolY])  * (SIN(#toollogtemp.[ToolA]) * COS(#toollogtemp.[ToolE]) * COS(#toollogtemp.[ToolR]) + COS(#toollogtemp.[ToolA]) * SIN(#toollogtemp.[ToolR])))
    		+ ( (Ftoollogtemp.[ToolZ] - #toollogtemp.[ToolZ])  * (-SIN(#toollogtemp.[ToolE]) * COS(#toollogtemp.[ToolR]))),2)
--Y afwijking berekenen
,TSetupYDev =  ROUND(ABS( (Ftoollogtemp.[ToolX] - #toollogtemp.[ToolX])  * (-COS(#toollogtemp.[ToolA]) * COS(#toollogtemp.[ToolE]) * SIN(#toollogtemp.[ToolR]) - SIN(#toollogtemp.[ToolA]) * COS(#toollogtemp.[ToolR])))
		   	+ ( (Ftoollogtemp.[ToolY] - #toollogtemp.[ToolY])  * (-SIN(#toollogtemp.[ToolA]) * COS(#toollogtemp.[ToolE]) * SIN(#toollogtemp.[ToolR]) + COS(#toollogtemp.[ToolA]) * COS(#toollogtemp.[ToolR])))
    		+ ( (Ftoollogtemp.[ToolZ] - #toollogtemp.[ToolZ])  * (SIN(#toollogtemp.[ToolE]) * SIN(#toollogtemp.[ToolR]))),2)
 
 FROM #toollogtemp
 
 --join upon next log line
 LEFT Join #toollogtemp AS Ltoollogtemp ON
 (
 (#toollogtemp.tool_id = Ltoollogtemp.tool_id)
 AND
 (#toollogtemp.controller_id = Ltoollogtemp.controller_id)
 AND
 (#toollogtemp.rndesc = (Ltoollogtemp.rndesc - 1))
 )
 
 --join first logline (must become the theo value)
 LEFT Join #toollogtemp AS Ftoollogtemp ON
 (
 (#toollogtemp.tool_id = Ftoollogtemp.tool_id)
 AND
 (#toollogtemp.controller_id = Ftoollogtemp.controller_id)
 AND
 (Ftoollogtemp.rnASC =  1) -- moet max rn zijn 
 )


join RobotGA.Robot on robot.id = #toollogtemp.controller_id
where (robot.RobotName LIKE @RobotFilterWild)
 ORDER BY tool_timestamp desc 

 ---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Activity log (logs the execution of the Query to a table)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
DECLARE @rowcountmen as int 
SET @rowcountmen = @@rowcount
DECLARE @RequestString as varchar(255)
SET @RequestString =
   CONCAT('SBCU TRACKER ',
          ' @StartDate = " '				, @StartDate
     ,' "  ,@EndDate = " '					, @EndDate
     ,' "  ,@RobotFilterWild = " '			, @RobotFilterWild ,' "'
	)
EXEC GADATA.dbo.sp_Activitylog @rowcount = @rowcountmen, @Request = @RequestString


 END