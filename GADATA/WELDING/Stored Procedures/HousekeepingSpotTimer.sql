
-- ============================================= 
-- Author:   Coppejans Jens  
-- Create date:  
-- Description:   
-- ============================================= 
CREATE PROCEDURE [WELDING].[HousekeepingSpotTimer] 
AS 
  BEGIN 
      SET nocount ON; 

      DELETE FROM [WELDING].[factoryactualspotlist] 

      INSERT INTO [WELDING].[factoryactualspotlist] 
     
     
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
  [10.249.222.197\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
  [10.249.222.198\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
  [10.249.225.133\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
  [10.249.225.135\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
  [10.249.225.197\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
  [10.249.225.198\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
  [10.249.225.199\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
  [10.249.225.200\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
[10.249.226.5\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
[10.249.226.7\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
[10.249.226.8\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
[10.249.227.69\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
[10.249.240.10\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
[10.249.240.11\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
[10.249.240.12\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
[10.249.240.13\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
[10.249.240.14\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
  [19.148.180.141\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
  [19.148.180.149\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
  [19.148.180.162\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
  [19.148.180.203\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
  [19.148.180.227\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
[19.148.180.39\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
  [19.148.181.154\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
  [19.148.181.155\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
[19.148.181.53\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
     
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
[19.148.192.18\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
[19.148.192.33\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 
      UNION 
      SELECT DISTINCT timername COLLATE database_default, 
                      spotname COLLATE database_default, 
                      weldprogno 
      FROM 
[10.249.203.138\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extspottable_v] 

      ----Insert new timer---- 
      INSERT INTO dbo.timer 
                  ([name], 
                   [nptid], 
                   [robot]) 
      SELECT welding.factoryactualspotlist.timername, 
             NULL AS nptid, 
             NULL AS robot 
      FROM   welding.factoryactualspotlist 
             LEFT OUTER JOIN dbo.timer 
                          ON welding.factoryactualspotlist.timername = 
                             dbo.timer.NAME 
      WHERE  ( dbo.timer.NAME IS NULL ) 

      -- Insert New spots ---- 
      INSERT INTO dbo.spot 
                  (number, 
                   platecombinationtid, 
                   program, 
                   timerid, 
                   electrodedia) 
      SELECT welding.factoryactualspotlist.spotname, 
             2708         AS PLatecombi, 
             welding.factoryactualspotlist.weldprogram, 
             dbo.timer.id AS TimerID, 
             16           AS ElectrodeDia 
      FROM   dbo.timer 
             INNER JOIN welding.factoryactualspotlist 
                     ON dbo.timer.NAME = welding.factoryactualspotlist.timername 
             LEFT OUTER JOIN dbo.spot 
                          ON welding.factoryactualspotlist.spotname = 
                             dbo.spot.number 
      WHERE  ( dbo.spot.number IS NULL ) 

      ---UPDATE TimerID when spot is moved--- 
      UPDATE dbo.spot 
      SET    dbo.spot.timerid = dbo.timer.id, 
             dbo.spot.program = welding.factoryactualspotlist.weldprogram 
      --SELECT        WELDING.FactoryActualSpotList.SpotName, WELDING.FactoryActualSpotList.WeldProgram, dbo.Timer.ID AS TimerID
      FROM   dbo.timer 
             INNER JOIN welding.factoryactualspotlist 
                     ON dbo.timer.NAME = welding.factoryactualspotlist.timername 
             LEFT OUTER JOIN dbo.spot 
                             INNER JOIN dbo.timer AS Timer_1 
                                     ON dbo.spot.timerid = Timer_1.id 
                          ON welding.factoryactualspotlist.spotname = 
                             dbo.spot.number 
      WHERE  ( welding.factoryactualspotlist.weldprogram <> dbo.spot.program ) 
              OR ( welding.factoryactualspotlist.timername <> Timer_1.NAME ) 

      --- UPDATE Timers moved between NPT's ---- 
      --- UPDATE from NPT22 - NPT73 
      CREATE TABLE #temptable199 
        ( 
           timer  NCHAR(25), 
           server NCHAR(150) 
        ) 

      INSERT INTO #temptable199 
                  (timer, 
                   server) 
      ---NPT22--- 
      SELECT * 
      FROM   Openquery ([19.148.180.162\bos_sqlserv_2005], ' SELECT        timerName , ''19.148.180.162\BOS_SQLSERV_2005''  as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V] ') AS derivedtbl_1 
      UNION 
      ---NPT23--- 
      SELECT * 
      FROM   Openquery ([19.148.181.53\bos_sqlserv_2005], ' SELECT        timerName , ''19.148.181.53\BOS_SQLSERV_2005''  as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V] ') AS derivedtbl_1 
      UNION 
      ---NPT24--- 
      SELECT * 
      FROM   Openquery ([19.148.180.227\bos_sqlserv_2005], ' SELECT        timerName , ''19.148.180.227\BOS_SQLSERV_2005''  as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V] ') AS derivedtbl_1 
      UNION 
      ---NPT26--- 
      SELECT * 
      FROM   Openquery ([19.148.181.154\bos_sqlserv_2005], ' SELECT        timerName , ''19.148.181.154\BOS_SQLSERV_2005''  as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V] ') AS derivedtbl_1 
      UNION 
      ---NPT27--- 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([19.148.181.155\bos_sqlserv_2005], ' SELECT        timerName , ''19.148.181.155\BOS_SQLSERV_2005''  as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V] ') AS derivedtbl_1 
      UNION 
      ---NPT30--- 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([19.148.180.141\bos_sqlserv_2005], ' SELECT        timerName , ''19.148.180.141\BOS_SQLSERV_2005''  as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V] ')AS derivedtbl_1 
      UNION 
      ---NPT31--- 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([19.148.180.39\bos_sqlserv_2005], ' SELECT        timerName , ''19.148.180.39\BOS_SQLSERV_2005''as server   FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V] ')AS derivedtbl_1 
      UNION 
      ---NPT32--- 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([19.148.192.18\bos_sqlserv_2005], ' SELECT        timerName , ''19.148.192.18\BOS_SQLSERV_2005'' as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V] ')AS derivedtbl_1 
      UNION 
      ---NPT33--- 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([19.148.192.33\bos_sqlserv_2005], ' SELECT        timerName , ''19.148.192.33\BOS_SQLSERV_2005''  as server  FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V] ')AS derivedtbl_1 
      UNION 
      ---NPT40---- 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([10.249.240.10\bos_sqlserv_2005], ' SELECT        timerName , ''10.249.240.10\BOS_SQLSERV_2005''  as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V]  ')AS 
  derivedtbl_1 
      UNION 
      ---NPT41---- 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([10.249.240.11\bos_sqlserv_2005], ' SELECT        timerName , ''10.249.240.11\BOS_SQLSERV_2005''  as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V]  ')AS 
  derivedtbl_1 
      UNION 
      ---NPT42---- 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([10.249.240.12\bos_sqlserv_2005], ' SELECT        timerName , ''10.249.240.12\BOS_SQLSERV_2005'' as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V]  ')AS 
  derivedtbl_1 
      UNION 
      ---NPT43---- 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([10.249.240.13\bos_sqlserv_2005], ' SELECT        timerName , ''10.249.240.13\BOS_SQLSERV_2005''  as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V]  ')AS 
  derivedtbl_1 
      UNION 
      ---NPT50---- 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([10.249.225.199\bos_sqlserv_2005], ' SELECT        timerName , ''10.249.225.199\BOS_SQLSERV_2005'' as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V]  ')AS 
  derivedtbl_1 
      UNION 
      ---NPT51---- 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([10.249.225.197\bos_sqlserv_2005], ' SELECT        timerName , ''10.249.225.197\BOS_SQLSERV_2005'' as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V]  ')AS 
  derivedtbl_1 
      UNION 
      ---NPT52---- 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([10.249.225.198\bos_sqlserv_2005], ' SELECT        timerName , ''10.249.225.198\BOS_SQLSERV_2005'' as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V]  ')AS 
  derivedtbl_1 
      UNION 
      ---NPT53---- 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([10.249.240.14\bos_sqlserv_2005], ' SELECT        timerName , ''10.249.240.14\BOS_SQLSERV_2005''  as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V]  ')AS 
  derivedtbl_1 
      ---NPT54---- 
      UNION 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([10.249.225.200\bos_sqlserv_2005], ' SELECT        timerName , ''10.249.225.200\BOS_SQLSERV_2005'' as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V]  ')AS 
  derivedtbl_1 
      ---NPT55---- 
      UNION 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([10.249.226.5\bos_sqlserv_2005], ' SELECT        timerName, ''10.249.226.5\BOS_SQLSERV_2005''  as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V]  ')AS 
  derivedtbl_1 
      ---NPT56---- 
      UNION 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([10.249.225.133\bos_sqlserv_2005], ' SELECT        timerName , ''10.249.225.133\BOS_SQLSERV_2005'' as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V]  ')AS 
  derivedtbl_1 
      ---NPT57---- 
      UNION 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([10.249.203.138\bos_sqlserv_2005], ' SELECT        timerName, ''10.249.203.138\BOS_SQLSERV_2005'' as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V]  ')AS 
  derivedtbl_1 
      ---NPT58---- 
      UNION 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([10.249.226.7\bos_sqlserv_2005], ' SELECT        timerName , ''10.249.226.7\BOS_SQLSERV_2005''  as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V]  ')AS 
  derivedtbl_1 
      ---NPT59---- 
      UNION 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([10.249.226.8\bos_sqlserv_2005], ' SELECT        timerName , ''10.249.226.8\BOS_SQLSERV_2005'' as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V]  ')AS 
  derivedtbl_1 
      ---NPT70---- 
      UNION 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([10.249.227.69\bos_sqlserv_2005], ' SELECT        timerName , ''10.249.227.69\BOS_SQLSERV_2005''  as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V]  ')AS 
  derivedtbl_1 
      ---NPT71---- 
      UNION 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([10.249.222.197\bos_sqlserv_2005], ' SELECT        timerName , ''10.249.222.197\BOS_SQLSERV_2005''  as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V]  ')AS 
  derivedtbl_1 
      ---NPT72---- 
      UNION 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([10.249.225.135\bos_sqlserv_2005], ' SELECT        timerName , ''10.249.225.135\BOS_SQLSERV_2005'' as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V]  ')AS 
  derivedtbl_1 
      ---NPT73---- 
      UNION 
      SELECT derivedtbl_1.timername COLLATE database_default, 
             derivedtbl_1.server COLLATE database_default 
      FROM   Openquery ([10.249.222.198\bos_sqlserv_2005], ' SELECT        timerName , ''10.249.222.198\BOS_SQLSERV_2005'' as server FROM [BOS_6000_DB].[dbo].[Ext_CommunicationState_V]  ')AS 
  derivedtbl_1 

      ----SELECT * FROM #tempTable199 
      UPDATE dbo.timer 
      SET    dbo.timer.nptid = t1.id 
      FROM   dbo.npt 
             INNER JOIN dbo.timer 
                     ON dbo.npt.id = dbo.timer.nptid 
             RIGHT OUTER JOIN (SELECT #temptable199.timer, 
                                      #temptable199.server, 
                                      NPT_1.id 
                               FROM   #temptable199 
                                      INNER JOIN dbo.npt AS NPT_1 
                                              ON #temptable199.server = 
                                                 NPT_1.remoreserver) 
                                                                      AS t1 
                           ON dbo.timer.NAME = t1.timer 

      DROP TABLE #temptable199 
  END