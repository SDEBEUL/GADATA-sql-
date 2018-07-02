
-- ============================================= 
-- Author:     Coppejans Jens
-- Create date:  
-- Description:   
-- ============================================= 
CREATE PROCEDURE [UL].[spotIdentImport] 


AS 
  BEGIN 

      SET nocount ON; 


--NPT22

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.180.162\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.180.162\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.180.162\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT23

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.181.53\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.181.53\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.181.53\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT24

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.180.227\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.180.227\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.180.227\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)


--NPT26 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.181.154\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.181.154\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.181.154\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT27 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.181.155\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.181.155\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.181.155\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT28


INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.180.141\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.180.141\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.180.141\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT29

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.180.149\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.180.149\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.180.149\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT30 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.180.203\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.180.203\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.180.203\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT31 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.180.39\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.180.39\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.180.39\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT32 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.192.18\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.192.18\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.192.18\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT33 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.192.33\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.192.33\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([19.148.192.33\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)



--NPT40 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.240.10\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.240.10\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.240.10\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT41 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.240.11\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.240.11\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.240.11\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT43 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.240.13\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.240.13\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.240.13\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT50 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.225.199\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.225.199\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.225.199\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT51 
 
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.225.197\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.225.197\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.225.197\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT52

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.225.198\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.225.198\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.225.198\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT53 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.240.14\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.240.14\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.240.14\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT54

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.225.200\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.225.200\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.225.200\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT55

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.226.5\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.226.5\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.226.5\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT56 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.225.133\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.225.133\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.225.133\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT57 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.203.138\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.203.138\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.203.138\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT58 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.226.7\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.226.7\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.226.7\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)


--NPT59 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.226.8\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.226.8\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.226.8\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT70 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.227.69\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.227.69\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.227.69\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

 
--NPT71 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.222.197\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.222.197\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.222.197\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT72 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.225.135\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.225.135\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.225.135\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)

--NPT73 

INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.222.198\BOS_SQLSERV_2005], 
                  '
SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotIdent AND tbl.spotname = dbo.Inspectionplan.SpotIdent LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.222.198\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotBefore AND tbl.spotname = dbo.Inspectionplan.spotbefore LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
INSERT INTO  ul.spotidentmeasurements (timestamp, spotid)
SELECT DISTINCT tbl.datetime,spotname
FROM     OPENQUERY([10.249.222.198\BOS_SQLSERV_2005], 
                  '
				  SELECT datetime, spotname
                  FROM      dbo.extweldmeasureprotddw_v  where datetime >= dateadd(hour,-1,GETDATE())
                  ') AS tbl INNER JOIN
                  dbo.Inspectionplan ON tbl.spotname = dbo.Inspectionplan.SpotAfter AND tbl.spotname = dbo.Inspectionplan.SpotAfter LEFT OUTER JOIN
                  UL.SpotIdentMeasurements ON tbl.datetime = UL.SpotIdentMeasurements.timestamp
WHERE  (UL.SpotIdentMeasurements.timestamp IS NULL)
end