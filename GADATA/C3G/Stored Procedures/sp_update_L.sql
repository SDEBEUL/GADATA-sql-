﻿CREATE PROCEDURE [C3G].[sp_update_L]

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
Print '--Running C3G.sp_update_L'
print '--*****************************************************************************--'
---------------------------------------------------------------------------------------------------------------------
--****************************************************************************************************************--
---------------------------------------------------------------------------------------
Print'--Update L_error with all NEW Unique text, error number and error serv'
---------------------------------------------------------------------------------------
INSERT INTO GADATA.C3G.L_error
SELECT  distinct  
 R.[error_number]
,R.[error_severity]
,R.error_text as 'error_text'
,NULL as 'Appl_id'
,NULL as 'Subgroup_id'
From GADATA.C3G.rt_alarm as R 

Left join GADATA.C3G.L_error as L on
(R.[error_number] = L.[error_number])
AND
(R.[error_severity] = L.[error_severity])
AND
(
(R.error_text = L.error_text)
)
where (L.id IS NULL) AND (R.[error_number] <> -1)

---------------------------------------------------------------------------------------


--****************************************************************************************************************--

--****************************************************************************************************************--
---------------------------------------------------------------------------------------------------------------------
--In this part we will compare the rt_alarm with h_alarm.
--we must check for duplicate errors between rt_alarm and h_alarm.
--alarm text and remedy we will not crosscompare to save time 
---------------------------------------------------------------------------------------------------------------------
--****************************************************************************************************************--

---------------------------------------------------------------------------------------
Print'--step to normalize the rt_alarm dataset. gets the normalized id. and put it in a temp table'
---------------------------------------------------------------------------------------
INSERT INTO GADATA.C3G.h_alarm
SELECT 
 R.controller_id
,R._timestamp
,R.error_timestamp as 'c_timestamp'
,R.error_is_alarm as 'error_is_alarm'
,L_error.id as 'error_id'
,NULL as 'is_realtime'
FROM GADATA.c3g.rt_alarm as R 

--join error_id
join gadata.C3G.L_error on 
(
(L_error.[error_number] = R.[error_number])
AND
(L_error.[error_severity] = R.[error_severity])
AND
(L_error.error_text = R.error_text) 
)

--this will filter out unique results
LEFT join GADATA.C3G.h_alarm AS H on   --show also compare the logtekst here.... 
(
(R.controller_id  = H.controller_id)
AND
(R.error_timestamp = H.c_timestamp)
)
where (H.id IS NULL) AND (R.[error_number] <> -1)


---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
Print'--delete in rt_alarm if older than 1 day'
---------------------------------------------------------------------------------------
--DELETE FROM gadata.c3g.rt_alarm where GADATA.c3g.rt_alarm.error_timestamp < getdate()-1
---------------------------------------------------------------------------------------

--****************************************************************************************************************--

END