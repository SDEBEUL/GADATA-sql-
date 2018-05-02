


CREATE PROCEDURE [EqUi].[GetErrorInfoData]
  @Location as varchar(max) = '{0}'
 ,@ERRORNUM as int = null --{1} 
 ,@Refid as int = null --{2}
 ,@logtype as varchar(max) = '{3}'
AS
BEGIN
-- Remove hash tag from location
SET @Location = REPLACE(@location,'#','')
--find controller type
DECLARE @controllerTYPE as varchar(10) = (select top 1 controller_type from gadata.equi.ASSETS where RTRIM(location) = @Location)
--voor c3g
if @controllerTYPE = 'c3g'
BEGIN
SELECT TOP 1 
 GADATA.[dbo].[fn_QinfoFormatString]([Info]) as 'INFO' 
,GADATA.[dbo].[fn_QinfoFormatString]([Cause]) as 'Cause' 
,GADATA.[dbo].[fn_QinfoFormatString]([Remedy]) as 'Remedy' 
FROM [GADATA].[Volvo].[FaultInfo] 
WHERE ErrorNbr = @ERRORNUM
END

--voor c4g
if @controllerTYPE = 'c4g' 
BEGIN
SELECT TOP 1 
 GADATA.[dbo].[fn_QinfoFormatString]([Info]) as 'INFO' 
,GADATA.[dbo].[fn_QinfoFormatString]([Cause]) as 'Cause' 
,GADATA.[dbo].[fn_QinfoFormatString]([Remedy]) as 'Remedy' 
FROM [GADATA].[Volvo].[FaultInfo] 
WHERE ErrorNbr = @ERRORNUM
END

--voor NGAC
if @controllerTYPE = 'NGAC' and @logtype in('ControllerEvent','LIVE')
BEGIN
select top 1 
 le.Title
,ld.Description
,lco.Consequences
,lca.Causes
,lac.Actions
from GADATA.NGAC.h_alarm as h 
left join GADATA.NGAC.L_error as le on le._id = h.L_error_id
left join GADATA.NGAC.L_description as ld on ld.id = le.l_description_id
left join GADATA.NGAC.L_consequences as lco on lco.id = le.l_consequences_id
left join GADATA.NGAC.L_causes as lca on lca.id = le.l_causes_id
left join GADATA.NGAC.L_actions as lac on lac.id = le.l_actions_id
WHERE h.id = @Refid
END

if @controllerTYPE = 'NGAC' and @logtype = 'Breakdown'
BEGIN
select top 1 
 le.Title
,ld.Description
,lco.Consequences
,lca.Causes
,lac.Actions
from GADATA.NGAC.rt_job as rtj 
left join GADATA.NGAC.rt_job_breakdown as rtjb on rtjb.rt_job_active_id = rtj.id and rtjb.[index] = 1
left join GADATA.NGAC.h_alarm as h on h.id = rtjb.h_alarm_id
left join GADATA.NGAC.L_error as le on le._id = h.L_error_id
left join GADATA.NGAC.L_description as ld on ld.id = le.l_description_id
left join GADATA.NGAC.L_consequences as lco on lco.id = le.l_consequences_id
left join GADATA.NGAC.L_causes as lca on lca.id = le.l_causes_id
left join GADATA.NGAC.L_actions as lac on lac.id = le.l_actions_id
WHERE rtj.id = @Refid
END

--voor NGAC
if @controllerTYPE = 'NGAC' and @logtype = 'ErrDispLog'
BEGIN
select top 1 
 h.FullLogtext
from GADATA.NGAC.ErrDispLog as h 
WHERE h.refId = @Refid
END


-- 
END