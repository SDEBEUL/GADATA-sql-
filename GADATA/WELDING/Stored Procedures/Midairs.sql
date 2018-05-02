
-- ============================================= 
-- Author:    Coppejans Jens 
-- Create date:  
-- Description:   
-- ============================================= 
CREATE PROCEDURE [WELDING].[Midairs] 
AS 
  BEGIN 
      SET nocount ON; 

      --------------Midair Measurements Brownfield------------------------ 
      --NPT22 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([19.148.180.162\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        progNo BETWEEN 250 AND 254 ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      --NPT23 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([19.148.181.53\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        progNo BETWEEN 250 AND 254 ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      --NPT24 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([19.148.180.227\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        progNo BETWEEN 250 AND 254 ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      --NPT26 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([19.148.181.154\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        progNo BETWEEN 250 AND 254 ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      --NPT27 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([19.148.181.155\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        progNo BETWEEN 250 AND 254 ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      --NPT28 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([19.148.180.141\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        progNo BETWEEN 250 AND 254 ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      --NPT29 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([19.148.180.149\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        progNo BETWEEN 250 AND 254 ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      --NPT30 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([19.148.180.203\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        progNo BETWEEN 250 AND 254 ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      --NPT31 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([19.148.180.39\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        progNo BETWEEN 250 AND 254 ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      --NPT32 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([19.148.192.18\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        progNo BETWEEN 250 AND 254 ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      --NPT33 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([19.148.192.33\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        progNo BETWEEN 250 AND 254 ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      --------------Midair Measurements Greenfield------------------------ 
      ---insert all new midair data into [dbo].[MidAir] table----- 
      --NPT40 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([10.249.240.10\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        (progNo = ''253'') OR                          (progNo = ''248'') ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      --NPT41 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([10.249.240.11\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        (progNo = ''253'') OR                          (progNo = ''248'') ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      --NPT43 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([10.249.240.13\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        (progNo = ''253'') OR                          (progNo = ''248'') ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      --NPT50 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([10.249.225.199\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        (progNo = ''253'') OR                          (progNo = ''248'') ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      --NPT51 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([10.249.225.197\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        (progNo = ''253'') OR                          (progNo = ''248'') ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      ---NPT52 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([10.249.225.198\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        (progNo = ''253'') OR                          (progNo = ''248'') ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      ---NPT53 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([10.249.240.14\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        (progNo = ''253'') OR                          (progNo = ''248'') ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      ---NPT54 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([10.249.225.200\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        (progNo = ''253'') OR                          (progNo = ''248'') ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      ---NPT55 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([10.249.226.5\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        (progNo = ''253'') OR                          (progNo = ''248'') ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      ---NPT56 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([10.249.225.133\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        (progNo = ''253'') OR                          (progNo = ''248'') ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      ---NPT57 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([10.249.203.138\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        (progNo = ''253'') OR                          (progNo = ''248'') ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      ---NPT58 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([10.249.226.7\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        (progNo = ''253'') OR                          (progNo = ''248'') ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      ---NPT59 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([10.249.226.8\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        (progNo = ''253'') OR                          (progNo = ''248'') ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      ---NPT70 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([10.249.227.69\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        (progNo = ''253'') OR                          (progNo = ''248'') ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      ---NPT71 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([10.249.222.197\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        (progNo = ''253'') OR                          (progNo = ''248'') ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      ---NPT72 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([10.249.225.135\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        (progNo = ''253'') OR                          (progNo = ''248'') ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 

      ---NPT73 
      INSERT INTO [dbo].[midair] 
                  ([datetime], 
                   [spotid], 
                   [resisactual], 
                   [resisref], 
                   [electrodeno], 
                   [energyactual], 
                   [weldtimeactual], 
                   [iactual2]) 
      SELECT t.datetime, 
             dbo.spot.id, 
             t.resistanceactualvalue, 
             t.resistancerefvalue, 
             t.electrodeno, 
             t.energyactualvalue, 
             t.weldtimeactualvalue, 
             t.iactual2 
      FROM   Openquery([10.249.222.198\bos_sqlserv_2005], ' SELECT        dateTime, timerName , progNo,   electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue,                           resistanceRefValue, IActual2 FROM            dbo.ExtWeldMeasureProtDDW_V WHERE        (progNo = ''253'') OR                          (progNo = ''248'') ') AS t 
             INNER JOIN dbo.timer 
                     ON t.timername COLLATE database_default = dbo.timer.NAME 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND t.progno = dbo.spot.program 
             LEFT OUTER JOIN [dbo].[midair] 
                          ON t.datetime = [dbo].[midair].datetime 
      WHERE  ( [dbo].[midair].datetime IS NULL ) 
  END