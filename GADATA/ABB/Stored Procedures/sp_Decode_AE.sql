CREATE PROCEDURE [ABB].[sp_Decode_AE]

AS
--USE GADATA
---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------
BEGIN
---------------------------------------------------------------------------------------
--Live table splitting
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#ABB_AE_datasplit') is not null) drop table #ABB_AE_datasplit
SELECT
id,    
_timestamp,   
_message,
'IRC5' as 'Type',
CONVERT(XML,'<Product><Attribute>' + REPLACE([ABB].[fnStripLowAscii](_message),'"', '</Attribute><Attribute>') + '</Attribute></Product>') AS Message_Attr 
INTO #ABB_AE_datasplit
FROM gadata.dbo.rt_message
WHERE len(_message) <> 0 --drops empty records
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--push read data to 'readable table'
---------------------------------------------------------------------------------------
--!!!!only use to rebluid table--
--if (OBJECT_ID('Gadata.abb.rt_alarm') is not null) drop table Gadata.abb.rt_alarm
--SET IDENTITY_INSERT Gadata.abb.rt_alarm ON;
--!!!!only use to rebluid table--
INSERT into GADATA.abb.rt_alarm
SELECT 
--null, -- #ABB_AE_datasplit.id,        
#ABB_AE_datasplit._timestamp,
#ABB_AE_datasplit.Type,
#ABB_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[2]','varchar(25)') AS 'Controller',
#ABB_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[6]','varchar(25)') AS 'Category',
#ABB_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[4]','varchar(500)') AS 'Message',
#ABB_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[12]','varchar(500)') AS 'Cause',
#ABB_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[16]','varchar(500)') AS 'Remedy',
CONVERT(bigint,REPLACE(REPLACE(REPLACE(#ABB_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[5]','varchar(25)'),'(',''),')',''),' ','')) AS 'WnFiletime',
REPLACE(#ABB_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[7]','varchar(25)'),' ((','')  AS 'severity', 
REPLACE(REPLACE(#ABB_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[9]','varchar(25)'),'1 3 ',''),') (','') AS 'number'
--!!!!only use to rebluid table--
--INTO Gadata.abb.rt_alarm
--!!!!only use to rebluid table--
FROM #ABB_AE_datasplit
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--clear read data from livestream table
---------------------------------------------------------------------------------------
DELETE FROM gadata.dbo.rt_message where gadata.dbo.rt_message.id <= (select max(#ABB_AE_datasplit.id) from #ABB_AE_datasplit)
---------------------------------------------------------------------------------------



END