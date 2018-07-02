
-- ============================================= 
-- Author:    coppejans jens 
-- Create date: 22/12/2017 
-- Description:  Datachanges 
-- ============================================= 
CREATE PROCEDURE [WELDING].[Datachange] 
AS 
  BEGIN try
      SET nocount ON; 

---------------------------------------------------Y555-----------------------------V316----------------------------------------------------------------------------------------------

----------------------------------------------------------------------NPT22-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([19.148.180.162\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([19.148.180.162\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)


----------------------------------------------------------------------NPT23-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([19.148.181.53\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([19.148.181.53\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT24-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([19.148.180.227\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([19.148.180.227\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT26-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([19.148.181.154\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([19.148.181.154\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT27-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([19.148.181.155\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([19.148.181.155\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT28-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([19.148.180.141\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([19.148.180.141\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT29-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([19.148.180.149\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([19.148.180.149\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT30-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([19.148.180.203\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([19.148.180.203\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT31-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([19.148.180.39\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([19.148.180.39\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT32-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([19.148.192.18\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([19.148.192.18\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT33-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([19.148.192.33\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([19.148.192.33\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT40-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------greenfield--------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([10.249.240.10\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([10.249.240.10\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT41-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------greenfield--------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([10.249.240.11\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([10.249.240.11\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT42-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------greenfield--------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([10.249.240.12\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([10.249.240.12\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT43-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------greenfield--------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([10.249.240.13\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([10.249.240.13\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT50-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------greenfield--------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([10.249.225.199\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([10.249.225.199\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT51-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------greenfield--------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([10.249.225.197\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([10.249.225.197\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT52-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------greenfield--------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([10.249.225.198\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([10.249.225.198\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)


----------------------------------------------------------------------NPT53-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------greenfield--------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([10.249.240.14\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([10.249.240.14\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT54-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------greenfield--------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([10.249.225.200\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([10.249.225.200\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT55-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------greenfield--------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([10.249.226.5\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([10.249.226.5\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT56-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------greenfield--------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([10.249.225.133\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([10.249.225.133\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT57-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------greenfield--------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([10.249.203.138\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([10.249.203.138\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT58-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------greenfield--------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([10.249.226.7\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([10.249.226.7\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT59-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------greenfield--------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([10.249.226.8\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([10.249.226.8\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT70-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------greenfield--------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([10.249.227.69\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([10.249.227.69\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT71-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------greenfield--------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([10.249.222.197\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([10.249.222.197\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT72-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------greenfield--------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([10.249.225.135\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([10.249.225.135\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

----------------------------------------------------------------------NPT73-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------greenfield--------------------------------------------------------------------------------------------------------

INSERT INTO dbo.spotdatachange ( [SpotID] ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID])
--insert spotdatachange -- spot niveau---
SELECT DISTINCT 
                         dbo.Spot.ID AS spotid, Datachange.Timestamp, dbo.TimerParameterName.ID, Datachange.oldValue_txt, Datachange.newValue_txt, dbo.Users.ID AS [user id]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         OPENQUERY([10.249.222.198\bos_sqlserv_2005], 
                         '                  SELECT        CONVERT(Datetime, dateTime, 120) AS Timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange ON dbo.Spot.Program = Datachange.subIndex AND dbo.Timer.Name = Datachange.timerName collate database_default INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.spotdatachange AS spotdatachange_1 ON Datachange.Timestamp = spotdatachange_1.DateTime
WHERE        (Datachange.Timestamp >= GETDATE() - 1) AND (dbo.TimerParameterName.IsElectrodeData IS NULL) AND (spotdatachange_1.DateTime IS NULL)

--insert TimerDAtachange  - Timer Niveau---
insert into dbo.timerdatachange ( [TimerID]  ,[DateTime] ,[ParameterID] ,[OldValue] ,[NewValue] ,[UserID] ,[Electrode])

SELECT DISTINCT 
                         dbo.Timer.ID, Datachange.Timestamp, dbo.TimerParameterName.ID AS timerparmameterid, Datachange.oldValue_txt, 
                         Datachange.NewValue_txt, dbo.Users.ID AS userid, NULL AS electrode
FROM            OPENQUERY([10.249.222.198\bos_sqlserv_2005], 
                         '                  SELECT        datetime as timestamp, timerName, param_status_txt, subIndex, oldValue_txt, newValue_txt, userName,param_id                 FROM            dbo.ExtDataChangeProt_V WHERE param_id <> ''116'' 
						     ')
                          AS Datachange INNER JOIN
                         dbo.Timer ON Datachange.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameterName ON Datachange.param_id = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Users ON Datachange.userName collate database_default = dbo.Users.CDSID LEFT OUTER JOIN
                         dbo.timerdatachange ON Datachange.Timestamp = dbo.timerdatachange.DateTime
WHERE        (dbo.timerdatachange.DateTime IS NULL) AND (Datachange.Timestamp >=GETDATE()-1) AND (dbo.TimerParameterName.IsElectrodeData = 1)

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
    '[WELDING].[Datachange]_fault_catch'
    ,ERROR_NUMBER() AS ErrorNumber  
    ,ERROR_SEVERITY() AS ErrorSeverity  
    ,ERROR_STATE() AS ErrorState  
    ,ERROR_LINE() AS ErrorLine  
    ,ERROR_MESSAGE() AS ErrorMessage
	,GETDATE();  

 END CATCH