
CREATE PROCEDURE [GLUE].[sp_update_L_Alarm]

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
Print '--Running GLUE.sp_update_L'
print '--*****************************************************************************--'
---------------------------------------------------------------------------------------------------------------------
--****************************************************************************************************************--

---------------------------------------------------------------------------------------
Print'--add new faultinfo (el id, Priority, faultDescription) to table'
---------------------------------------------------------------------------------------
INSERT INTO GADATA.glue.FaultInfo
SELECT  distinct  
 R.Str3 as 'ElectricalID'
,R.Str4 as 'Priority'
,R.str5 as 'FaultText'
From GADATA.GLUE.rt_data as R

Left join GADATA.glue.FaultInfo as L on
(R.Str3 = L.[El_Ident])
AND
(R.Str4 = L.[Priority])
AND
(
(LTRIM(RTRIM(R.str5)) = LTRIM(RTRIM(L.Description)))
)
where 
(L.id IS NULL) AND (R.LogType=1)


---------------------------------------------------------------------------------------
Print'--add new controllers to table'
---------------------------------------------------------------------------------------


INSERT INTO GADATA.glue.Controller
SELECT  distinct  
 R1.Location as 'Controller'
From GADATA.GLUE.rt_data as R1

Left join GADATA.glue.Controller as L1 on
LTRIM(RTRIM(R1.Location)) = LTRIM(RTRIM(L1.Name))

where 
(L1.id IS NULL) AND (R1.LogType=1)


Print'--add new signals to table'
---------------------------------------------------------------------------------------

INSERT INTO GADATA.glue.Signal
SELECT  distinct  
 R2.Str5 as 'Controller'
From GADATA.GLUE.rt_data as R2

Left join GADATA.glue.Signal as L2 on
LTRIM(RTRIM(R2.Str5)) = LTRIM(RTRIM(L2.SignalName))

where 
(L2.id IS NULL) AND (R2.LogType=1)

--****************************************************************************************************************--



---------------------------------------------------------------------------------------
Print'--step to normalize the rt_alarm dataset. gets the normalized id. and put it in a temp table'
---------------------------------------------------------------------------------------
if (OBJECT_ID('#GLUE_rt_alarm_normalized') is not null) drop table #GLUE_rt_alarm_normalized
SELECT 
R.ID,
 L1.ID as 'controller_id'
,R.Str1 as 'c_status'
,R.DateTime as 'DatumTijd'
,L.ID as 'FaultText_id'
,L2.ID as 'Signal_id'

INTO #GLUE_rt_alarm_normalized

FROM GADATA.glue.rt_data as R 

--join error_id
join gadata.glue.FaultInfo as L on
(
(R.Str3 = L.[El_Ident])
AND
(R.Str4 = L.[Priority])
AND
LTRIM(RTRIM(R.str5)) = LTRIM(RTRIM(L.Description))
)

--join controller_id
join GADATA.glue.Controller as L1 on
LTRIM(RTRIM(R.Location)) = LTRIM(RTRIM(L1.Name))

--join Singal_id
join GADATA.glue.Signal as L2 on
LTRIM(RTRIM(R.Str5)) = LTRIM(RTRIM(L2.SignalName))

left OUTER join GADATA.GLUE.overbodige_alarm_fouten4 as OVB on LTRIM(RTRIM(OVB.Name))=LTRIM(RTRIM(L.Description))

where OVB.ID IS NULL AND R.LogType=1
---------------------------------------------------------------------------------------

--Select top 10000 * from #GLUE_rt_alarm_normalized
--order by [Signal_id] desc


---------------------------------------------------------------------------------------
Print'--Cross compare and put into Hystorian if needed'
---------------------------------------------------------------------------------------
INSERT INTO GADATA.GLUE.h_alarm
SELECT 
 R.controller_id
,R.c_status
,R.DatumTijd
,R.FaultText_id
,R.Signal_id
FROM #GLUE_rt_alarm_normalized as R 


--this will filter out unique results
LEFT join GADATA.GLUE.h_alarm AS H on   --show also compare the logtekst here.... 
(
(R.controller_id  = H.Controller_id)
AND
(R.DatumTijd = H.c_timestamp) --was losing data because of this (controle side clock resolution = 1s so errors in the same S only 1 would pass. 
AND
(R.FaultText_id = H.FaultText_id)
AND
(R.Signal_id = H.Signal_id)
AND
(R.c_status = H.c_status)
)
where (H.id IS NULL) 


-- delete rt data where logtype =1
---------------------------------------------------------------------------------------
Print'--delete rt data where logtype =1'
---------------------------------------------------------------------------------------

DELETE FROM [GLUE].[rt_data]
      WHERE (LogType=1) AND ( ([GLUE].[rt_data].ID ) <= (select max(ID) from #GLUE_rt_alarm_normalized) )

--****************************************************************************************************************--
END