CREATE PROCEDURE [ABB].[sp_Decode_AE_S4]

AS
--USE GADATA
---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------
BEGIN
---------------------------------------------------------------------------------------
print '--*****************************************************************************--'
Print '--Running ABB.sp_Decode_AE_S4'
print '--*****************************************************************************--'
Print'--Live table splitting'
---------------------------------------------------------------------------------------

if (OBJECT_ID('tempdb..#ABB_AE_S4_datasplit') is not null) drop table #ABB_AE_S4_datasplit 
SELECT 
id,     
sqlTimestamp as _timestamp, --use sql server time      
_message, 
'S4C' as 'Type', 
CONVERT(XML,'<Product><Attribute>' + REPLACE([ABB].[fnStripLowAscii](_message),'"', '</Attribute><Attribute>') + '</Attribute></Product>') AS Message_Attr  
INTO #ABB_AE_S4_datasplit 
FROM gadata.dbo.rt_message_ABB_S4
WHERE len(_message) <> 0 --drops empty records 
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
Print'--push read data to readable table'
---------------------------------------------------------------------------------------
--!!!!only use to rebluid table--
/*
if (OBJECT_ID('Gadata.abb.rt_alarm_S4') is not null) 
drop table abb.[rt_alarm_S4]
CREATE TABLE [ABB].[rt_alarm_S4](
	[key] [int] IDENTITY(1,1) NOT NULL,
	[id] [int]  NULL,
	[_timestamp] [datetime] NULL,
	[Type] [varchar](4) NOT NULL,
	[Controller] [varchar](25) NULL,
	[Category] [varchar](25) NULL,
	[Message] [varchar](500) NULL,
	[Cause] [varchar](500) NULL,
	[Remedy] [varchar](500) NULL,
	[WnFiletime] [varchar](50) NULL,
	[severity] [varchar](8000) NULL,
	[number] [varchar](8000) NULL
) ON [PRIMARY]
*/
--!!!!only use to rebluid table--

INSERT into GADATA.abb.rt_alarm_S4
(id,_timestamp,Type,Controller,Category,Message,Cause,Remedy,WnFiletime,severity,number)
SELECT 
s.id,
s._Timestamp,  
s.Type, 
s.Message_Attr.value('/Product[1]/Attribute[2]','varchar(25)') AS 'Controller', 
s.Message_Attr.value('/Product[1]/Attribute[6]','varchar(25)') AS 'Category', 
LTRIM(SUBSTRING(s.Message_Attr.value('/Product[1]/Attribute[4]','varchar(500)'),7,500)) AS 'Message', 
s.Message_Attr.value('/Product[1]/Attribute[12]','varchar(500)') AS 'Cause', 
s.Message_Attr.value('/Product[1]/Attribute[16]','varchar(500)') AS 'Remedy', 
REPLACE(REPLACE(s.Message_Attr.value('/Product[1]/Attribute[5]','varchar(25)'),'(',''),')','') AS 'WnFiletime', 
REPLACE(s.Message_Attr.value('/Product[1]/Attribute[7]','varchar(25)'),' ())','') AS 'severity', 
LTRIM(SUBSTRING(s.Message_Attr.value('/Product[1]/Attribute[4]','varchar(500)'),1,6)) AS 'number' 
FROM #ABB_AE_S4_datasplit AS S  
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
Print'--clear read data from livestream table'
---------------------------------------------------------------------------------------
DELETE FROM gadata.dbo.rt_message_ABB_S4 where gadata.dbo.rt_message_ABB_S4.id <= (select max(#ABB_AE_S4_datasplit.id) from #ABB_AE_S4_datasplit)
---------------------------------------------------------------------------------------

END