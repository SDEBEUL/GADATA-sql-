

CREATE PROCEDURE [NGAC].[sp_Housekeeping]

AS
BEGIN
---------------------------------------------------------------------------------------------------------------------
print '--*****************************************************************************--'
Print '--Running [NGAC].[sp_Housekeeping]'
print '--*****************************************************************************--'
---------------------------------------------------------------------------------------------------------------------

--******************************************************************--
Print 'check for unused records in L_*'
--******************************************************************--

--select count(*) as 'L_actions'
DELETE GADATA.NGAC.L_actions
FROM GADATA.NGAC.L_actions as l 
left join GADATA.NGAC.L_error as le on le.l_actions_id = l.id
where le._id is null

--select count(*) as 'L_causes'
DELETE GADATA.NGAC.L_causes
FROM GADATA.NGAC.L_causes as l 
left join GADATA.NGAC.L_error as le on le.l_causes_id = l.id
where le._id is null

--select count(*) as 'L_consequences'
DELETE GADATA.NGAC.L_consequences
FROM GADATA.NGAC.L_consequences as l 
left join GADATA.NGAC.L_error as le on le.l_consequences_id = l.id
where le._id is null

--select count(*) as 'L_description'
DELETE GADATA.NGAC.L_description
FROM GADATA.NGAC.L_description as l 
left join GADATA.NGAC.L_error as le on le.l_description_id = l.id
where le._id is null

--select count(*) as 'L_error'
DELETE GADATA.NGAC.L_error
FROM GADATA.NGAC.L_error as l 
left join GADATA.NGAC.h_alarm as h on l._id = h.L_error_id
where h.L_error_id  is null

--******************************************************************--
--remove all operational errors older than 30days.
--******************************************************************--
DELETE GADATA.NGAC.h_alarm FROM GADATA.NGAC.h_alarm as h 
WHERE h.CategoryId = 1 --operational
AND h.error_timestamp < GETDATE()-30
--******************************************************************--

--******************************************************************--
--remove all rt_events older than 30days.
--******************************************************************--
DELETE GADATA.NGAC.rt_event FROM GADATA.NGAC.rt_event as e
WHERE  e._timestamp < GETDATE()-30
--******************************************************************--



--******************************************************************--
--remove all user warning older than 30days. (not linked to a breakdown)
--******************************************************************--
DELETE GADATA.NGAC.h_alarm FROM GADATA.NGAC.h_alarm as h 
left join GADATA.NGAC.L_error as l  on l._id = h.L_error_id
left join GADATA.NGAC.rt_job_breakdown as rjb on rjb.h_alarm_id = h.id
WHERE h.CategoryId = 8 and l.Number = 3
AND h.error_timestamp < GETDATE()-30
AND rjb.h_alarm_id is null 
--******************************************************************--

--******************************************************************--
--remove all paint context warning older than 30days. (not linked to a breakdown)
--******************************************************************--
DELETE GADATA.NGAC.h_alarm FROM GADATA.NGAC.h_alarm as h 
left join GADATA.NGAC.L_error as l  on l._id = h.L_error_id
left join GADATA.NGAC.rt_job_breakdown as rjb on rjb.h_alarm_id = h.id
WHERE h.CategoryId = 13 and l.Number = 2999
AND h.error_timestamp < GETDATE()-30
AND rjb.h_alarm_id is null 
--******************************************************************--

--******************************************************************--
--analoge output  (not linked to a breakdown)
--******************************************************************--
DELETE GADATA.NGAC.h_alarm FROM GADATA.NGAC.h_alarm as h 
left join GADATA.NGAC.L_error as l  on l._id = h.L_error_id
left join GADATA.NGAC.rt_job_breakdown as rjb on rjb.h_alarm_id = h.id
WHERE h.CategoryId = 2 and l.Number = 176
AND h.error_timestamp < GETDATE()-30
AND rjb.h_alarm_id is null 
--******************************************************************--

