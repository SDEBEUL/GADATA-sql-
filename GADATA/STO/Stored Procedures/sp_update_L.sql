
CREATE PROCEDURE [STO].[sp_update_L]

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
Print '--Running STO.sp_update_L'
print '--*****************************************************************************--'
--------------------------------------------------------------------------------------------------------------------
--****************************************************************************************************************--
---------------------------------------------------------------------------------------
Print'--Update c_stotable with all NEW Unique tables'
---------------------------------------------------------------------------------------
INSERT INTO GADATA.STO.c_stotable
SELECT  distinct  
 R.StoTable
From GADATA.STO.rt_error as R 
Left join GADATA.STO.c_stotable as c on
(R.StoTable = c.StoTable)
where 
(c.id IS NULL) 
--****************************************************************************************************************--
---------------------------------------------------------------------------------------
Print'--Update c_controller with all NEW Unique controllers'
---------------------------------------------------------------------------------------
INSERT INTO GADATA.STO.c_controller(ALAMRSOURCE,SUBZONENAME,ALARMOBJECT)
SELECT  distinct  
 R.ALARMSOURCE
,R.SUBZONENAME
,SUBSTRING( R.ALARMOBJECT,0,CHARINDEX('.',  R.ALARMOBJECT)) as 'ALARMOBJECT'
From GADATA.STO.rt_error as R 

Left join GADATA.STO.c_controller as c on
(R.ALARMSOURCE = c.ALAMRSOURCE)
AND
(ISNULL(R.SUBZONENAME,'') = ISNULL(c.SUBZONENAME,''))
AND
(SUBSTRING( R.ALARMOBJECT,0,CHARINDEX('.',  R.ALARMOBJECT)) = c.ALARMOBJECT)
where 
(c.id IS NULL) 
--****************************************************************************************************************--

---------------------------------------------------------------------------------------
Print'--Update L_error with all NEW Unique text, error number and error serv'
---------------------------------------------------------------------------------------
INSERT INTO GADATA.STO.L_error(SUBOBJECT,ALARMSEVERITY,ALARMCOMMENT)
SELECT  distinct  
 REPLACE(R.ALARMOBJECT, SUBSTRING( R.ALARMOBJECT,0,CHARINDEX('.',  R.ALARMOBJECT)),'') as 'SUBOBJECT'
,R.ALARMSEVERITY
,R.ALARMCOMMENT
From GADATA.STO.rt_error as R 

Left join GADATA.STO.L_error as L on
(R.ALARMSEVERITY = L.ALARMSEVERITY)
AND
(R.ALARMCOMMENT = L.ALARMCOMMENT)
AND
(
( REPLACE(R.ALARMOBJECT, SUBSTRING( R.ALARMOBJECT,0,CHARINDEX('.',  R.ALARMOBJECT)),'') = L.SUBOBJECT)
)
where 
(L.id IS NULL) 
--****************************************************************************************************************--

---------------------------------------------------------------------------------------
Print'--step to normalize the rt_alarm dataset. gets the normalized id. and put it in a temp table'
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#STO_rt_alarm_normalized') is not null) drop table #STO_rt_alarm_normalized
SELECT 
 R.inALARMTIMESTAMP
,R.inALARMTIMESTAMP as '_timestamp'
,C.id as 'C_controller_id'
,L.id as 'L_error_id'
,R.outALARMTIMESTAMP as 'RESETTIMESTAMP'
,t.id as 'c_stotable_id'
INTO #STO_rt_alarm_normalized
FROM 
(
SELECT [NID_ALARM_DATA]
      ,[ALARMSOURCE]
      ,[ALARMOBJECT]
      ,[ALARMCOMMENT]
      ,[ALARMSEVERITY]
      ,[GEOLOACTION]
      ,[ALARMSTATUS] as 'outALARMSTATUS'
      ,[ALARMTIMESTAMP] as 'outALARMTIMESTAMP'
      ,[SUBZONENAME]
      ,[StoTable]
      ,[id]
	  ,lead([ALARMTIMESTAMP]) OVER (PARTITION BY [ALARMOBJECT] ORDER BY [NID_ALARM_DATA] desc) as 'inALARMTIMESTAMP'
	  ,lead([ALARMSTATUS]) OVER (PARTITION BY [ALARMOBJECT] ORDER BY [NID_ALARM_DATA] desc) as 'inALARMSTATUS'
  FROM [GADATA].[STO].[rt_error]
) as R
--join error_id
join gadata.STO.L_error as L on 
(
(L.SUBOBJECT = REPLACE(R.ALARMOBJECT, SUBSTRING( R.ALARMOBJECT,0,CHARINDEX('.',  R.ALARMOBJECT)),''))
AND
(L.ALARMSEVERITY = R.ALARMSEVERITY)
AND
(L.ALARMCOMMENT = R.ALARMCOMMENT)
)
--join controller
join GADATA.STO.c_controller as C on
(
(R.ALARMSOURCE = c.ALAMRSOURCE)
AND
(ISNULL(R.SUBZONENAME,'') = ISNULL(c.SUBZONENAME,''))
AND
(SUBSTRING( R.ALARMOBJECT,0,CHARINDEX('.',  R.ALARMOBJECT)) = c.ALARMOBJECT)
)
--join table 
left join GADATA.STO.c_stotable as t on t.StoTable = R.StoTable
-- 
WHERE  R.inALARMSTATUS = 1 --alarm must start with status 1
  AND  R.outALARMSTATUS = 0 --end with status 0 
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
INSERT INTO GADATA.STO.h_breakdown(ALARMTIMESTAMP,_timestamp,c_controller_id,l_error_id,RESETTIMESTAMP,c_stotable_id)
SELECT 
 R.inALARMTIMESTAMP
,R._timestamp
,R.C_controller_id
,R.L_error_id
,R.RESETTIMESTAMP 
,R.c_stotable_id
FROM #STO_rt_alarm_normalized as R 
--this will filter out unique results
LEFT join GADATA.STO.h_breakdown AS H on  
(
(R.C_controller_id  = H.C_controller_id)
AND
(R.L_error_id = H.l_error_id)
AND
(R._timestamp = H._timestamp)
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
Print'GADATA.STO.sp_Activitylog Newrecords:' + CONVERT(varchar(10),@rowcountmen) 
DECLARE @RequestString as varchar(255)
SET @RequestString = 'Running: [STO].[sp_update_L]'
EXEC GADATA.volvo.sp_Alog  @rowcount = @rowcountmen, @Request = @RequestString
---------------------------------------------------------------------------------------
Print'--clear rt_error'
---------------------------------------------------------------------------------------
DELETE GADATA.STO.rt_error FROM GADATA.STO.rt_error
--****************************************************************************************************************--
END