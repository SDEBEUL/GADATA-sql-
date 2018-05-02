CREATE PROCEDURE [C3G].[sp_Housekeeping]

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
Print '--Running [C3G].[sp_Housekeeping]'
print '--*****************************************************************************--'
---------------------------------------------------------------------------------------------------------------------
--****************************************************************************************************************--
---------------------------------------------------------------------------------------
Print'--Keep last 200 matched errors for each robot in the rt_alarm.. Dump the rest'; --
---------------------------------------------------------------------------------------
With DeletePoint as
(
SELECT 
 rt.controller_id
,rt.error_timestamp
,ROW_NUMBER() OVER (PARTITION BY rt.controller_id ORDER BY rt.error_timestamp asc) AS rnDESC
From GADATA.C3G.rt_alarm as rt
where
rt.[error_severity] <> -1 
)
---------------------------------------------------------------------------------------
DELETE GADATA.C3G.rt_alarm 
--SELECT *
FROM GADATA.C3G.rt_alarm as rt 
LEFT JOIN DeletePoint as Dp on
Dp.controller_id = rt.controller_id
AND
DP.error_timestamp < rt.error_timestamp
AND
DP.rnDESC = 200
WHERE DP.rnDESC = 200
--****************************************************************************************************************--

---------------------------------------------------------------------------------------
Print'--Keep last 30 days of rt_sys_event.. Dump the rest'; --
---------------------------------------------------------------------------------------
DELETE GADATA.C3G.rt_sys_event
FROM GADATA.C3G.rt_sys_event as E
WHERE E._timestamp < GETDATE()-30
--****************************************************************************************************************--

---------------------------------------------------------------------------------------
Print'--Keep last 30 days of L_operation.. Dump the rest'; --
---------------------------------------------------------------------------------------
DELETE GADATA.C3G.L_operation
FROM GADATA.C3G.L_operation as L
WHERE L._timestamp < GETDATE()-30
--****************************************************************************************************************--

Print'--Keep last 30 days of cycletime.. Dump the rest'; --
---------------------------------------------------------------------------------------
DELETE GADATA.C3G.rt_CycleTime
FROM GADATA.C3G.rt_CycleTime as L
WHERE L._timestamp < GETDATE()-100
--****************************************************************************************************************--


END