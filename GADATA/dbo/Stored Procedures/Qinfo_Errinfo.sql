CREATE PROCEDURE [dbo].[Qinfo_Errinfo]
   @Robot as varchar(16) = '99020R01'
   ,@ErrCode as int = null
AS
BEGIN
SELECT TOP 1 
[Info] as 'INFO:' 
,[Cause] as 'Cause:' 
,[Remedy] as 'Remedy:' FROM [GADATA].[RobotGA].[FaultInfo] 
WHERE ErrorNbr = @ErrCode
END