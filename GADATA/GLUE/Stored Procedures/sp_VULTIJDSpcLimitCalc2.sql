﻿


CREATE PROCEDURE [GLUE].[sp_VULTIJDSpcLimitCalc2]

   @StartDate as varchar(32) = null,
   @EndDate as varchar(32) = null,
--   @Robotmask as varchar(32) = '%', -- 
   @Teamstername as varchar(32) = NULL,
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
--If gunname defined use gunname to get robot
---------------------------------------------------------------------------------------
--if (@Teamstername is not null)
--BEGIN
--SET @Robotmask = (SELECT TOP 1 '%' + CONCAT(LEFT(@Teamstername,5),'R',RIGHT(@Teamstername,2)) + '%')
--END

---------------------------------------------------------------------------------------
--clause to show current values
---------------------------------------------------------------------------------------
if((@show = 1) and (@calc = 0) and (@commit = 0)) 
BEGIN
SELECT 
*
FROM GADATA.GLUE.VULTIJDreferentie as vgm
where  
vgm.Controller LIKE @Teamstername

END
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--clause to recalulate new values
---------------------------------------------------------------------------------------
if((@show = 0) and (@calc = 1) and (@commit = 0)) 
BEGIN
---------------------------------------------------------------------------------------
select 
 vgm.Controller as 'Controller_id'
,Min(vgm.tijdstip) as 'SampleStart'
,Count(vgm.tijdstip) as 'nDataPoints'
,ROUND(AVG(vgm.vultijd_s),2) as 'avg'
,ROUND(Max(vgm.vultijd_s),2) as 'Max'
,ROUND(Min(vgm.vultijd_s),2) as 'Min'
,ROUND(Stdev(vgm.vultijd_s),2) as 'Stdev'
,ROUND(AVG(vgm.vultijd_s)+(1*Stdev(vgm.vultijd_s)),2) as 'UCL'
,ROUND(AVG(vgm.vultijd_s)-(1*Stdev(vgm.vultijd_s)),2) as 'LCL'
FROM GADATA.GLUE.vultijd as vgm
where 
vgm.Controller LIKE @Teamstername
AND
vgm.tijdstip between @StartDate and @EndDate
group by 
 vgm.Controller
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
DELETE GLUE.VULTIJDreferentie FROM GLUE.VULTIJDreferentie as ref 
Where ref.Controller LIKE @Teamstername-- AND ref.tool_id LIKE @Toolmask
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Print 'calculate new limits'
---------------------------------------------------------------------------------------
INSERT INTO GLUE.VULTIJDreferentie
select 
 vgm.Controller as 'Controller_id'
,Min(vgm.tijdstip) as 'SampleStart'
,Count(vgm.tijdstip) as 'nDataPoints'
,ROUND(AVG(vgm.vultijd_s),2) as 'avg'
,ROUND(Max(vgm.vultijd_s),2) as 'Max'
,ROUND(Min(vgm.vultijd_s),2) as 'Min'
,ROUND(Stdev(vgm.vultijd_s),2) as 'Stdev'
,ROUND(AVG(vgm.vultijd_s)+(1*Stdev(vgm.vultijd_s)),2) as 'UCL'
,ROUND(AVG(vgm.vultijd_s)-(1*Stdev(vgm.vultijd_s)),2) as 'LCL'
FROM GADATA.GLUE.vultijd as vgm
where 
vgm.Controller LIKE @Teamstername
AND
vgm.tijdstip between @StartDate and @EndDate
group by 
 vgm.Controller


---------------------------------------------------------------------------
SELECT 'c:' + CAST(@@ROWCOUNT as varchar(3)) as 'Feedback' 
END
---------------------------------------------------------------------------------------


END