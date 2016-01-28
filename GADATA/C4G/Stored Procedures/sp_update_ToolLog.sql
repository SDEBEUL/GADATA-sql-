
CREATE PROCEDURE [C4G].[sp_update_ToolLog]

AS
--USE GADATA
---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------
BEGIN
--****************************************************************************************************************--
/*
Info...
This sp normalized SBCU data from the C4G system.
This Data is uptained by 3 variable monitors 
The first will contain the SETUP POSTION of the active tool
62	1	hsbcu->grc_beamSetup.fp_tool	10000	0	False	rt_toolLog	value	1	12	7	0	0	0	0	-1	0	NULL
The second will contain the TOOLNAME of the active tool.
63	1	hsbcu->grc_beamSetup.nameTool	10000	0	False	rt_toollog	value	1	12	7	0	0	0	0	-1	0	NULL
The tirth will contain the last tcp measurement of the active tool.
64	1	dsbcu->vp_tool	10000	0	False	rt_toollog	value	1	12	7	0	0	0	0	-1	0	NULL

note that if you don't do a setup or toolchange that 1 and 2 will never change.. So the values will only be uptanded once.
The reason for uptaining them is A to get a clear tool name and B the setup pos to have the ablity to calc a delta setup. 

*/
--****************************************************************************************************************--
---------------------------------------------------------------------------------------------------------------------
--In this part we will compare the error text data from rt_alarm with the L_<logtext> tables.
--This is the first part in normalizing the db. (store each text / error type once
print '--*****************************************************************************--'
Print '--Running C4G.[sp_update_ToolLog]'
print '--*****************************************************************************--'
---------------------------------------------------------------------------------------------------------------------
--****************************************************************************************************************--

---------------------------------------------------------------------------------------
Print'--step to split the rt_toolog dataset. splits into x y z toolname...'
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#c4g_toollogsplit') is not null) drop table #c4g_toollogsplit 
SELECT 
rt.*
,CONVERT(XML,'<Product><Attribute>' + REPLACE(GADATA.abb.fnStripLowAscii(REPLACE(rt.value,'<','')),',', '</Attribute><Attribute>') + '</Attribute></Product>') AS XmlSplit  
INTO #c4g_toollogsplit 
FROM GADATA.C4G.rt_toolLog as rt 
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
Print'--step to normalize the rt_toolog dataset SETUP'
---------------------------------------------------------------------------------------
--haal de setup meting eruit en poeft da in apparte table. (enkel toevoegen als ze anders is ...)

---------------------------------------------------------------------------------------
Print'--step to normalize the rt_toolog dataset MEASUREMENTS'
---------------------------------------------------------------------------------------
--INSERT INTO GADATA.C4G.h_alarm
SELECT --select 'measurement' values
 R.controller_id
,C4G.fn_GetActiveTool(r.controller_id,r._timestamp) as 'Tool_name'
,R._timestamp
--,R.value as 'fp_tool'
,R.XmlSplit.value('/Product[1]/Attribute[1]','real') AS 'X'
,R.XmlSplit.value('/Product[1]/Attribute[2]','real') AS 'Y'
,R.XmlSplit.value('/Product[1]/Attribute[3]','real') AS 'Z'
--hier dan nog join met laatste setup meeting van die tang op Dsetup te doen.
FROM #c4g_toollogsplit as R 
where r.variable_id = 64
order by r._timestamp desc 
---------------------------------------------------------------------------------------





---------------------------------------------------------------------------------------
Print'--delete in rt_toolLog if older than 1 day' --must always keep the last toolname/setup in the log... 
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------

--****************************************************************************************************************--
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Activity log (logs the execution of the Query to a table)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
DECLARE @rowcountmen as int 
SET @rowcountmen = @@rowcount
DECLARE @RequestString as varchar(255)
SET @RequestString = 'Running: [C4G].[sp_update_ToolLog]'
EXEC GADATA.volvo.sp_Alog  @rowcount = @rowcountmen, @Request = @RequestString
---------------------------------------------------------------------------------------


END