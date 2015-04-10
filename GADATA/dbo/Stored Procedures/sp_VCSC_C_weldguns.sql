CREATE PROCEDURE [dbo].[sp_VCSC_C_weldguns]

AS
BEGIN
---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------


--temp table from C_weldguns. 'calcutlates the robotname and tool id'
if (OBJECT_ID('tempdb..#weldgunstest') is not null) drop table #weldgunstest
SELECT 
 c_weldguns.Gunname
,c_weldguns.Variant
,c_weldguns.TheoX
,c_weldguns.TheoY
,c_weldguns.TheoZ
,SUBSTRING(ISNULL(REPLACE(LTRIM(c_weldguns.Gunname),'ws','R'), ''), 1, 8) as 'Robotnames'
,'toolid(calc)' = 
  CASE (LEN(LTRIM(c_weldguns.Gunname)) - 9) --if the string length is 0 aro did not give ma a complete gunname
	WHEN 0 THEN '1' --ughh to fix aro not giving a letter in there gunname 
	ELSE REPLACE(REPLACE(REPLACE(REPLACE(RIGHT(c_weldguns.Gunname, LEN(LTRIM(c_weldguns.Gunname)) - 9),'a','1'),'b','2'),'c','3'),'d','4')
  END
,C_weldguns.Comment
into #weldgunstest
FROM dbo.C_weldguns

--last tcp from each robot / tool 
if (OBJECT_ID('tempdb..#Temprobottooldata') is not null) drop table #Temprobottooldata
SELECT 
*
,ROW_NUMBER() OVER (PARTITION BY rt_toollog.controller_id, rt_toollog.tool_id ORDER BY rt_toollog.tool_timestamp DESC) AS rnDESC
INTO #Temprobottooldata
FROM GADATA.RobotGA.rt_toollog


SELECT  
#weldgunstest.Gunname AS 'AroGunname'
,#weldgunstest.Variant AS 'AroVariant'
,ISNULL(#weldgunstest.[toolid(calc)],#Temprobottooldata.tool_id) AS 'AroTool'
,ISNULL(robot.robotname,'not found') AS 'RobotName'
,#Temprobottooldata.tool_id AS 'RobotTool'
--tcp from aro
,#weldgunstest.TheoX AS 'AroX'
,#weldgunstest.TheoY AS 'AroY'
,#weldgunstest.TheoZ AS 'AroZ'
,isnull(convert(char(25),#Temprobottooldata.tool_timestamp,120),'no robotdata for tool') AS 'lastRobotdata'
--tcp from robot
,#Temprobottooldata.ToolX As 'RobotX'
,#Temprobottooldata.ToolY AS 'RobotY'
,#Temprobottooldata.ToolZ AS 'RobotZ'
--delta robot aro 
--,Deltax = (#weldgunstest.TheoX - #Temprobottooldata.ToolX)
--,Deltay = (#weldgunstest.Theoy - #Temprobottooldata.ToolY)
--,Deltaz = (#weldgunstest.Theoz - #Temprobottooldata.Toolz)
,TheoDelta =
SQRT(
POWER((ABS(#weldgunstest.TheoX) - ABS(#Temprobottooldata.ToolX)),2)+
POWER(ABS((#weldgunstest.Theoy) - ABS(#Temprobottooldata.ToolY)),2)+
POWER(ABS((#weldgunstest.Theoz) - ABS(#Temprobottooldata.Toolz)),2)
)
--
, Arodatacheck = 
 CASE ISNULL(CAST((#weldgunstest.TheoX + #weldgunstest.TheoY + #weldgunstest.TheoZ) AS varchar(20)),'incomplete')
 WHEN 'incomplete' THEN 'incomplete'
 ELSE 'OK'
 END

, AroToolidcheck = 
  CASE (CONVERT(int,#Temprobottooldata.tool_id) - CONVERT(int,ISNULL(#weldgunstest.[toolid(calc)],#Temprobottooldata.tool_id)))
  WHEN 0 THEN 'OK'
  ELSE 'NOK'
  END

,#weldgunstest.Comment AS 'AroComment'

FROM #weldgunstest
LEFT JOIN GADATA.robotga.robot on robot.RobotName LIKE ('%' + #weldgunstest.Robotnames + '%')
LEFT JOIN #Temprobottooldata on (robot.id = #Temprobottooldata.controller_id)  AND (#Temprobottooldata.rnDESC  = 1) -- AND (#Temprobottooldata.Tool = #weldgunstest.[toolid(calc)])
ORDER BY Gunname  


 ---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Activity log (logs the execution of the Query to a table)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
DECLARE @rowcountmen as int 
SET @rowcountmen = @@rowcount
DECLARE @RequestString as varchar(255)
SET @RequestString =
   CONCAT('C WELDGUNS (datapull) ','')
EXEC GADATA.dbo.sp_Activitylog @rowcount = @rowcountmen, @Request = @RequestString



 END