CREATE PROCEDURE [dbo].[Qinfo_Errinfo]
   @Robot as varchar(16) = '99020R01'
  ,@ErrCode as int = null
  ,@ErrID as int = null
  ,@opt1 as varchar(2000) = null
  ,@user as varchar(16) = null
AS
BEGIN


--voor c3g
if 'c3g' = (select top 1 controller_type from GADATA.Volvo.Robots where controller_name = @Robot)
BEGIN
SELECT TOP 1 
 GADATA.[dbo].[fn_QinfoFormatString]([Info]) as 'INFO:' 
,GADATA.[dbo].[fn_QinfoFormatString]([Cause]) as 'Cause:' 
,GADATA.[dbo].[fn_QinfoFormatString]([Remedy]) as 'Remedy:' 
FROM [GADATA].[RobotGA].[FaultInfo] 
WHERE ErrorNbr = @ErrCode
END

--voor c4g
if 'c4g' = (select top 1 controller_type from GADATA.Volvo.Robots where controller_name = @Robot)
BEGIN
SELECT TOP 1 
 GADATA.[dbo].[fn_QinfoFormatString]([Info]) as 'INFO:' 
,GADATA.[dbo].[fn_QinfoFormatString]([Cause]) as 'Cause:' 
,GADATA.[dbo].[fn_QinfoFormatString]([Remedy]) as 'Remedy:' 
FROM [GADATA].[RobotGA].[FaultInfo] 
WHERE ErrorNbr = @ErrCode
END

--voor IRC5
if 'IRC5' = (select top 1 controller_type from GADATA.Volvo.Robots where controller_name = @Robot)
BEGIN
select top 1 
'Will use this for user info later ... bye bye sdebeul' as 'INFO:' 
,c.cause_text as 'Cause:' 
,R.Remedy_text as 'Remedy:'
from GADATA.ABB.h_alarm as h 
left join GADATA.ABB.L_Cause as c on c.id = h.cause_id
left join GADATA.ABB.L_Remedy as R on R.id = h.remedy_id
WHERE h.id = @ErrID
END


END