

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
left join GADATA.NGAC.L_error as le on le.l_causes_id = l.id
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


END