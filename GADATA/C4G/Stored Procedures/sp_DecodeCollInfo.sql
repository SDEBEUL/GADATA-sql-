CREATE PROCEDURE [C4g].[sp_DecodeCollInfo]
@Robotname as varchar(25) = '%%'
AS

if (OBJECT_ID('tempdb..#CollInfosplit') is not null) drop table #CollInfosplit
SELECT TOP 100000
       [Location]
      ,[Robotname]
      ,[Type]
	  ,[Timestamp]
      ,[Year]
      ,[Week]
      ,[Day]
      ,[Shift]
      ,CONVERT(XML,'<Product><Attribute>' + REPLACE([Logtekst],':', '</Attribute><Attribute>') + '</Attribute></Product>') AS VA 
INTO #CollInfosplit
  FROM [GADATA].[C4G].[CollisionInfo] 
WHERE 
	Robotname LIKE @Robotname
	AND Logtekst NOT LIKE '%COLD MODE%' 
	AND Logtekst IS NOT NULL
ORDER BY Timestamp DESC 

SELECT
       [Location]
      ,[Robotname]
      ,[Type]
	  ,Timestamp
	  ,LEFT(VA.value('/Product[1]/Attribute[2]','varchar(25)'), LEN(VA.value('/Product[1]/Attribute[2]','varchar(25)'))-4) AS 'Zone'
	  ,LEFT(VA.value('/Product[1]/Attribute[3]','varchar(25)'), LEN(VA.value('/Product[1]/Attribute[3]','varchar(25)'))-1) AS 'Prog'
	  ,LEFT(VA.value('/Product[1]/Attribute[5]','varchar(25)'), LEN(VA.value('/Product[1]/Attribute[5]','varchar(25)'))-1) AS 'Rout'
	  ,LEFT(VA.value('/Product[1]/Attribute[6]','varchar(25)'), LEN(VA.value('/Product[1]/Attribute[6]','varchar(25)'))-1) AS 'Line'
	  ,LEFT(VA.value('/Product[1]/Attribute[8]','varchar(25)'), LEN(VA.value('/Product[1]/Attribute[8]','varchar(25)'))-1) AS 'Mode'
	  ,VA.value('/Product[1]/Attribute[9]','varchar(25)') AS 'Safety'
      ,[Year]
      ,[Week]
      ,[Day]
      ,[Shift]     
FROM #CollInfosplit as s


ORDER BY timestamp DESC