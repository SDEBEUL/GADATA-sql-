CREATE PROCEDURE [volvo].[spmonitor]

AS
BEGIN



---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Activity log (logs the execution of the Query to a table)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
DECLARE @rowcountmen as int 
SET @rowcountmen = @@rowcount
DECLARE @RequestString as varchar(255)
SET @RequestString = 'Trigger test'
EXEC GADATA.dbo.sp_Activitylog @rowcount = @rowcountmen, @Request = @RequestString

END