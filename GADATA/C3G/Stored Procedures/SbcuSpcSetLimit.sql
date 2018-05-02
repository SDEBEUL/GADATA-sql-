
CREATE PROCEDURE [C3G].[SbcuSpcSetLimit]
   @Robotmask as varchar(32) = '%',
   @Toolmask as varchar(32) = '%',
   @Weldgunname as varchar(32) = NULL,
   @Show as bit = 0,
   @Set as bit = 0,
   @UCL as float = null,
   @LCL as float = null

AS
BEGIN

SET NOCOUNT ON 


---------------------------------------------------------------------------------------
--If gunname defined use gunname to get robot and toolid 
---------------------------------------------------------------------------------------
if (@Weldgunname is not null)
BEGIN
SET @Robotmask = (SELECT TOP 1 '%' + rws.Robot + '%' from GADATA.volvo.RobotWeldGunRelation as rws where rws.WeldgunName LIKE @Weldgunname)
SET @Toolmask = (SELECT TOP 1 '%' + CAST(rws.ElectrodeNbr as varchar(2)) + '%' from GADATA.volvo.RobotWeldGunRelation as rws where rws.WeldgunName LIKE @Weldgunname)
END

---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--clause to show current values
---------------------------------------------------------------------------------------
if((@show = 1) and (@Set = 0)) 
BEGIN
SELECT 
wgr.WeldgunName
,wgr.Robot
,ref.*
FROM GADATA.volvo.RobotWeldGunRelation as wgr
left join GADATA.c3g.SBCUrefernce as ref on
ref.Controller_id = wgr.robotid
AND
ref.tool_id = wgr.ElectrodeNbr
where  
wgr.RobotType = 'c3g'
AND
ref.Longcheck = 1
AND
wgr.Robot LIKE @Robotmask
AND
ref.tool_id LIKE @Toolmask

END
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--set new values
---------------------------------------------------------------------------------------
if((@show = 0) and (@Set = 1)) 
BEGIN
--update the record
UPDATE GADATA.C3G.SBCUrefernce
set  UCL = @UCL
	,LCL = @LCL
	,nDataPoints = -1
	,[avg] = -1
	,[Min] = -1
	,[Max] = -1
	,[Stdev] = -1
	,SampleStart = GETDATE()
FROM GADATA.volvo.RobotWeldGunRelation as wgr
left join GADATA.c3g.SBCUrefernce as ref on
ref.Controller_id = wgr.robotid
AND
ref.tool_id = wgr.ElectrodeNbr
where  
wgr.RobotType = 'c3g'
AND
ref.Longcheck = 1
AND
wgr.Robot LIKE @Robotmask
AND
ref.tool_id LIKE @Toolmask

--return new values
SELECT 
 wgr.WeldgunName
,wgr.Robot
,ref.*
FROM GADATA.volvo.RobotWeldGunRelation as wgr
left join GADATA.c3g.SBCUrefernce as ref on
ref.Controller_id = wgr.robotid
AND
ref.tool_id = wgr.ElectrodeNbr
where  
wgr.RobotType = 'c3g'
AND
ref.Longcheck = 1
AND
wgr.Robot LIKE @Robotmask
AND
ref.tool_id LIKE @Toolmask
END

END