--******************************************************************--
--confirm rejected (not linked to a breakdown)
--******************************************************************--
DELETE GADATA.NGAC.h_alarm FROM GADATA.NGAC.h_alarm as h 
left join GADATA.NGAC.L_error as l  on l._id = h.L_error_id
left join GADATA.NGAC.rt_job_breakdown as rjb on rjb.h_alarm_id = h.id
WHERE h.CategoryId = 2 and l.Number = 148
AND h.error_timestamp < GETDATE()-30
AND rjb.h_alarm_id is null 
--******************************************************************--

--******************************************************************--
--profinet diag (not linked to a breakdown)
--******************************************************************--
DELETE GADATA.NGAC.h_alarm FROM GADATA.NGAC.h_alarm as h 
left join GADATA.NGAC.L_error as l  on l._id = h.L_error_id
left join GADATA.NGAC.rt_job_breakdown as rjb on rjb.h_alarm_id = h.id
WHERE h.CategoryId = 7 and l.Number = 1492
AND h.error_timestamp < GETDATE()-30
AND rjb.h_alarm_id is null 
--******************************************************************--

--******************************************************************--
--corner path failure (not linked to a breakdown)
--******************************************************************--
DELETE GADATA.NGAC.h_alarm FROM GADATA.NGAC.h_alarm as h 
left join GADATA.NGAC.L_error as l  on l._id = h.L_error_id
left join GADATA.NGAC.rt_job_breakdown as rjb on rjb.h_alarm_id = h.id
WHERE h.CategoryId = 5 and l.Number = 24
AND h.error_timestamp < GETDATE()-30
AND rjb.h_alarm_id is null 
--******************************************************************--

--******************************************************************--
--protective stope (not linked to a breakdown)
--******************************************************************--
DELETE GADATA.NGAC.h_alarm FROM GADATA.NGAC.h_alarm as h 
left join GADATA.NGAC.L_error as l  on l._id = h.L_error_id
left join GADATA.NGAC.rt_job_breakdown as rjb on rjb.h_alarm_id = h.id
WHERE h.CategoryId = 9 and l.Number = 523
AND h.error_timestamp < GETDATE()-30
AND rjb.h_alarm_id is null 
--******************************************************************--

--******************************************************************--
--tool pos vialation (not linked to a breakdown)
--******************************************************************--
DELETE GADATA.NGAC.h_alarm FROM GADATA.NGAC.h_alarm as h 
left join GADATA.NGAC.L_error as l  on l._id = h.L_error_id
left join GADATA.NGAC.rt_job_breakdown as rjb on rjb.h_alarm_id = h.id
WHERE h.CategoryId = 9 and l.Number = 513
AND h.error_timestamp < GETDATE()-30
AND rjb.h_alarm_id is null 
--******************************************************************--

--******************************************************************--
--reference error(not linked to a breakdown)
--******************************************************************--
DELETE GADATA.NGAC.h_alarm FROM GADATA.NGAC.h_alarm as h 
left join GADATA.NGAC.L_error as l  on l._id = h.L_error_id
left join GADATA.NGAC.rt_job_breakdown as rjb on rjb.h_alarm_id = h.id
WHERE h.CategoryId = 4 and l.Number = 168
AND h.error_timestamp < GETDATE()-30
AND rjb.h_alarm_id is null 
--******************************************************************--

--******************************************************************--
--timeout (not linked to a breakdown)
--******************************************************************--
DELETE GADATA.NGAC.h_alarm FROM GADATA.NGAC.h_alarm as h 
left join GADATA.NGAC.L_error as l  on l._id = h.L_error_id
left join GADATA.NGAC.rt_job_breakdown as rjb on rjb.h_alarm_id = h.id
WHERE h.CategoryId = 4 and l.Number = 534
AND h.error_timestamp < GETDATE()-30
AND rjb.h_alarm_id is null 
--******************************************************************--

END