
-- ============================================= 
-- Author:    Coppejans Jens 
-- Create date:  
-- Description:   
-- ============================================= 
CREATE PROCEDURE [WELDING].[WeldingMeasurements] 
-- Add the parameters for the stored procedure here 
AS 
  BEGIN 
      SET nocount ON; 

      ------ Import all Nut and bolt weldmeasurement data from welding timers---- 
      ---nut/bold on NPT42 
      ---NPT42 binnehalen nut-bolt measurements 
      INSERT INTO [GADATA].[WELDING].[nut_boltweldmeasurements] 
                  ([timestamp], 
                   [timerid], 
                   [spotid], 
                   [wear], 
                   [i_demand], 
                   [i_actual], 
                   [regulation], 
                   [bodynr], 
                   [electrodenr], 
                   [weldtime], 
                   [energyactual], 
                   [energyref], 
                   [resistanceactual], 
                   [resistanceref], 
                   [expulsiontime]) 
      SELECT derivedtbl_1.datetime, 
             dbo.timer.id AS timerID, 
             dbo.spot.id  AS spotID, 
             derivedtbl_1.wear, 
             derivedtbl_1.idemand2, 
             derivedtbl_1.iactual2, 
             derivedtbl_1.regulation2_txt, 
             derivedtbl_1.partidentstring, 
             derivedtbl_1.electrodeno, 
             derivedtbl_1.weldtimeactualvalue, 
             derivedtbl_1.energyactualvalue, 
             derivedtbl_1.energyrefvalue, 
             derivedtbl_1.resistanceactualvalue, 
             derivedtbl_1.resistancerefvalue, 
             derivedtbl_1.uirexpulsiontime 
      FROM   dbo.timer 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
             INNER JOIN Openquery([10.249.240.12\bos_sqlserv_2005], '                            SELECT *   FROM [BOS_6000_DB].[dbo].[ExtWeldMeasureProtDDW_V] ') AS 
  derivedtbl_1 
               ON dbo.spot.program = derivedtbl_1.progno 
                  AND dbo.timer.NAME = derivedtbl_1.timername COLLATE 
                                       database_default 
       LEFT OUTER JOIN welding.nut_boltweldmeasurements 
                    ON derivedtbl_1.datetime = 
                       welding.nut_boltweldmeasurements.timestamp 
      WHERE  ( welding.nut_boltweldmeasurements.timestamp IS NULL ) 
      ORDER  BY derivedtbl_1.datetime ASC 

      ---NPT43 binnehalen nut-bolt measurements 326051WN01 
      INSERT INTO [GADATA].[WELDING].[nut_boltweldmeasurements] 
                  ([timestamp], 
                   [timerid], 
                   [spotid], 
                   [wear], 
                   [i_demand], 
                   [i_actual], 
                   [regulation], 
                   [bodynr], 
                   [electrodenr], 
                   [weldtime], 
                   [energyactual], 
                   [energyref], 
                   [resistanceactual], 
                   [resistanceref], 
                   [expulsiontime]) 
      SELECT derivedtbl_1.datetime, 
             dbo.timer.id AS timerID, 
             dbo.spot.id  AS spotID, 
             derivedtbl_1.wear, 
             derivedtbl_1.idemand2, 
             derivedtbl_1.iactual2, 
             derivedtbl_1.regulation2_txt, 
             derivedtbl_1.partidentstring, 
             derivedtbl_1.electrodeno, 
             derivedtbl_1.weldtimeactualvalue, 
             derivedtbl_1.energyactualvalue, 
             derivedtbl_1.energyrefvalue, 
             derivedtbl_1.resistanceactualvalue, 
             derivedtbl_1.resistancerefvalue, 
             derivedtbl_1.uirexpulsiontime 
      FROM   dbo.timer 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
             INNER JOIN Openquery([10.249.240.13\bos_sqlserv_2005], '                            SELECT *   FROM [BOS_6000_DB].[dbo].[ExtWeldMeasureProtDDW_V] WHERE timerName = ''326051WN01'' ') AS 
  derivedtbl_1 
               ON dbo.spot.program = derivedtbl_1.progno 
                  AND dbo.timer.NAME = derivedtbl_1.timername COLLATE 
                                       database_default 
       LEFT OUTER JOIN welding.nut_boltweldmeasurements 
                    ON derivedtbl_1.datetime = 
                       welding.nut_boltweldmeasurements.timestamp 
      WHERE  ( welding.nut_boltweldmeasurements.timestamp IS NULL ) 
      ORDER  BY derivedtbl_1.datetime 

      ------Data from 321010WT03 nutID 4492014---- 
      INSERT INTO [GADATA].[WELDING].[nut_boltweldmeasurements] 
                  ([timestamp], 
                   [timerid], 
                   [spotid], 
                   [wear], 
                   [i_demand], 
                   [i_actual], 
                   [regulation], 
                   [bodynr], 
                   [electrodenr], 
                   [weldtime], 
                   [energyactual], 
                   [energyref], 
                   [resistanceactual], 
                   [resistanceref], 
                   [expulsiontime]) 
      SELECT derivedtbl_1.datetime, 
             dbo.timer.id AS timerID, 
             dbo.spot.id  AS spotID, 
             derivedtbl_1.wear, 
             derivedtbl_1.idemand2, 
             derivedtbl_1.iactual2, 
             derivedtbl_1.regulation2_txt, 
             derivedtbl_1.partidentstring, 
             derivedtbl_1.electrodeno, 
             derivedtbl_1.weldtimeactualvalue, 
             derivedtbl_1.energyactualvalue, 
             derivedtbl_1.energyrefvalue, 
             derivedtbl_1.resistanceactualvalue, 
             derivedtbl_1.resistancerefvalue, 
             derivedtbl_1.uirexpulsiontime 
      FROM   dbo.timer 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
             INNER JOIN Openquery([10.249.240.10\bos_sqlserv_2005], '                            SELECT *   FROM [BOS_6000_DB].[dbo].[ExtWeldMeasureProtDDW_V] WHERE timerName = ''321010WT03'' ') AS 
  derivedtbl_1 
               ON dbo.spot.program = derivedtbl_1.progno 
                  AND dbo.timer.NAME = derivedtbl_1.timername COLLATE 
                                       database_default 
       LEFT OUTER JOIN welding.nut_boltweldmeasurements 
                    ON derivedtbl_1.datetime = 
                       welding.nut_boltweldmeasurements.timestamp 
      WHERE  ( welding.nut_boltweldmeasurements.timestamp IS NULL ) 
             AND ( dbo.spot.number = 4492014 ) 
      ORDER  BY derivedtbl_1.datetime 

      -----326060WN01A binnehalen welddata---- 
      INSERT INTO [GADATA].[WELDING].[nut_boltweldmeasurements] 
                  ([timestamp], 
                   [timerid], 
                   [spotid], 
                   [wear], 
                   [i_demand], 
                   [i_actual], 
                   [regulation], 
                   [bodynr], 
                   [electrodenr], 
                   [weldtime], 
                   [energyactual], 
                   [energyref], 
                   [resistanceactual], 
                   [resistanceref], 
                   [expulsiontime]) 
      SELECT derivedtbl_1.datetime, 
             dbo.timer.id AS timerID, 
             dbo.spot.id  AS spotID, 
             derivedtbl_1.wear, 
             derivedtbl_1.idemand2, 
             derivedtbl_1.iactual2, 
             derivedtbl_1.regulation2_txt, 
             derivedtbl_1.partidentstring, 
             derivedtbl_1.electrodeno, 
             derivedtbl_1.weldtimeactualvalue, 
             derivedtbl_1.energyactualvalue, 
             derivedtbl_1.energyrefvalue, 
             derivedtbl_1.resistanceactualvalue, 
             derivedtbl_1.resistancerefvalue, 
             derivedtbl_1.uirexpulsiontime 
      FROM   dbo.timer 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
             INNER JOIN Openquery([10.249.240.13\bos_sqlserv_2005], '                            SELECT *   FROM [BOS_6000_DB].[dbo].[ExtWeldMeasureProtDDW_V] WHERE timername = ''326060WT01'' ') AS 
  derivedtbl_1 
               ON dbo.spot.program = derivedtbl_1.progno 
                  AND dbo.timer.NAME = derivedtbl_1.timername COLLATE 
                                       database_default 
       LEFT OUTER JOIN welding.nut_boltweldmeasurements 
                    ON derivedtbl_1.datetime = 
                       welding.nut_boltweldmeasurements.timestamp 
      WHERE  ( welding.nut_boltweldmeasurements.timestamp IS NULL ) 
             AND ( dbo.spot.number = 4491165 ) 
              OR ( welding.nut_boltweldmeasurements.timestamp IS NULL ) 
                 AND ( dbo.spot.number = 4491168 ) 
      ORDER  BY derivedtbl_1.datetime 

      ----326100WN01A--- 
      INSERT INTO [GADATA].[WELDING].[nut_boltweldmeasurements] 
                  ([timestamp], 
                   [timerid], 
                   [spotid], 
                   [wear], 
                   [i_demand], 
                   [i_actual], 
                   [regulation], 
                   [bodynr], 
                   [electrodenr], 
                   [weldtime], 
                   [energyactual], 
                   [energyref], 
                   [resistanceactual], 
                   [resistanceref], 
                   [expulsiontime]) 
      SELECT derivedtbl_1.datetime, 
             dbo.timer.id AS timerID, 
             dbo.spot.id  AS spotID, 
             derivedtbl_1.wear, 
             derivedtbl_1.idemand2, 
             derivedtbl_1.iactual2, 
             derivedtbl_1.regulation2_txt, 
             derivedtbl_1.partidentstring, 
             derivedtbl_1.electrodeno, 
             derivedtbl_1.weldtimeactualvalue, 
             derivedtbl_1.energyactualvalue, 
             derivedtbl_1.energyrefvalue, 
             derivedtbl_1.resistanceactualvalue, 
             derivedtbl_1.resistancerefvalue, 
             derivedtbl_1.uirexpulsiontime 
      FROM   dbo.timer 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
             INNER JOIN Openquery([10.249.240.10\bos_sqlserv_2005], '                            SELECT *   FROM [BOS_6000_DB].[dbo].[ExtWeldMeasureProtDDW_V] WHERE timerName = ''326100WT01'' ') AS 
  derivedtbl_1 
               ON dbo.spot.program = derivedtbl_1.progno 
                  AND dbo.timer.NAME = derivedtbl_1.timername COLLATE 
                                       database_default 
       LEFT OUTER JOIN welding.nut_boltweldmeasurements 
                    ON derivedtbl_1.datetime = 
                       welding.nut_boltweldmeasurements.timestamp 
      WHERE  ( welding.nut_boltweldmeasurements.timestamp IS NULL ) 
             AND ( dbo.spot.number = 4491160 ) 
              OR ( welding.nut_boltweldmeasurements.timestamp IS NULL ) 
                 AND ( dbo.spot.number = 4491161 ) 
              OR ( welding.nut_boltweldmeasurements.timestamp IS NULL ) 
                 AND ( dbo.spot.number = 4491162 ) 
      ORDER  BY derivedtbl_1.datetime 

      -------------------------------------------------------------------------------------------- 
      --DELETE records older than 1 year
      DELETE FROM welding.nut_boltweldmeasurements 
      WHERE  timestamp < Dateadd(day, -365, Getdate()) 
  END