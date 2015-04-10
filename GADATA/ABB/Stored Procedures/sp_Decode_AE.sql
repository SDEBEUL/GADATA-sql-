CREATE PROCEDURE [ABB].[sp_Decode_AE]
   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @RobotFilterWild as varchar(10) = '%'
AS
--USE GADATA
---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
BEGIN

--IRC5 Live table splitting
if (OBJECT_ID('tempdb..#ABB_IRC5_AE_datasplit') is not null) drop table #ABB_IRC5_AE_datasplit
SELECT
id,    
_timestamp,
_sqlTimestamp,    
_message,
'IRC5' as 'Type',
CONVERT(XML,'<Product><Attribute>' + REPLACE([ABB].[fnStripLowAscii](_message),'"', '</Attribute><Attribute>') + '</Attribute></Product>') AS Message_Attr 
INTO #ABB_IRC5_AE_datasplit
FROM rt_ABB_irc5_ae
WHERE len(_message) <> 0 --drops empty records
AND
_sqlTimestamp BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())

--S4 Live Table splitting
if (OBJECT_ID('tempdb..#ABB_S4_AE_datasplit') is not null) drop table #ABB_S4_AE_datasplit
SELECT
id,    
_timestamp,
_sqlTimestamp,    
_message,
'S4C' as 'Type',
CONVERT(XML,'<Product><Attribute>' + REPLACE([ABB].[fnStripLowAscii](_message),'"', '</Attribute><Attribute>') + '</Attribute></Product>') AS Message_Attr 
INTO #ABB_S4_AE_datasplit
FROM rt_ABB_s4_ae
WHERE len(_message) <> 0 --drops empty records
AND
_sqlTimestamp BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())

--combine the 2 tables and select the collums we will keep

SELECT         
--#ABB_IRC5_AE_datasplit._timestamp,
#ABB_IRC5_AE_datasplit._sqlTimestamp, 
#ABB_IRC5_AE_datasplit.Type,
--#ABB_IRC5_AE_datasplit._message,
#ABB_IRC5_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[2]','varchar(25)') AS 'Controller',
#ABB_IRC5_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[6]','varchar(25)') AS 'Category',
#ABB_IRC5_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[4]','varchar(500)') AS 'Message',
#ABB_IRC5_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[12]','varchar(500)') AS 'Cause',
#ABB_IRC5_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[16]','varchar(500)') AS 'Remedy',
REPLACE(REPLACE(#ABB_IRC5_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[5]','varchar(25)'),'(',''),')','') AS 'WnFiletime',
REPLACE(#ABB_IRC5_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[7]','varchar(25)'),' ((','')  AS 'severity', 
REPLACE(REPLACE(#ABB_IRC5_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[9]','varchar(25)'),'1 3 ',''),') (','') AS 'number'
FROM #ABB_IRC5_AE_datasplit
WHERE #ABB_IRC5_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[2]','varchar(25)') LIKE @RobotFilterWild

UNION
SELECT
--#ABB_S4_AE_datasplit._timestamp,
#ABB_S4_AE_datasplit._sqlTimestamp, 
#ABB_S4_AE_datasplit.Type,
--#ABB_S4_AE_datasplit._message,
#ABB_S4_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[2]','varchar(25)') AS 'Controller',
#ABB_S4_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[6]','varchar(25)') AS 'Category',
LTRIM(SUBSTRING(#ABB_S4_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[4]','varchar(500)'),7,500)) AS 'Message',
#ABB_S4_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[12]','varchar(500)') AS 'Cause',
#ABB_S4_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[16]','varchar(500)') AS 'Remedy',
REPLACE(REPLACE(#ABB_S4_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[5]','varchar(25)'),'(',''),')','') AS 'WnFiletime',
REPLACE(#ABB_S4_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[7]','varchar(25)'),' ())','') AS 'severity',
LTRIM(SUBSTRING(#ABB_S4_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[4]','varchar(500)'),1,6)) AS 'number'
FROM #ABB_S4_AE_datasplit
WHERE #ABB_S4_AE_datasplit.Message_Attr.value('/Product[1]/Attribute[2]','varchar(25)') LIKE @RobotFilterWild

ORDER BY _sqlTimestamp desc
END