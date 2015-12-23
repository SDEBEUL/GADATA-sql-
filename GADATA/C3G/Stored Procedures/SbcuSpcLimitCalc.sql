


CREATE PROCEDURE [C3G].[SbcuSpcLimitCalc]

   @StartDate as varchar(32) = null,
   @EndDate as varchar(32) = null,
   @Robotmask as varchar(32) = '%',
   @Toolmask as varchar(32) = '%',
   @Show as bit = 1,
   @Commit as bit = 0,
   @Calc as bit = 0

AS
BEGIN

---------------------------------------------------------------------------------------
--Set default values of start and end date
---------------------------------------------------------------------------------------
if (@StartDate is null) 
BEGIN
SET @StartDate = GETDATE()-100
END

if (@EndDate is null) 
BEGIN
SET @EndDate = GETDATE()-80
END
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--clause to show current values
---------------------------------------------------------------------------------------
if((@show = 1) and (@calc = 0) and (@commit = 0)) 
BEGIN
SELECT * FROM GADATA.RobotGA.SBCUrefernce as ref 
left join GADATA.RobotGA.Robot as r on r.id = ref.Controller_id
--where  
--r.RobotName LIKE @Robotmask
--AND
--ref.tool_id LIKE @Toolmask
END
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--clause to recalulate new values
---------------------------------------------------------------------------------------
if((@show = 0) and (@calc = 1) and (@commit = 0)) 
BEGIN
Print 'calculate new limits'
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
,ROUND(AVG(rt.Dsetup)+(3*Stdev(rt.Dsetup)),2) as 'UCL'
,ROUND(AVG(rt.Dsetup)-(3*Stdev(rt.Dsetup)),2) as 'LCL'
from GADATA.RobotGA.rt_toollog as rt 
left join GADATA.RobotGA.Robot as r on r.id = rt.controller_id
where 
RobotName LIKE @Robotmask
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
DELETE GADATA.RobotGA.SBCUrefernce FROM GADATA.RobotGA.SBCUrefernce as ref 
left join GADATA.RobotGA.Robot as r on r.id = ref.controller_id
Where r.RobotName LIKE @Robotmask AND ref.tool_id LIKE @Toolmask
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
Print 'calculate new limits'
---------------------------------------------------------------------------------------
INSERT INTO GADATA.RobotGA.SBCUrefernce
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
,ROUND(AVG(rt.Dsetup)+(3*Stdev(rt.Dsetup)),2) as 'UCL'
,ROUND(AVG(rt.Dsetup)-(3*Stdev(rt.Dsetup)),2) as 'LCL'
--INTO GADATA.RobotGA.SBCUrefernce
from GADATA.RobotGA.rt_toollog as rt 
left join GADATA.RobotGA.Robot as r on r.id = rt.controller_id
where 
RobotName LIKE @Robotmask
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


END