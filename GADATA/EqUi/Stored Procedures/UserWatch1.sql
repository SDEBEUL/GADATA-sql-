


CREATE PROCEDURE [EqUi].[UserWatch1]

AS
BEGIN

/*select  
c.session_id
,c.client_net_address
,s.login_time
,s.host_name
,s.client_interface_name
,s.login_name
,s.status
,s.cpu_time
,s.memory_usage
,s.reads
,s.writes
,s.logical_reads
,db_name(s.database_id) as 'db_name'
from sys.dm_exec_connections C 
join sys.dm_exec_sessions S on S.session_id = C.session_ID
order by s.cpu_time desc 
*/

insert gadata.equi.UserPerformanceTrack
select 
GETDATE() as 'testtime'
,c.session_id
,c.client_net_address
,s.login_time
,s.host_name
,s.client_interface_name
,s.login_name
,s.status
,s.cpu_time
,s.memory_usage
,s.reads
,s.writes
,s.logical_reads
,db_name(s.database_id) as 'db_name'
--INTO gadata.equi.UserPerformanceTrack
from sys.dm_exec_connections C 
join sys.dm_exec_sessions S on S.session_id = C.session_ID
order by s.cpu_time desc 

END