CREATE PROCEDURE [C3G].[sp_update_L]

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
,null
,null
,null
From GADATA.C3G.rt_alarm as R 

Left join GADATA.C3G.L_error as L on
(R.[error_number] = L.[error_number])
AND
(R.[error_severity] = L.[error_severity])
AND
(
(LTRIM(RTRIM(R.error_text)) = LTRIM(RTRIM(L.error_text)))
)
where 
(L.id IS NULL) 
AND 
(R.[error_severity] <> -1)
--****************************************************************************************************************--

---------------------------------------------------------------------------------------
Print'--step to normalize the rt_alarm dataset. gets the normalized id. and put it in a temp table'
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#C3G_rt_alarm_normalized') is not null) drop table #C3G_rt_alarm_normalized
SELECT 
 R.controller_id
,R._timestamp
,R.error_timestamp as 'c_timestamp'
,R.error_is_alarm as 'error_is_alarm'
,L_error.id as 'error_id'
,NULL as 'is_realtime'
INTO #C3G_rt_alarm_normalized
FROM GADATA.c3g.rt_alarm as R 

--join error_id
join gadata.C3G.L_error on 
(
(L_error.[error_number] = R.[error_number])
AND
(L_error.[error_severity] = R.[error_severity])
AND
(LTRIM(RTRIM(L_error.error_text)) = LTRIM(RTRIM(R.error_text)))
AND 
(R.[error_severity] <> -1)
)

---------------------------------------------------------------------------------------


--****************************************************************************************************************--
---------------------------------------------------------------------------------------------------------------------
--In this part we will compare the rt_alarm with h_alarm.
--we must check for duplicate errors between rt_alarm and h_alarm.
--alarm text and remedy we will not crosscompare to save time 
---------------------------------------------------------------------------------------------------------------------
--****************************************************************************************************************--

---------------------------------------------------------------------------------------
Print'--Cross compare and put into Hystorian if needed'
---------------------------------------------------------------------------------------
INSERT INTO GADATA.C3G.h_alarm
SELECT 
 R.controller_id
,R._timestamp
,R.c_timestamp
,R.error_is_alarm
,R.error_id
,NULL as 'is_realtime'
FROM #C3G_rt_alarm_normalized as R 


--this will filter out unique results
LEFT join GADATA.C3G.h_alarm AS H on   --show also compare the logtekst here.... 
(
(R.controller_id  = H.controller_id)
AND
(isnull(R.c_timestamp,r._timestamp) = isnull(H.c_timestamp,h._timestamp)) --was losing data because of this (controle side clock resolution = 1s so errors in the same S only 1 would pass. 
AND
(R.error_id = H.error_id)
--Current solution MAY give Dups. is the rt_alarm does not contain the error that is in on the controller.
--(R._timestamp = H._timestamp) 
)
where (H.id IS NULL) 

--****************************************************************************************************************--
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Activity log (logs the execution of the Query to a table)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
DECLARE @rowcountmen as int 
SET @rowcountmen = @@rowcount
Print'GADATA.C4G.sp_Activitylog Newrecords:' + CONVERT(varchar(10),@rowcountmen) 
DECLARE @RequestString as varchar(255)
SET @RequestString = 'Running: [C3G].[sp_update_L]'
EXEC GADATA.volvo.sp_Alog  @rowcount = @rowcountmen, @Request = @RequestString
---------------------------------------------------------------------------------------

END