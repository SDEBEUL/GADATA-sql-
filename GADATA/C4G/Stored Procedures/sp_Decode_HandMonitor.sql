CREATE PROCEDURE [C4G].[sp_Decode_HandMonitor]

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
Print '--Running [C4G].[sp_Decode_HandMonitor]'
print '--*****************************************************************************--'
Print'-- table splitting'
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#C4G_Rt_value_Handmonitor') is not null) drop table #C4G_Rt_value_Handmonitor
SELECT
id, 
controller_id,   
_timestamp as '_timestamp',   --switched to sql server time 
Value,
CONVERT(XML,'<Product><Attribute>' + REPLACE([ABB].[fnStripLowAscii](Value),' ', '</Attribute><Attribute>') + '</Attribute></Product>') AS Message_Attr 
INTO #C4G_Rt_value_Handmonitor
FROM gadata.c4g.rt_handData
WHERE rt_handData.variable_id = 58 AND len(value) <> 0 --drops empty records
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
Print'--push read data to readable table'
---------------------------------------------------------------------------------------
--!!!!only use to rebluid table--

if (OBJECT_ID('Gadata.c4g.L_HandMonitor') is not null) 
drop table Gadata.c4g.L_HandMonitor
CREATE TABLE Gadata.c4g.L_HandMonitor(
	[id] [int] IDENTITY(1,1) NOT NULL,
	[_timestamp] [datetime] NULL,
	[Controller_id] [Int] NULL,
	[Type] [varchar](25) NULL,
    [Grip] [tinyint]  NULL,
	[Seq] [tinyint] NULL,
	[Time] [int] NULL,
) ON [PRIMARY]

--SET IDENTITY_INSERT Gadata.c4g.L_HandMonitor OFF;
--!!!!only use to rebluid table--

INSERT into Gadata.c4g.L_HandMonitor
--(id,_timestamp,Type,Controller,Category,Message,Cause,Remedy,WnFiletime,severity,number)
SELECT 
CONVERT(datetime, l._timestamp ) as '_timestamp',
l.controller_id,   
l.Message_Attr.value('/Product[1]/Attribute[1]','varchar(25)') AS 'Type',
l.Message_Attr.value('/Product[1]/Attribute[4]','varchar(25)') AS 'Grip',
l.Message_Attr.value('/Product[1]/Attribute[7]','varchar(25)') AS 'Seq',
l.Message_Attr.value('/Product[1]/Attribute[10]','varchar(25)') AS 'Time'
FROM #C4G_Rt_value_Handmonitor as l
Order by L._timestamp desc 
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
Print'--clear read data from rt_value table'
---------------------------------------------------------------------------------------
--DELETE FROM gadata.dbo.rt_message where gadata.dbo.rt_message.id <= (select max(#ABB_AE_datasplit.id) from #ABB_AE_datasplit)
---------------------------------------------------------------------------------------
END