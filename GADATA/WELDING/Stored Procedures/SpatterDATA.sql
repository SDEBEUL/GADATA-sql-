
------------------------------------------------------------------------------- 
CREATE PROCEDURE [WELDING].[SpatterDATA] 
-- Add the parameters for the stored procedure here 
------------------------------------------------------------------------------ 
AS 
  BEGIN 
      SET nocount ON; 

      ---NPT26 
      INSERT INTO welding.expulsiondata 
                  ([datetime], 
                   [spotid], 
                   [wear], 
                   [tipdresscounter], 
                   [partident], 
                   [weldtime], 
                   [energy], 
                   [uip], 
                   [psf], 
                   [expulsiontime], 
                   [resistance]) 
      SELECT Expulsions.datetime, 
             welding.expulsionzones.id, 
             Expulsions.wear, 
             Expulsions.tipdresscounter, 
             Expulsions.partidentstring, 
             Expulsions.weldtime, 
             Expulsions.energy, 
             Expulsions.uip, 
             Expulsions.psf, 
             Expulsions.expulsiontime, 
             Expulsions.resistance 
      FROM   Openquery ([19.148.181.154\bos_sqlserv_2005], '                            SELECT [dateTime],spotname   ,[wear] ,[tipDressCounter] ,[partIdentString]  ,[weldTimeActualValue] As WeldTime  ,[energyActualValue] As Energy  ,[uipActualValue] As uip  ,[stabilisationFactorActValue] As PSF  ,[uirExpulsionTime] As ExpulsionTime ,[resistanceActualValue] As Resistance   FROM [BOS_6000_DB].[dbo].[ExtWeldMeasureProtDDW_V] WHERE (uirExpulsionTime > 0) ') AS Expulsions 
             INNER JOIN welding.expulsionzones 
                     ON Expulsions.spotname = welding.expulsionzones.number 
             LEFT OUTER JOIN welding.expulsiondata 
                          ON Expulsions.datetime = 
                             welding.expulsiondata.datetime 
      WHERE  ( welding.expulsiondata.datetime IS NULL ) 

      ---NPT28 
      INSERT INTO welding.expulsiondata 
                  ([datetime], 
                   [spotid], 
                   [wear], 
                   [tipdresscounter], 
                   [partident], 
                   [weldtime], 
                   [energy], 
                   [uip], 
                   [psf], 
                   [expulsiontime], 
                   [resistance]) 
      SELECT Expulsions.datetime, 
             welding.expulsionzones.id, 
             Expulsions.wear, 
             Expulsions.tipdresscounter, 
             Expulsions.partidentstring, 
             Expulsions.weldtime, 
             Expulsions.energy, 
             Expulsions.uip, 
             Expulsions.psf, 
             Expulsions.expulsiontime, 
             Expulsions.resistance 
      FROM   Openquery ([19.148.180.141\bos_sqlserv_2005], '                            SELECT [dateTime],spotname   ,[wear] ,[tipDressCounter] ,[partIdentString]  ,[weldTimeActualValue] As WeldTime  ,[energyActualValue] As Energy  ,[uipActualValue] As uip  ,[stabilisationFactorActValue] As PSF  ,[uirExpulsionTime] As ExpulsionTime ,[resistanceActualValue] As Resistance   FROM [BOS_6000_DB].[dbo].[ExtWeldMeasureProtDDW_V] WHERE (uirExpulsionTime > 0) ') AS Expulsions 
             INNER JOIN welding.expulsionzones 
                     ON Expulsions.spotname = welding.expulsionzones.number 
             LEFT OUTER JOIN welding.expulsiondata 
                          ON Expulsions.datetime = 
                             welding.expulsiondata.datetime 
      WHERE  ( welding.expulsiondata.datetime IS NULL ) 

      ---NPT29 
      INSERT INTO welding.expulsiondata 
                  ([datetime], 
                   [spotid], 
                   [wear], 
                   [tipdresscounter], 
                   [partident], 
                   [weldtime], 
                   [energy], 
                   [uip], 
                   [psf], 
                   [expulsiontime], 
                   [resistance]) 
      SELECT Expulsions.datetime, 
             welding.expulsionzones.id, 
             Expulsions.wear, 
             Expulsions.tipdresscounter, 
             Expulsions.partidentstring, 
             Expulsions.weldtime, 
             Expulsions.energy, 
             Expulsions.uip, 
             Expulsions.psf, 
             Expulsions.expulsiontime, 
             Expulsions.resistance 
      FROM   Openquery ([19.148.180.149\bos_sqlserv_2005], '                            SELECT [dateTime],spotname   ,null as [wear] ,[tipDressCounter] ,[partIdentString]  ,[weldTimeActualValue] As WeldTime  ,[energyActualValue] As Energy  ,[uipActualValue] As uip  ,[stabilisationFactorActValue] As PSF  ,[uirExpulsionTime] As ExpulsionTime ,[resistanceActualValue] As Resistance   FROM [BOS_6000_DB].[dbo].[ExtWeldMeasureProtDDW_V] WHERE (uirExpulsionTime > 0) ') AS Expulsions 
             INNER JOIN welding.expulsionzones 
                     ON Expulsions.spotname = welding.expulsionzones.number 
             LEFT OUTER JOIN welding.expulsiondata 
                          ON Expulsions.datetime = 
                             welding.expulsiondata.datetime 
      WHERE  ( welding.expulsiondata.datetime IS NULL ) 

      ---NPT30 
      INSERT INTO welding.expulsiondata 
                  ([datetime], 
                   [spotid], 
                   [wear], 
                   [tipdresscounter], 
                   [partident], 
                   [weldtime], 
                   [energy], 
                   [uip], 
                   [psf], 
                   [expulsiontime], 
                   [resistance]) 
      SELECT Expulsions.datetime, 
             welding.expulsionzones.id, 
             Expulsions.wear, 
             Expulsions.tipdresscounter, 
             Expulsions.partidentstring, 
             Expulsions.weldtime, 
             Expulsions.energy, 
             Expulsions.uip, 
             Expulsions.psf, 
             Expulsions.expulsiontime, 
             Expulsions.resistance 
      FROM   Openquery ([19.148.180.203\bos_sqlserv_2005], '                        SELECT [dateTime],spotname   ,[wear] ,[tipDressCounter] ,[partIdentString]  ,[weldTimeActualValue] As WeldTime  ,[energyActualValue] As Energy  ,[uipActualValue] As uip  ,[stabilisationFactorActValue] As PSF  ,[uirExpulsionTime] As ExpulsionTime ,[resistanceActualValue] As Resistance   FROM [BOS_6000_DB].[dbo].[ExtWeldMeasureProtDDW_V] WHERE (uirExpulsionTime > 0)    ') AS Expulsions 
             INNER JOIN welding.expulsionzones 
                     ON Expulsions.spotname = welding.expulsionzones.number 
             LEFT OUTER JOIN welding.expulsiondata 
                          ON Expulsions.datetime = 
                             welding.expulsiondata.datetime 
      WHERE  ( welding.expulsiondata.datetime IS NULL ) 

      ---NPT31 
      INSERT INTO welding.expulsiondata 
                  ([datetime], 
                   [spotid], 
                   [wear], 
                   [tipdresscounter], 
                   [partident], 
                   [weldtime], 
                   [energy], 
                   [uip], 
                   [psf], 
                   [expulsiontime], 
                   [resistance]) 
      SELECT Expulsions.datetime, 
             welding.expulsionzones.id, 
             Expulsions.wear, 
             Expulsions.tipdresscounter, 
             Expulsions.partidentstring, 
             Expulsions.weldtime, 
             Expulsions.energy, 
             Expulsions.uip, 
             Expulsions.psf, 
             Expulsions.expulsiontime, 
             Expulsions.resistance 
      FROM   Openquery ([19.148.180.39\bos_sqlserv_2005], '                            SELECT [dateTime],spotname   ,[wear] ,[tipDressCounter] ,[partIdentString]  ,[weldTimeActualValue] As WeldTime  ,[energyActualValue] As Energy  ,[uipActualValue] As uip  ,[stabilisationFactorActValue] As PSF  ,[uirExpulsionTime] As ExpulsionTime ,[resistanceActualValue] As Resistance   FROM [BOS_6000_DB].[dbo].[ExtWeldMeasureProtDDW_V] WHERE (uirExpulsionTime > 0) ') AS Expulsions 
             INNER JOIN welding.expulsionzones 
                     ON Expulsions.spotname = welding.expulsionzones.number 
             LEFT OUTER JOIN welding.expulsiondata 
                          ON Expulsions.datetime = 
                             welding.expulsiondata.datetime 
      WHERE  ( welding.expulsiondata.datetime IS NULL ) 

      ---NPT32 
      INSERT INTO welding.expulsiondata 
                  ([datetime], 
                   [spotid], 
                   [wear], 
                   [tipdresscounter], 
                   [partident], 
                   [weldtime], 
                   [energy], 
                   [uip], 
                   [psf], 
                   [expulsiontime], 
                   [resistance]) 
      SELECT Expulsions.datetime, 
             welding.expulsionzones.id, 
             Expulsions.wear, 
             Expulsions.tipdresscounter, 
             Expulsions.partidentstring, 
             Expulsions.weldtime, 
             Expulsions.energy, 
             Expulsions.uip, 
             Expulsions.psf, 
             Expulsions.expulsiontime, 
             Expulsions.resistance 
      FROM   Openquery ([19.148.192.18\bos_sqlserv_2005], '                            SELECT [dateTime],spotname   ,[wear] ,[tipDressCounter] ,[partIdentString]  ,[weldTimeActualValue] As WeldTime  ,[energyActualValue] As Energy  ,[uipActualValue] As uip  ,[stabilisationFactorActValue] As PSF  ,[uirExpulsionTime] As ExpulsionTime ,[resistanceActualValue] As Resistance   FROM [BOS_6000_DB].[dbo].[ExtWeldMeasureProtDDW_V] WHERE (uirExpulsionTime > 0) ') AS Expulsions 
             INNER JOIN welding.expulsionzones 
                     ON Expulsions.spotname = welding.expulsionzones.number 
             LEFT OUTER JOIN welding.expulsiondata 
                          ON Expulsions.datetime = 
                             welding.expulsiondata.datetime 
      WHERE  ( welding.expulsiondata.datetime IS NULL ) 

      ---NPT33 
      INSERT INTO welding.expulsiondata 
                  ([datetime], 
                   [spotid], 
                   [wear], 
                   [tipdresscounter], 
                   [partident], 
                   [weldtime], 
                   [energy], 
                   [uip], 
                   [psf], 
                   [expulsiontime], 
                   [resistance]) 
      SELECT Expulsions.datetime, 
             welding.expulsionzones.id, 
             Expulsions.wear, 
             Expulsions.tipdresscounter, 
             Expulsions.partidentstring, 
             Expulsions.weldtime, 
             Expulsions.energy, 
             Expulsions.uip, 
             Expulsions.psf, 
             Expulsions.expulsiontime, 
             Expulsions.resistance 
      FROM   Openquery ([19.148.192.33\bos_sqlserv_2005], '                            SELECT [dateTime],spotname   ,[wear] ,[tipDressCounter] ,[partIdentString]  ,[weldTimeActualValue] As WeldTime  ,[energyActualValue] As Energy  ,[uipActualValue] As uip  ,[stabilisationFactorActValue] As PSF  ,[uirExpulsionTime] As ExpulsionTime ,[resistanceActualValue] As Resistance   FROM [BOS_6000_DB].[dbo].[ExtWeldMeasureProtDDW_V] WHERE (uirExpulsionTime > 0) ') AS Expulsions 
             INNER JOIN welding.expulsionzones 
                     ON Expulsions.spotname = welding.expulsionzones.number 
             LEFT OUTER JOIN welding.expulsiondata 
                          ON Expulsions.datetime = 
                             welding.expulsiondata.datetime 
      WHERE  ( welding.expulsiondata.datetime IS NULL ) 

      ---NPT70 
      INSERT INTO welding.expulsiondata 
                  ([datetime], 
                   [spotid], 
                   [wear], 
                   [tipdresscounter], 
                   [partident], 
                   [weldtime], 
                   [energy], 
                   [uip], 
                   [psf], 
                   [expulsiontime], 
                   [resistance]) 
      SELECT Expulsions.datetime, 
             welding.expulsionzones.id, 
             Expulsions.wear, 
             Expulsions.tipdresscounter, 
             Expulsions.partidentstring, 
             Expulsions.weldtime, 
             Expulsions.energy, 
             Expulsions.uip, 
             Expulsions.psf, 
             Expulsions.expulsiontime, 
             Expulsions.resistance 
      FROM   Openquery ([10.249.227.69\bos_sqlserv_2005], '                            SELECT [dateTime],spotname   ,null as [wear] ,[tipDressCounter] ,[partIdentString]  ,[weldTimeActualValue] As WeldTime  ,[energyActualValue] As Energy  ,[uipActualValue] As uip  ,[stabilisationFactorActValue] As PSF  ,[uirExpulsionTime] As ExpulsionTime ,[resistanceActualValue] As Resistance   FROM [BOS_6000_DB].[dbo].[ExtWeldMeasureProtDDW_V] WHERE (uirExpulsionTime > 0) ') AS Expulsions 
             INNER JOIN welding.expulsionzones 
                     ON Expulsions.spotname = welding.expulsionzones.number 
             LEFT OUTER JOIN welding.expulsiondata 
                          ON Expulsions.datetime = 
                             welding.expulsiondata.datetime 
      WHERE  ( welding.expulsiondata.datetime IS NULL ) 

      ---NPT71 
      INSERT INTO welding.expulsiondata 
                  ([datetime], 
                   [spotid], 
                   [wear], 
                   [tipdresscounter], 
                   [partident], 
                   [weldtime], 
                   [energy], 
                   [uip], 
                   [psf], 
                   [expulsiontime], 
                   [resistance]) 
      SELECT Expulsions.datetime, 
             welding.expulsionzones.id, 
             Expulsions.wear, 
             Expulsions.tipdresscounter, 
             Expulsions.partidentstring, 
             Expulsions.weldtime, 
             Expulsions.energy, 
             Expulsions.uip, 
             Expulsions.psf, 
             Expulsions.expulsiontime, 
             Expulsions.resistance 
      FROM   Openquery ([10.249.222.197\bos_sqlserv_2005], '                            SELECT [dateTime],spotname   ,null as [wear] ,[tipDressCounter] ,[partIdentString]  ,[weldTimeActualValue] As WeldTime  ,[energyActualValue] As Energy  ,[uipActualValue] As uip  ,[stabilisationFactorActValue] As PSF  ,[uirExpulsionTime] As ExpulsionTime ,[resistanceActualValue] As Resistance   FROM [BOS_6000_DB].[dbo].[ExtWeldMeasureProtDDW_V] WHERE (uirExpulsionTime > 0) ') AS Expulsions 
             INNER JOIN welding.expulsionzones 
                     ON Expulsions.spotname = welding.expulsionzones.number 
             LEFT OUTER JOIN welding.expulsiondata 
                          ON Expulsions.datetime = 
                             welding.expulsiondata.datetime 
      WHERE  ( welding.expulsiondata.datetime IS NULL ) 

      ---NPT72 
      INSERT INTO welding.expulsiondata 
                  ([datetime], 
                   [spotid], 
                   [wear], 
                   [tipdresscounter], 
                   [partident], 
                   [weldtime], 
                   [energy], 
                   [uip], 
                   [psf], 
                   [expulsiontime], 
                   [resistance]) 
      SELECT Expulsions.datetime, 
             welding.expulsionzones.id, 
             Expulsions.wear, 
             Expulsions.tipdresscounter, 
             Expulsions.partidentstring, 
             Expulsions.weldtime, 
             Expulsions.energy, 
             Expulsions.uip, 
             Expulsions.psf, 
             Expulsions.expulsiontime, 
             Expulsions.resistance 
      FROM   Openquery ([10.249.225.135\bos_sqlserv_2005], '                            SELECT [dateTime],spotname   ,null as [wear] ,[tipDressCounter] ,[partIdentString]  ,[weldTimeActualValue] As WeldTime  ,[energyActualValue] As Energy  ,[uipActualValue] As uip  ,[stabilisationFactorActValue] As PSF  ,[uirExpulsionTime] As ExpulsionTime ,[resistanceActualValue] As Resistance   FROM [BOS_6000_DB].[dbo].[ExtWeldMeasureProtDDW_V] WHERE (uirExpulsionTime > 0) ') AS Expulsions 
             INNER JOIN welding.expulsionzones 
                     ON Expulsions.spotname = welding.expulsionzones.number 
             LEFT OUTER JOIN welding.expulsiondata 
                          ON Expulsions.datetime = 
                             welding.expulsiondata.datetime 
      WHERE  ( welding.expulsiondata.datetime IS NULL ) 

      ---NPT73 
      INSERT INTO welding.expulsiondata 
                  ([datetime], 
                   [spotid], 
                   [wear], 
                   [tipdresscounter], 
                   [partident], 
                   [weldtime], 
                   [energy], 
                   [uip], 
                   [psf], 
                   [expulsiontime], 
                   [resistance]) 
      SELECT Expulsions.datetime, 
             welding.expulsionzones.id, 
             Expulsions.wear, 
             Expulsions.tipdresscounter, 
             Expulsions.partidentstring, 
             Expulsions.weldtime, 
             Expulsions.energy, 
             Expulsions.uip, 
             Expulsions.psf, 
             Expulsions.expulsiontime, 
             Expulsions.resistance 
      FROM   Openquery ([10.249.222.198\bos_sqlserv_2005], '                            SELECT [dateTime],spotname   ,null as [wear] ,[tipDressCounter] ,[partIdentString]  ,[weldTimeActualValue] As WeldTime  ,[energyActualValue] As Energy  ,[uipActualValue] As uip  ,[stabilisationFactorActValue] As PSF  ,[uirExpulsionTime] As ExpulsionTime ,[resistanceActualValue] As Resistance   FROM [BOS_6000_DB].[dbo].[ExtWeldMeasureProtDDW_V] WHERE (uirExpulsionTime > 0) ') AS Expulsions 
             INNER JOIN welding.expulsionzones 
                     ON Expulsions.spotname = welding.expulsionzones.number 
             LEFT OUTER JOIN welding.expulsiondata 
                          ON Expulsions.datetime = 
                             welding.expulsiondata.datetime 
      WHERE  ( welding.expulsiondata.datetime IS NULL ) 

      -------------------------------------------------------------------------------------------- 
      --DELETE records older than 5 days 
      DELETE FROM welding.expulsiondata 
      WHERE  datetime < Dateadd(day, -5, Getdate()) 

      --------------------------------------------------------------------------------------------- 
      --When imported Query JOIN with zones & comments 
      ---delete null values----- 
      DELETE FROM [GADATA].[WELDING].[expulsiondata] 
      WHERE  datetime IS NULL 
  END