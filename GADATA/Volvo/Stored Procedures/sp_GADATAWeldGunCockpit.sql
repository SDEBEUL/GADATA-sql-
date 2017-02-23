



CREATE PROCEDURE [Volvo].[sp_GADATAWeldGunCockpit]
--timeparameters
   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
--Filterparameters.
   @Robot as varchar(25) = '57050r03%',
   @Tool as varchar(25) = 'Tool: 1',
   @Weldgunname as varchar(25) = null
--gives the right permission when a low level user only has execution rights
with execute as owner
AS
BEGIN

---------------------------------------------------------------------------------------
--Set default values of start and end date
---------------------------------------------------------------------------------------
if ((@StartDate is null) OR (@StartDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @StartDate = GETDATE()-40
END

if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()
END
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--Als er een weldgun name word gebruikt zoeken we de juiste robot en tool id op..
---------------------------------------------------------------------------------------

if (@Weldgunname is not null)
BEGIN
SET @Robot = (SELECT TOP 1 '%' + rws.Robot + '%' from GADATA.volvo.RobotWeldGunRelation as rws where rws.WeldgunName LIKE @Weldgunname)
SET @Tool = (SELECT TOP 1 '%Tool: ' + CAST(rws.ElectrodeNbr as varchar(2)) + '%' from GADATA.volvo.RobotWeldGunRelation as rws where rws.WeldgunName LIKE @Weldgunname)
END
---------------------------------------------------------------------------------------
--get the timer id 
DECLARE @timerid as int 
DECLARE @ElectrodeNbr as int
SET @timerid = (SELECT TOP 1 rwg.Timerid from GADATA.volvo.RobotWeldGunRelation as rwg where rwg.Robot like @Robot)
SET @ElectrodeNbr = (SELECT TOP 1 rws.ElectrodeNbr  from GADATA.volvo.RobotWeldGunRelation as rws where rws.WeldgunName LIKE @Weldgunname)
--

---------------------------------------------------------------------------------------
--dit is echt iets kaka... ik wil dus voor al de verschillende 'data' bronnen
--is het nu sbcu / cilinder / midair een grafiek kunnen maken waar tijd altijd in lijn is voor de verschillende grafieken.
--dat wil zeggen dat ik eerst al de timestamp van al de databronnen moet selecteren en deze moet combineren ... UUGH 
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#Timeref') is not null) drop table #Timeref
SELECT * INTO #Timeref FROM
(
select 
 sbcu.RobotName
,sbcu.tool_id
,sbcu.tool_timestamp as 'Timestamp'
from GADATA.c3g.SBCUData as sbcu 
where 
sbcu.tool_timestamp between   @startdate and @EndDate 
AND 
sbcu.Longcheck is not null
AND
sbcu.Robotname LIKE @Robot

UNION
select 
 cil.controller_name
,'Tool: ' + cast(cil.Tool_id as varchar(2)) 
,cil._timestamp
from GADATA.C3G.WeldGunCylinder as cil 
where 
cil._timestamp between   @startdate and @EndDate 
AND
cil.controller_name LIKE @Robot

UNION
select 
 midair.Robotname
,midair.Tool
,midair.timestamp
from GADATA.dbo.MidairRef as midair 
where 
midair.timestamp between   @startdate and @EndDate 
AND
midair.Robotname LIKE @Robot
AND
midair.Tool LIKE @Tool

UNION
select
@Robot as 'robotname'
,'Tool: ' + cast(TC.ElectrodeNbr as varchar(2)) 
,TC.DateTime
from [GADATA].[dbo].[WearBeforeChange] as TC

where 
TC.DateTime between   @startdate and @EndDate 
AND
TC.TimerID = @timerid
AND
TC.ElectrodeNbr = @ElectrodeNbr

) as x 


---------------------------------------------------------------------------------------
SELECT 
 #Timeref.RobotName
,#Timeref.tool_id
,#Timeref.Timestamp
,'SBCUlong' as 'TYPE'
,sbcu.Dsetup
,sbcu.UCL
,sbcu.LCL
,NULL as 'CylinderTime'
,NULL as 'CylinderUCL'
,NULL as 'CylinderLCL'
,NULL as 'MidairRes'
,NULL as 'MidairRef'
,sbcu.Toolx as 'ToolX'
,sbcu.Tooly as 'ToolY'
,sbcu.ToolZ as 'ToolZ'
FROM #Timeref 
left join gadata.c3g.sbcudata as sbcu on 
sbcu.tool_timestamp = #Timeref.Timestamp
AND 
sbcu.Longcheck = 1
AND
sbcu.tool_timestamp between   @startdate and @EndDate 
AND
sbcu.Robotname LIKE @Robot
AND
sbcu.tool_id LIKE @Tool

UNION
SELECT 
 #Timeref.RobotName
,#Timeref.tool_id
,#Timeref.Timestamp
,'SBCUshort' as 'TYPE'
,sbcu.Dsetup 
,sbcu.UCL
,sbcu.LCL
,NULL
,NULL
,NULL
,NULL
,NULL
,sbcu.Toolx as 'ToolX'
,sbcu.Tooly as 'ToolY'
,sbcu.ToolZ as 'ToolZ'

FROM #Timeref 
left join gadata.c3g.sbcudata as sbcu on 
sbcu.tool_timestamp = #Timeref.Timestamp
AND 
sbcu.Longcheck = 0
AND
sbcu.tool_timestamp between   @startdate and @EndDate 
AND
sbcu.Robotname LIKE @Robot
AND
sbcu.tool_id LIKE @Tool

UNION
SELECT 
 #Timeref.RobotName
,#Timeref.tool_id
,#Timeref.Timestamp
,'Cylinder' as 'TYPE'
,NULL
,NULL
,NULL
,Cylinder.TotalTime 
,Cylinder.UCL
,Cylinder.LCL
,NULL
,NULL
,NULL
,NULL
,NULL

FROM #Timeref 
left join gadata.c3g.WeldGunCylinder as Cylinder on 
Cylinder._timestamp = #Timeref.Timestamp
AND
Cylinder._timestamp between   @startdate and @EndDate 
AND
Cylinder.controller_name LIKE @Robot
AND
'%Tool: ' + CAST(Cylinder.tool_id as varchar(2)) LIKE @Tool

UNION
SELECT 
 #Timeref.RobotName
,#Timeref.tool_id
,#Timeref.Timestamp
,'Midair' as 'TYPE'
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,midair.ResisActual
,midair.ResisRef
,NULL
,NULL
,NULL
FROM #Timeref 
left join gadata.dbo.MidairRef as midair on 
midair.timestamp = #Timeref.Timestamp
AND
midair.timestamp between   @startdate and @EndDate 
AND
midair.Robotname LIKE @Robot
AND
midair.tool like @Tool

UNION
SELECT 
 #Timeref.RobotName
,#Timeref.tool_id
,#Timeref.Timestamp
,'Tipchange' as 'TYPE'
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,tc.wear as 'ResisRef'
,NULL
,NULL
,NULL
FROM #Timeref 
LEFT JOIN [GADATA].[dbo].[WearBeforeChange] as TC ON
TC.DateTime = #Timeref.Timestamp
AND
TC.DateTime between   @startdate and @EndDate 
AND
TC.TimerID LIKE @timerid
AND
tc.ElectrodeNbr like @ElectrodeNbr
 ---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Activity log (logs the execution of the Query to a table)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
DECLARE @rowcountmen as int 
SET @rowcountmen = @@rowcount
EXEC GADATA.volvo.sp_Alog  @rowcount = @rowcountmen, @Request = 'Running: [Volvo].[sp_GADATAWeldGunCockpit]'

END
GO
GRANT EXECUTE
    ON OBJECT::[Volvo].[sp_GADATAWeldGunCockpit] TO [db_frontendUser]
    AS [GADATA];



