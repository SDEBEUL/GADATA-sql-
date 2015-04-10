CREATE PROCEDURE [dbo].[sp_VCSC_C3G_Rt_alarm_logCleanup]
AS
BEGIN

--constraint on c_logteskt table (block double input)
/*
CREATE UNIQUE NONCLUSTERED INDEX [IndexTableUniqueRows] ON [GADATA].[RobotGA].[RobotLogText]
(
    [LogText] ASC

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = ON, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
*/
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--fill up the logtekst table

insert into [GADATA].[RobotGA].[RobotLogText]
SELECT DISTINCT [error_text]
FROM  [GADATA].[RobotGA].[rt_alarm]
--this clause is only for update mode 
WHERE rt_alarm.error_text_id is null 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--links the generated logtekst id to the rt_alarm table
UPDATE [GADATA].[RobotGA].rt_alarm
SET rt_alarm.error_text_id = [RobotLogText].id
FROM [GADATA].[RobotGA].[RobotLogText], [GADATA].[RobotGA].rt_alarm
WHERE 
([GADATA].[RobotGA].rt_alarm.error_text = [GADATA].[RobotGA].[RobotLogText].LogText)
--this clause only for update mode 
AND 
(rt_alarm.error_text_id is null)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--now I need to adjust ALL stored procs and data handelers to take the data from c_logtekst if its is there and go back to rt_alarm if not... (hold on this wil take a long time)
--Main systems are rebuild ...
--BUT do not null replace the rt_alarm.error_severity ! tis will generate a big issue for L_breakdown 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--clean up the rt_alarm table replace logtext and error_number with null if the error_id is joined 
UPDATE [GADATA].[RobotGA].rt_alarm
SET rt_alarm.error_text = null
FROM [GADATA].[RobotGA].rt_alarm
WHERE 
([GADATA].[RobotGA].rt_alarm.error_text_id is not null)

END