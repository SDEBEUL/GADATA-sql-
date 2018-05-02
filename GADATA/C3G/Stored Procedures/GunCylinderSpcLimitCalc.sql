



CREATE PROCEDURE [C3G].[GunCylinderSpcLimitCalc]

   @StartDate as varchar(32) = null,
   @EndDate as varchar(32) = null,
   @Robotmask as varchar(32) = '%',
   @Toolmask as varchar(32) = '%',
   @Weldgunname as varchar(32) = NULL,
   @Show as bit = 0,
   @Commit as bit = 0,
   @Calc as bit = 0

AS
BEGIN

SET NOCOUNT ON 

---------------------------------------------------------------------------------------
--Set default values of start and end date
---------------------------------------------------------------------------------------
if (@StartDate is null) 
BEGIN
SET @StartDate = GETDATE()-100
END

if (@EndDate is null)
BEGIN
SET @EndDate = GETDATE()
END
--for handeling 'today' clause in dt selectors
if (@EndDate = '1900-01-01 00:00:00:000')
BEGIN
SET @enddate = getdate()
END
---------------------------------------------------------------------------------------

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
if((@show = 1) and (@calc = 0) and (@commit = 0)) 
BEGIN
SELECT 
wgr.WeldgunName
,wgr.Robot
,ref.*
FROM GADATA.volvo.RobotWeldGunRelation as wgr
left join c3g.GunCylinderefernce as ref on
ref.Controller_id = wgr.robotid
AND
ref.tool_id = wgr.ElectrodeNbr
where  
WGR.RobotType = 'c3g'
AND
wgr.Robot LIKE @Robotmask
AND
ref.tool_id LIKE @Toolmask

END
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--clause to recalulate new values
---------------------------------------------------------------------------------------
if((@show = 0) and (@calc = 1) and (@commit = 0)) 
BEGIN
---------------------------------------------------------------------------------------
select 
 rt.controller_id as 'Controller_id'
,rt.tool_id
,Min(_timestamp) as 'SampleStart'
,Count(_timestamp) as 'nDataPoints'
,ROUND(AVG(rt.TotalTime),2) as 'avg'
,ROUND(Max(rt.TotalTime),2) as 'Max'
,ROUND(Min(rt.TotalTime),2) as 'Min'
,ROUND(Stdev(rt.TotalTime),2) as 'Stdev'
,ROUND(AVG(rt.TotalTime)+(4*Stdev(rt.TotalTime)),2) as 'UCL'
,ROUND(AVG(rt.TotalTime)-(4*Stdev(rt.TotalTime)),2) as 'LCL'
from GADATA.C3G.WeldGunCylinder as rt 
where 
rt.controller_name LIKE @Robotmask
AND
tool_id LIKE @Toolmask
AND
rt.tool_id is not null
AND
rt._timestamp between @StartDate and @EndDate
group by 
 rt.Controller_id
,rt.tool_id



END
---------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------
--clause to recalulate AND COMMIT new values
---------------------------------------------------------------------------------------
if((@show = 0) and (@calc = 0) and (@commit = 1)) 
BEGIN
---------------------------------------------------------------------------------------
--Print 'Delete the target guns that wil be recalculated'
---------------------------------------------------------------------------------------
--DROP TABLE GADATA.RobotGA.SBCUrefernce
DELETE c3g.GunCylinderefernce FROM c3g.GunCylinderefernce as ref 
left join GADATA.C3G.c_controller r on r.id = ref.controller_id
Where r.controller_name LIKE @Robotmask AND ref.tool_id LIKE @Toolmask
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Print 'calculate new limits'
---------------------------------------------------------------------------------------
INSERT INTO c3g.GunCylinderefernce
select 
 rt.controller_id as 'Controller_id'
,rt.tool_id
,Min(_timestamp) as 'SampleStart'
,Count(_timestamp) as 'nDataPoints'
,ROUND(AVG(rt.TotalTime),2) as 'avg'
,ROUND(Max(rt.TotalTime),2) as 'Max'
,ROUND(Min(rt.TotalTime),2) as 'Min'
,ROUND(Stdev(rt.TotalTime),2) as 'Stdev'
,ROUND(AVG(rt.TotalTime)+(4*Stdev(rt.TotalTime)),2) as 'UCL'
,ROUND(AVG(rt.TotalTime)-(4*Stdev(rt.TotalTime)),2) as 'LCL'
from GADATA.C3G.WeldGunCylinder as rt 

where 
rt.controller_name LIKE @Robotmask
AND
tool_id LIKE @Toolmask
AND
rt.tool_id is not null
AND
rt._timestamp between @StartDate and @EndDate
group by 
 rt.Controller_id
,rt.tool_id



---------------------------------------------------------------------------
SELECT 'c:' + CAST(@@ROWCOUNT as varchar(3)) as 'Feedback' 
END
---------------------------------------------------------------------------------------


END
GO
GRANT EXECUTE
    ON OBJECT::[C3G].[GunCylinderSpcLimitCalc] TO [AASPOT_a]
    AS [GADATA];

