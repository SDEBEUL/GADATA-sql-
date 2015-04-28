CREATE PROCEDURE [ABB].[sp_update_L]

AS
--USE GADATA
---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------
BEGIN
--****************************************************************************************************************--
---------------------------------------------------------------------------------------------------------------------
--In this part we will compare the error text data from rt_alarm with the L_<logtext> tables.
--This is the first part in normalizing the db. (store each text / error type once
---------------------------------------------------------------------------------------------------------------------
--****************************************************************************************************************--

---------------------------------------------------------------------------------------
--Update L_remedy with all NEW Unique text
---------------------------------------------------------------------------------------
INSERT INTO GADATA.abb.L_Remedy
SELECT distinct 
Remedy
From GADATA.abb.rt_alarm
Left join GADATA.abb.L_Remedy on
(rt_alarm.Remedy = L_Remedy.Remedy_text)
where (L_Remedy.id IS NULL)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--Update L_Cause with all NEW Unique text
---------------------------------------------------------------------------------------
INSERT INTO GADATA.abb.L_Cause
SELECT distinct 
Cause
From GADATA.abb.rt_alarm
Left join GADATA.abb.L_Cause on
(rt_alarm.Cause = L_Cause.Cause_text)
where (L_Cause.id IS NULL)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--Update C_Category with all NEW Unique text
---------------------------------------------------------------------------------------
INSERT INTO GADATA.abb.C_Category
SELECT distinct 
rt_alarm.Category
From GADATA.abb.rt_alarm
Left join GADATA.abb.C_Category on
(rt_alarm.category = C_Category.Category)
where (C_Category.id IS NULL)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--Update C_Controller with all NEW controllers
---------------------------------------------------------------------------------------
INSERT INTO GADATA.abb.c_controller
SELECT distinct 
rt_alarm.Controller
,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL-- 14 empty field to match table def. (need to find cleaner solution)
From GADATA.abb.rt_alarm
Left join GADATA.abb.c_controller on
(rt_alarm.controller = c_controller.controller_name)
where (c_controller.id IS NULL)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--Update L_error with all NEW Unique text (Watch => constraint to category_id)
---------------------------------------------------------------------------------------
INSERT INTO GADATA.abb.L_error
SELECT distinct 
[number]
,[severity]
,[Message]
,null
,null
,c_category.id
From GADATA.abb.rt_alarm
Left join GADATA.abb.L_error on
(rt_alarm.[Message] = L_error.error_text)
LEFT join GADATA.abb.c_category on 
(GADATA.abb.rt_alarm.Category = GADATA.abb.c_category.Category)
where (L_error.id IS NULL)
---------------------------------------------------------------------------------------

--****************************************************************************************************************--

--****************************************************************************************************************--
---------------------------------------------------------------------------------------------------------------------
--In this part we will compare the rt_alarm with h_alarm.
--we must check for duplicate errors between rt_alarm and h_alarm.
--(everytime we reconnect OPC will send us the complete dataset for that controller.
--we must keep in mind that the _timestamp value of rt_alarm is the COMPUTER timestamp when the message was received.
--so we can only use the rt_alarm.WnfileTime collum as 'id' we will also check this against severity and number just to be safe.
--alarm text and remedy we will not crosscompare to save time 
---------------------------------------------------------------------------------------------------------------------
--****************************************************************************************************************--

---------------------------------------------------------------------------------------
--step the normalize the rt_alarm dataset. gets the normalized id. and puts it in a temp table
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#ABB_AE_normalized') is not null) drop table #ABB_AE_normalized
SELECT 
 rt_alarm.id
,c_controller.id as 'controller_id'
,rt_alarm._timestamp
,rt_alarm.WnFiletime
,null as 'error_is_alarm'
,L_error.id as 'error_id'
,L_cause.id as 'cause_id'
,L_remedy.id  as 'remedy_id'
,null as 'restart_id'
INTO #ABB_AE_normalized
FROM GADATA.ABB.rt_alarm
--join controller_id
join gadata.abb.c_controller on (c_controller.controller_name = rt_alarm.controller)

--join error_id
join gadata.abb.L_error on 
(
(L_error.[error_number] = rt_alarm.number)
AND
(L_error.[error_severity] = rt_alarm.severity)
AND
(L_error.error_text = rt_alarm.[message])
)
--join cause_id
join GADATA.abb.L_Cause on (l_cause.cause_text = rt_alarm.cause)
--join remedy_id
join GADATA.abb.L_Remedy on (L_Remedy.Remedy_text = rt_alarm.Remedy)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--Update h_alarm with all NEW Unique alarms (Watch => constraints on wi_timestamp / controller_id / error_id)
---------------------------------------------------------------------------------------
INSERT INTO GADATA.ABB.h_alarm
SELECT 
 #ABB_AE_normalized.controller_id
,#ABB_AE_normalized._timestamp
,#ABB_AE_normalized.WnFileTime --confict met big int 
,#ABB_AE_normalized.error_is_alarm
,#ABB_AE_normalized.error_id
,#ABB_AE_normalized.cause_id
,#ABB_AE_normalized.remedy_id
,#ABB_AE_normalized.restart_id
FROM #ABB_AE_normalized
--this will filter out unique results
LEFT join GADATA.abb.h_alarm on 
(
(#ABB_AE_normalized.WnFiletime  = GADATA.abb.h_alarm.wi_timestamp)
AND
(#ABB_AE_normalized.controller_id  = GADATA.abb.h_alarm.controller_id)
AND
(#ABB_AE_normalized.error_id  = GADATA.abb.h_alarm.error_id)
)
where (h_alarm.id IS NULL)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--delete in rt_alarm is exist in h_alarm (Watch => constraints on wi_timestamp / controller_id / error_id)
---------------------------------------------------------------------------------------
DELETE FROM gadata.abb.rt_alarm where gadata.abb.rt_alarm.id <= (select max(id) from #ABB_AE_normalized)
---------------------------------------------------------------------------------------


--****************************************************************************************************************--

END