
CREATE PROCEDURE [dbo].[Qinfo_CheckAlert]
    @Robot as varchar(16) = '54020R01'
   ,@ErrCode as int = null
   ,@ErrID as int = null
   ,@opt1 as varchar(2000) = null
   ,@user as varchar(16) = null
--gives the right permission when a low level user only has execution rights
with execute as owner
AS
BEGIN
--we will use this sp to manage the alert table from the front end system.
--by default i will return a record containing the alert info.
--if parm @ErrCode is set to 1 i will update the "Accept" if not null
--if parm @ErrCode is set to 2 i will update the "Fix" if not null
--if parm @ErrCode is set to 3 i will update the "Close" if not null
--if parm @ErrCode is set to 4 to add info 
/*
I will also be useing the @errCode for setting the alert status int.
*/
--accept the alert 
if (@ErrCode = 1)
BEGIN
UPDATE GADATA.volvo.ia_Alert
SET 
 ia_alert.Accept_user = ISNULL(ia_alert.accept_user,@user)
,ia_alert.Accept_timestamp = ISNULL(ia_alert.accept_timestamp,GETDATE())
,ia_alert.AlertStatus = 1
FROM GADATA.volvo.ia_Alert
where ia_Alert.id = @ErrID 
END

--complete the alert
if (@ErrCode = 2)
BEGIN
UPDATE GADATA.volvo.ia_Alert
SET 
 ia_alert.Fix_user = ISNULL(ia_alert.fix_user,@user)
,ia_alert.Fix_timestamp = ISNULL(ia_alert.fix_timestamp,GETDATE())
,ia_alert.AlertStatus = 2
FROM GADATA.volvo.ia_Alert
where ia_Alert.id = @ErrID 
END

--close the alert
if (@ErrCode = 3)
BEGIN
UPDATE GADATA.volvo.ia_Alert
SET 
 ia_alert.Close_user = isnull(ia_alert.close_user,@user)
,ia_alert.Close_timestamp = isnull(ia_alert.Close_timestamp,getdate())
,ia_alert.AlertStatus = 3
FROM GADATA.volvo.ia_Alert
where ia_Alert.id = @ErrID  
END

--edit comment 
if (@ErrCode = 4)
BEGIN
UPDATE GADATA.volvo.ia_Alert
SET 
--append new comment to old comments 
 ia_alert.User_Comment = ISNULL(ia_alert.User_Comment,CHAR(13)+CHAR(10)) + ( @user + ': ' + CHAR(13)+CHAR(10) + @opt1 + CHAR(13)+CHAR(10) + '***************************' + CHAR(13)+CHAR(10) )
FROM GADATA.volvo.ia_Alert
where ia_Alert.id = @ErrID
END


--return the current alert info
SELECT TOP 1 
'*****Alert info*****' as '*'
,a.Detect_timestamp as 'Detected:'
,a.Accept_user as 'AcceptUser:'
,a.Accept_timestamp as 'AcceptTime:'
,a.Fix_user as 'FixUser:'
,a.Fix_timestamp as 'FixTime:'
,a.Close_user as 'CloseUser:'
,a.Close_timestamp as 'CloseTime:'
,a.user_comment as 'Info:' 
,'********************' as'*'
FROM GADATA.volvo.ia_Alert as a where a.id = @ErrID

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Qinfo_CheckAlert] TO [db_frontendUser]
    AS [dbo];



