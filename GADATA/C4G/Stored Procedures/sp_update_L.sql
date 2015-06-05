CREATE PROCEDURE [C4G].[sp_update_L]

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
print '--*****************************************************************************--'
Print '--Running C4G.sp_update_L'
print '--*****************************************************************************--'
---------------------------------------------------------------------------------------------------------------------
--****************************************************************************************************************--
---------------------------------------------------------------------------------------
Print'--Update L_error with all NEW Unique text, error number and error serv'
---------------------------------------------------------------------------------------
INSERT INTO GADATA.C4G.L_error
SELECT  distinct  
 R.[error_number]
,R.[error_severity]
,ISNULL(R.error_text,c_logtekst.error_text) as 'error_text'
,NULL as 'Appl_id'
,NULL as 'Subgroup_id'
From GADATA.dbo.rt_alarm as R 
--this join is temporary... just to get the 'historical data'  
left join GADATA.dbo.c_logtekst  on R.error_id = c_logtekst.id


Left join GADATA.C4G.L_error as L on
(R.[error_number] = L.[error_number])
AND
(R.[error_severity] = L.[error_severity])
AND
(
(R.error_text = L.error_text)

--temporary
OR
(c_logtekst.error_text = L.error_text)
)
where (L.id IS NULL)
---------------------------------------------------------------------------------------

/*
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
Print'--step to normalize the rt_alarm dataset. gets the normalized id. and put it in a temp table'
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#ABB_AE_normalized') is not null) drop table #ABB_AE_normalized
SELECT 
 rt_alarm_IRC5.id
,c_controller.id as 'controller_id'
,rt_alarm_IRC5._timestamp
,rt_alarm_IRC5.WnFiletime
,null as 'error_is_alarm'
,L_error.id as 'error_id'
,L_cause.id as 'cause_id'
,L_remedy.id  as 'remedy_id'
,null as 'restart_id'
INTO #ABB_AE_normalized
FROM GADATA.ABB.rt_alarm_IRC5
--join controller_id
join gadata.abb.c_controller on (c_controller.controller_name = rt_alarm_IRC5.controller)

--join error_id
join gadata.abb.L_error on 
(
(L_error.[error_number] = rt_alarm_IRC5.number)
AND
(L_error.[error_severity] = rt_alarm_IRC5.severity)
AND
(L_error.error_text = rt_alarm_IRC5.[message])
)
--join cause_id
join GADATA.abb.L_Cause on (l_cause.cause_text = rt_alarm_IRC5.cause)
--join remedy_id
join GADATA.abb.L_Remedy on (L_Remedy.Remedy_text = rt_alarm_IRC5.Remedy)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
Print'--Update h_alarm with all NEW Unique alarms (Watch => constraints on wi_timestamp / controller_id / error_id)'
---------------------------------------------------------------------------------------
INSERT INTO GADATA.ABB.h_alarm
SELECT 
 #ABB_AE_normalized.controller_id
,#ABB_AE_normalized._timestamp
,#ABB_AE_normalized.WnFileTime
,abb.BigIntTimeToDateTime(abb.CombineToBigint(CONVERT(numeric(10),abb.[SplitString](#ABB_AE_normalized.WnFileTime,' ',1)),CONVERT(numeric(10),abb.[SplitString](#ABB_AE_normalized.WnFileTime,' ',2)))) as 'wd_timestamp'
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
*/
---------------------------------------------------------------------------------------
--Print'--delete in rt_alarm is exist in h_alarm (Watch => constraints on wi_timestamp / controller_id / error_id)'
---------------------------------------------------------------------------------------
--DELETE FROM gadata.abb.rt_alarm_IRC5 where gadata.abb.rt_alarm_IRC5.id <= (select max(id) from #ABB_AE_normalized)
---------------------------------------------------------------------------------------

--****************************************************************************************************************--

END