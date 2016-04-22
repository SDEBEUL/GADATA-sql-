



CREATE PROCEDURE [GLUE].[sp_update_L_Operator]

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
Print '--Running GLUE.sp_update_L_Operator'
print '--*****************************************************************************--'
---------------------------------------------------------------------------------------------------------------------
--****************************************************************************************************************--

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
(L1.id IS NULL) AND (R1.LogType=2)


---------------------------------------------------------------------------------------
Print'--add new users to table'
---------------------------------------------------------------------------------------


INSERT INTO GADATA.glue.users
SELECT  distinct  
 R1.Str2 as 'UserName'
From GADATA.GLUE.rt_data as R1

Left join GADATA.glue.users as L1 on
LTRIM(RTRIM(R1.str2)) = LTRIM(RTRIM(L1.Name))

where 
(L1.id IS NULL) AND (R1.LogType=2)

Print'--add new OperatorActionInfo to table'
---------------------------------------------------------------------------------------

INSERT INTO GADATA.glue.OperatorActionInfo
SELECT  distinct  
 R2.Str4 as 'Signal'
From GADATA.GLUE.rt_data as R2

Left join GADATA.glue.OperatorActionInfo as L3 on
LTRIM(RTRIM(R2.Str4)) = LTRIM(RTRIM(L3.Description))

where 
(L3.id IS NULL) AND (R2.LogType=2)


Print'--add new signals to table'
---------------------------------------------------------------------------------------

INSERT INTO GADATA.glue.Signal
SELECT  distinct  
 R2.Str7 as 'Signal'
From GADATA.GLUE.rt_data as R2

Left join GADATA.glue.Signal as L2 on
LTRIM(RTRIM(R2.Str7)) = LTRIM(RTRIM(L2.SignalName))

where 
(L2.id IS NULL) AND (R2.LogType=2)

--****************************************************************************************************************--



---------------------------------------------------------------------------------------
Print'--step to normalize the rt_alarm dataset. gets the normalized id. and put it in a temp table'
---------------------------------------------------------------------------------------
if (OBJECT_ID('#GLUE_rt_alarm_normalized') is not null) drop table #GLUE_rt_alarm_normalized
SELECT 
--R.Location as 'tmp_contr'
L.ID as 'controller_id'
,R.DateTime as 'DatumTijd'
--,R.Str2 as 'tmp_User_id'
,L1.ID as 'User_id'
--,R.str4 as 'tmp_OperatorActionInfo_id'
,L2.ID as 'OperatorActionInfo_id'
,R.Str5 as 'NewValue'
,R.Str6 as 'OldValue'
--,R.Str7 as 'tmp_Signal_id'
,L3.ID as 'Signal_id'


INTO #GLUE_rt_alarm_normalized

FROM GADATA.glue.rt_data as R 

--join controller_id
join GADATA.glue.Controller as L on
LTRIM(RTRIM(R.Location)) = LTRIM(RTRIM(L.Name))

-- join User_id
join GADATA.glue.Users as L1 on
LTRIM(RTRIM(R.Str2)) = LTRIM(RTRIM(L1.Name))

-- join OperatorActionInfo_id
join GADATA.glue.OperatorActionInfo as L2 on
LTRIM(RTRIM(R.Str4)) = LTRIM(RTRIM(L2.Description))

--join Singal_id
join GADATA.glue.Signal as L3 on
LTRIM(RTRIM(R.Str7)) = LTRIM(RTRIM(L3.SignalName))

left OUTER join GADATA.GLUE.overbodige_operator_fouten4 as OVB on OVB.Name=L2.Description

where OVB.ID IS NULL AND R.LogType=2

---------------------------------------------------------------------------------------

Select top 10000 * from #GLUE_rt_alarm_normalized
--order by [Signal_id] desc


---------------------------------------------------------------------------------------
Print'--Cross compare and put into Hystorian if needed'
---------------------------------------------------------------------------------------
INSERT INTO GADATA.GLUE.h_operator
SELECT 
 R.controller_id
,R.DatumTijd
,R.User_id
,R.OperatorActionInfo_id
,R.NewValue
,R.OldValue
,R.Signal_id
FROM #GLUE_rt_alarm_normalized as R 


--this will filter out unique results
LEFT join GADATA.GLUE.h_operator AS H on   --show also compare the logtekst here.... 
(
(R.controller_id  = H.Controller_id)
AND
(R.DatumTijd = H.c_timestamp) --was losing data because of this (controle side clock resolution = 1s so errors in the same S only 1 would pass. 
AND
(R.User_Id = H.User_id)
AND
(R.OperatorActionInfo_id = H.OperatorActionInfo_id)
AND
(R.NewValue = H.NewValue)
AND
(R.OldValue = H.OldValue)
AND
(R.Signal_id = H.Signal_id)
)
where (H.id IS NULL) 


-- delete rt data where logtype =1
---------------------------------------------------------------------------------------
Print'--delete rt data where logtype =2'
---------------------------------------------------------------------------------------

DELETE FROM [GLUE].[rt_data]
      WHERE LogType=2

--****************************************************************************************************************--
END