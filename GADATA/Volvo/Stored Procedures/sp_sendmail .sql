
CREATE PROCEDURE [Volvo].[sp_sendmail ]
AS
begin
DECLARE @msg NVARCHAR(MAX) = 'efkes testen of ik u kan mailen vanin sssm'; 
EXEC msdb.dbo.sp_send_dbmail  
@recipients = 'SDEBEUL@volvocars.com',  
@profile_name = 'GADATA',  
@body = @msg,  
@subject = 'Ik ben de database',
@query = 'select top 10 * from gadata.c3g.c_Controller',
@append_query_error = 1
;

end