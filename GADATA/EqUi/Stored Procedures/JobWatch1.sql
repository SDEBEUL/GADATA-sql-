



CREATE PROCEDURE [EqUi].[JobWatch1]

AS
BEGIN

/*select 
 j.name as 'JobName'
,h.step_id
,h.step_name
,h.run_status
,h.run_date
,h.run_time
,h.run_duration
,h.message
From msdb.dbo.sysjobs j 
INNER JOIN msdb.dbo.sysjobhistory h 
 ON j.job_id = h.job_id 
where 
j.enabled = 1  --Only Enabled Jobs
and 
j.name like 'GADATA%'
and 
h.step_id = 0
order by run_date,run_time desc 
*/

insert gadata.equi.JobPerformanceTrack
select 
 getdate() as 'testtime'
,j.name 
,h.step_id
,h.step_name
,AVG(h.run_duration) as 'avgExec'
,MAX(h.run_duration) as 'MaxExec'
,Min(h.run_duration) as 'MinExec'
--into gadata.equi.JobPerformanceTrack
From msdb.dbo.sysjobs j 
INNER JOIN msdb.dbo.sysjobhistory h 
 ON j.job_id = h.job_id 
where 
j.enabled = 1  --Only Enabled Jobs
and 
j.name like 'GADATA%'
--and 
--h.step_id = 0

group by
j.name
,h.step_id
,h.step_name

order by j.name , h.step_id


END