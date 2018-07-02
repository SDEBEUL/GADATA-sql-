
-- ============================================= 
-- Author:    Coppejans Jens 
-- Create date: 23/12/2017 
-- Description:  Insert all NPT timerfaults 
-- ============================================= 
CREATE PROCEDURE [WELDING].[TimerFaults] 
AS 
  BEGIN TRY
      -- SET NOCOUNT ON added to prevent extra result sets from 
      -- interfering with SELECT statements. 
      SET nocount ON; 




---Y555 & ---V316

--NPT22

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([19.148.180.162\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT23

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([19.148.181.53\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 
  AND TimerFaults.DateTime <> '1980-01-01 00:00:00.000'

--NPT24

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([19.148.180.227\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT26

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([19.148.181.154\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT27

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([19.148.181.155\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT28

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([19.148.180.141\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT29

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([19.148.180.149\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT30

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([19.148.180.203\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT31

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([19.148.180.39\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT32

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([19.148.192.18\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT33

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([19.148.192.33\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

---Greenfield

--NPT40

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])

SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([10.249.240.10\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT41

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([10.249.240.11\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT42

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([10.249.240.12\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT43

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([10.249.240.13\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 
--NPT50

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([10.249.225.199\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT51

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([10.249.225.197\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT52

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([10.249.225.198\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT53

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([10.249.240.14\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT54

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([10.249.225.200\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT55

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([10.249.226.5\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT56

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([10.249.225.133\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT57

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([10.249.203.138\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT58

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([10.249.226.7\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT59

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([10.249.226.8\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT70

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([10.249.227.69\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT71

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([10.249.222.197\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT72

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([10.249.225.135\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

--NPT73

INSERT INTO dbo.WeldFaultLog ([DateTime]
, [SpotID]
, [WeldFaultID]
, [WeldSubFaultID]
, [Wear]
, [Filter]
, [WeldMasterComment])


SELECT distinct     TimerFaults.dateTime, dbo.Spot.ID AS spotid, dbo.WeldFaultName.ID AS weldfaultid, dbo.WeldSubFaultName.id as subfaultid, '1' as wear, 1 AS filter,
null as WeldMasterComment
FROM            OPENQUERY([10.249.222.198\bos_sqlserv_2005], 
                         '  SELECT        dateTime, timerName AS Timer, progNo AS program, spotName AS Spot, monitorState_txt AS TimerFault,  ''1'', [measureState_txt]  FROM            dbo.ExtWeldFaultProt_V ')
                          AS TimerFaults INNER JOIN
                         dbo.Timer ON TimerFaults.Timer collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.Spot ON TimerFaults.program = dbo.Spot.Program AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultName ON TimerFaults.TimerFault collate database_default = dbo.WeldFaultName.WeldFaultName inner join
                         dbo.WeldSubFaultName  ON TimerFaults.measureState_txt collate database_default = dbo.WeldSubFaultName.WeldSubFaultName LEFT OUTER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND TimerFaults.dateTime = dbo.WeldFaultLog.DateTime
						WHERE        (dbo.WeldFaultLog.DateTime IS NULL) 

------------------Make TOP10 Weldfaults GA & insert into T10 Table------------------------- 
-----DELETE TOP10 Table------ 
----Insert new TOP10------- 
--DELETE FROM [WELDING].[top10timerfaultslast24h]

--INSERT INTO [WELDING].[top10timerfaultslast24h] ([npt],
--[timer],
--[timerfault],
--[count of timerfaults],
--[weldingmaster action])
--  SELECT TOP (10)
 --   dbo.npt.NAME AS NPT,
 --   welding.weldfaults.timer,
 --   welding.weldfaults.timerfault,
 --   COUNT(welding.weldfaults.timerfault) AS
 --   [Aantal TimerFaults],
 --   welding.weldfaults.weldmastercomment
 -- FROM dbo.npt
 -- INNER JOIN dbo.users
 --   ON dbo.npt.ownerid = dbo.users.id
 -- LEFT OUTER JOIN dbo.timer
 --   ON dbo.npt.id = dbo.timer.nptid
  --  AND dbo.npt.id = dbo.timer.nptid
  --  AND dbo.npt.id = dbo.timer.nptid
  --RIGHT OUTER JOIN welding.weldfaults
  --  ON dbo.timer.NAME = welding.weldfaults.timer
  --WHERE (welding.weldfaults.datetime >= GETDATE() - 1)
  --GROUP BY welding.weldfaults.timer,
  --         dbo.npt.NAME,
   --        welding.weldfaults.timerfault,
   --        welding.weldfaults.weldmastercomment
  --ORDER BY [aantal timerfaults] DESC
  END TRY

  BEGIN CATCH

  INSERT INTO [WELDING].[ErrorHandling]([procedure]
      ,[ErrorNumber]
      ,[ErrorSeverity]
      ,[ErrorState]
      ,[ErrorLine]
      ,[ErrorMessage]
	  ,[timestamp])

  SELECT 
    '[WELDING].[TimerFaults]_fault_catch'
    ,ERROR_NUMBER() AS ErrorNumber  
    ,ERROR_SEVERITY() AS ErrorSeverity  
    ,ERROR_STATE() AS ErrorState  
    ,ERROR_LINE() AS ErrorLine  
    ,ERROR_MESSAGE() AS ErrorMessage
	,GETDATE();  

 END CATCH