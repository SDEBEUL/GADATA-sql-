


CREATE PROCEDURE [C3G].[SbcuSpcLimitCalc]

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
SET @StartDate = GETDATE()-40
END

if (@EndDate is null)
BEGIN
SET @EndDate = GETDATE()-10
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
left join GADATA.c3g.SBCUrefernce as ref on
ref.Controller_id = wgr.robotid
AND
ref.tool_id = wgr.ElectrodeNbr
where  
wgr.RobotType = 'c3g'
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
 r.ID as 'Controller_id'
,rt.tool_id
,rt.Longcheck
,Min(tool_timestamp) as 'SampleStart'
,Count(tool_timestamp) as 'nDataPoints'
,ROUND(AVG(rt.Dsetup),2) as 'avg'
,ROUND(Max(rt.Dsetup),2) as 'Max'
,ROUND(Min(rt.Dsetup),2) as 'Min'
,ROUND(Stdev(rt.Dsetup),2) as 'Stdev'
,ROUND(AVG(rt.Dsetup)+(4*Stdev(rt.Dsetup)),2) as 'UCL'
,ROUND(AVG(rt.Dsetup)-(4*Stdev(rt.Dsetup)),2) as 'LCL'
from GADATA.c3g.rt_toollog as rt 
left join GADATA.c3g.c_controller as r on r.id = rt.controller_id
where 
r.controller_name LIKE @Robotmask
AND
tool_id LIKE @Toolmask
AND 
Longcheck in (0,1) --only do this with the new logtype system.  
AND
tool_timestamp between @StartDate and @EndDate
group by 
 r.ID
,rt.tool_id
,rt.Longcheck
END
---------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------
--clause to recalulate AND COMMIT new values
---------------------------------------------------------------------------------------
if((@show = 0) and (@calc = 0) and (@commit = 1)) 
BEGIN
---------------------------------------------------------------------------------------
Print 'Delete the target guns that wil be recalculated'
---------------------------------------------------------------------------------------
--DROP TABLE GADATA.RobotGA.SBCUrefernce
DELETE GADATA.c3g.SBCUrefernce FROM GADATA.c3g.SBCUrefernce as ref 
left join GADATA.c3g.c_controller as r on r.id = ref.controller_id
Where r.controller_name LIKE @Robotmask AND ref.tool_id LIKE @Toolmask
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
Print 'calculate new limits'
---------------------------------------------------------------------------------------
INSERT INTO GADATA.c3g.SBCUrefernce
select 
 r.ID as 'Controller_id'
,rt.tool_id
,rt.Longcheck
,Min(tool_timestamp) as 'SampleStart'
,Count(tool_timestamp) as 'nDataPoints'
,ROUND(AVG(rt.Dsetup),2) as 'avg'
,ROUND(Max(rt.Dsetup),2) as 'Max'
,ROUND(Min(rt.Dsetup),2) as 'Min'
,ROUND(Stdev(rt.Dsetup),2) as 'Stdev'
,ROUND(AVG(rt.Dsetup)+(4*Stdev(rt.Dsetup)),2) as 'UCL'
,ROUND(AVG(rt.Dsetup)-(4*Stdev(rt.Dsetup)),2) as 'LCL'
from GADATA.c3g.rt_toollog as rt 
left join GADATA.c3g.c_controller as r on r.id = rt.controller_id
where 
controller_name LIKE @Robotmask
AND
tool_id LIKE @Toolmask
AND 
Longcheck in (0,1) --only do this with the new logtype system.  
AND
tool_timestamp between @StartDate and @EndDate
group by 
 r.ID
,rt.tool_id
,rt.Longcheck
---------------------------------------------------------------------------------------
SELECT 'c:' + CAST(@@ROWCOUNT as varchar(3)) as 'Feedback' 
END
---------------------------------------------------------------------------------------


END
GO
GRANT EXECUTE
    ON OBJECT::[C3G].[SbcuSpcLimitCalc] TO [AASPOT_a]
    AS [GADATA];

