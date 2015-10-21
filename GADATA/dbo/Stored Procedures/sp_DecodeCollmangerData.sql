CREATE PROCEDURE [dbo].[sp_DecodeCollmangerData]
@Robotname as varchar(25) = '%29010R11%'
AS

if (OBJECT_ID('tempdb..#Colldatasplit') is not null) drop table #Colldatasplit
SELECT TOP 10000
rt_collLog.id,
controller_name,    
_timestamp,    
value,    
CONVERT(XML,'<Product><Attribute>' + REPLACE(value,',', '</Attribute><Attribute>') + '</Attribute></Product>') AS Value_Attributes 
INTO #Colldatasplit
FROM GADATA.C4G.rt_collLog
	Join c4g.c_controller on C_controller.id = rt_collLog.controller_id 
WHERE 
	variable_id = 55
	AND 
	c_controller.controller_name LIKE @Robotname
ORDER BY _timestamp DESC 

SELECT     
#Colldatasplit.controller_name,    
#Colldatasplit._timestamp,    
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[1]','int') AS 'Cycle',
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[25]','varchar(25)') AS 'Owner',
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[24]','varchar(25)') AS 'Zone',
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[2]','int') AS 'Zt',

--detected levels axis per axis 
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[3]','int') AS 'CD1',
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[4]','int') AS 'CD2',  
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[5]','int') AS 'CD3',    
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[6]','int') AS 'CD4',
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[7]','int') AS 'CD5',
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[8]','int') AS 'CD6',

--detected setpoint axis per axis
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[10]','int') AS 'CC1', 
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[11]','int') AS 'CC2',    
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[12]','int') AS 'CC3',
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[13]','int') AS 'CC4',
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[14]','int') AS 'CC5',
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[15]','int') AS 'CC6',
--active sensitiviy axis per axis 
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[17]','int') AS 'CA1', 
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[18]','int') AS 'CA2',    
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[19]','int') AS 'CA3',
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[20]','int') AS 'CA4',
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[21]','int') AS 'CA5',
#Colldatasplit.Value_Attributes.value('/Product[1]/Attribute[22]','int') AS 'CA6'

FROM #Colldatasplit


ORDER BY _timestamp DESC