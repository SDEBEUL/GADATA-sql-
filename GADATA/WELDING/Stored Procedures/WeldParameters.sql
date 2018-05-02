
-- ============================================= 
-- Author:    Coppejans Jens 
-- Create date: 29/01/2018 
-- Description:  Welding parameters 
-- ============================================= 
CREATE PROCEDURE [WELDING].[WeldParameters] 
AS 
  BEGIN 
      SET nocount ON; 

      ---Update All parameters from NPT's with parameterFilter ------ 
      ---Update dbo.Weldparameters---- 
      ----Y555 AND V316 
      --NPT22--- OK  
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT22.value 
      FROM   Openquery([19.148.180.162\bos_sqlserv_2005], ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT22 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT22.paramname = dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT22.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT22.paramname = dbo.timerparametername.NAME 

      --NPT23--- OK  
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT23.value 
      FROM   Openquery([19.148.181.53\bos_sqlserv_2005], ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT23 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT23.paramname = dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT23.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT23.paramname = dbo.timerparametername.NAME 

      --NPT24--- OK  
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT24.value 
      FROM   Openquery([19.148.180.227\bos_sqlserv_2005], ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT24 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT24.paramname = dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT24.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT24.paramname = dbo.timerparametername.NAME 

      --NPT26--- OK  
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT26.value 
      FROM   Openquery([19.148.181.154\bos_sqlserv_2005], ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT26 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT26.paramname = dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT26.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT26.paramname = dbo.timerparametername.NAME 

      --NPT27--- OK  
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT27.value 
      FROM   Openquery([19.148.181.155\bos_sqlserv_2005], ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT27 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT27.paramname = dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT27.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT27.paramname = dbo.timerparametername.NAME 

      --NPT28--- OK  
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT28.value 
      FROM   Openquery([19.148.180.141\bos_sqlserv_2005], ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT28 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT28.paramname = dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT28.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT28.paramname = dbo.timerparametername.NAME 

      --NPT29--- OK  
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT29.value 
      FROM   Openquery([19.148.180.149\bos_sqlserv_2005], ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT29 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT29.paramname = dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT29.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT29.paramname = dbo.timerparametername.NAME 

      --NPT30--- OK  
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT30.value 
      FROM   Openquery([19.148.180.203\bos_sqlserv_2005], ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT30 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT30.paramname = dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT30.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT30.paramname = dbo.timerparametername.NAME 

      --NPT31--- OK  
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT31.value 
      FROM   Openquery([19.148.180.39\bos_sqlserv_2005], ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT31 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT31.paramname = dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT31.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT31.paramname = dbo.timerparametername.NAME 

      --NPT32--- OK  
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT32.value 
      FROM   Openquery([19.148.192.18\bos_sqlserv_2005], ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT32 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT32.paramname = dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT32.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT32.paramname = dbo.timerparametername.NAME 

      --NPT33--- OK  
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT33.value 
      FROM   Openquery([19.148.192.33\bos_sqlserv_2005], ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT33 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT33.paramname = dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT33.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT33.paramname = dbo.timerparametername.NAME 

      --NPT40 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT40.value 
      FROM   Openquery([10.249.240.10\bos_sqlserv_2005], ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT40 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT40.paramname COLLATE database_default = 
                        dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT40.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT40.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      --NPT41 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT41.value 
      FROM   Openquery([10.249.240.11\bos_sqlserv_2005], ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT41 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT41.paramname COLLATE database_default = 
                        dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT41.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT41.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      --NPT42 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT42.value 
      FROM   Openquery([10.249.240.12\bos_sqlserv_2005], ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT42 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT42.paramname COLLATE database_default = 
                        dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT42.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT42.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      --NPT43 ok 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT43.value 
      FROM   Openquery([10.249.240.13\bos_sqlserv_2005], 'SELECT dbo.ExtParamValues_V.paramName , dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT43 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT43.paramname COLLATE database_default = 
                        dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT43.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT43.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      --NPT50 ok 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT50.value 
      FROM   Openquery([10.249.225.199\bos_sqlserv_2005], 'SELECT dbo.ExtParamValues_V.paramName , dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT50 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT50.paramname COLLATE database_default = 
                        dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT50.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT50.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      --NPT51 ok 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT51.value 
      FROM   Openquery([10.249.225.197\bos_sqlserv_2005], 'SELECT dbo.ExtParamValues_V.paramName , dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT51 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT51.paramname COLLATE database_default = 
                        dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT51.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT51.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      --NPT52 ok 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT52.value 
      FROM   Openquery([10.249.225.198\bos_sqlserv_2005], 'SELECT dbo.ExtParamValues_V.paramName , dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT52 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT52.paramname COLLATE database_default = 
                        dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT52.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT52.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      --NPT53 ok 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT53.value 
      FROM   Openquery([10.249.240.14\bos_sqlserv_2005], 'SELECT dbo.ExtParamValues_V.paramName , dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT53 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT53.paramname COLLATE database_default = 
                        dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT53.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT53.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      --NPT54 ok 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT54.value 
      FROM   Openquery([10.249.225.200\bos_sqlserv_2005], 'SELECT dbo.ExtParamValues_V.paramName , dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT54 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT54.paramname COLLATE database_default = 
                        dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT54.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT54.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      --NPT55 ok 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT55.value 
      FROM   Openquery([10.249.226.5\bos_sqlserv_2005], 'SELECT dbo.ExtParamValues_V.paramName , dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT55 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT55.paramname COLLATE database_default = 
                        dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT55.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT55.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      --NPT56 ok 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT56.value 
      FROM   Openquery([10.249.225.133\bos_sqlserv_2005], 'SELECT dbo.ExtParamValues_V.paramName , dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT56 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT56.paramname COLLATE database_default = 
                        dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT56.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT56.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      --NPT57 ok 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT57.value 
      FROM   Openquery([10.249.203.138\bos_sqlserv_2005], 'SELECT dbo.ExtParamValues_V.paramName , dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT57 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT57.paramname COLLATE database_default = 
                        dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT57.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT57.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      --NPT58 ok 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT58.value 
      FROM   Openquery([10.249.226.7\bos_sqlserv_2005], 'SELECT dbo.ExtParamValues_V.paramName , dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT58 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT58.paramname COLLATE database_default = 
                        dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT58.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT58.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      --NPT59 ok 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT59.value 
      FROM   Openquery([10.249.226.8\bos_sqlserv_2005], 'SELECT dbo.ExtParamValues_V.paramName , dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT59 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT59.paramname COLLATE database_default = 
                        dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT59.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT59.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      --NPT70 ok 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT70.value 
      FROM   Openquery([10.249.227.69\bos_sqlserv_2005], 'SELECT dbo.ExtParamValues_V.paramName , dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT70 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT70.paramname COLLATE database_default = 
                        dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT70.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT70.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      --NPT71 ok 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT71.value 
      FROM   Openquery([10.249.222.197\bos_sqlserv_2005], 'SELECT dbo.ExtParamValues_V.paramName , dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT71 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT71.paramname COLLATE database_default = 
                        dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT71.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT71.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      --NPT72 ok 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT72.value 
      FROM   Openquery([10.249.225.135\bos_sqlserv_2005], 'SELECT dbo.ExtParamValues_V.paramName , dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT72 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT72.paramname COLLATE database_default = 
                        dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT72.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT72.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      --NPT73 ok 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = NPT73.value 
      FROM   Openquery([10.249.222.198\bos_sqlserv_2005], 'SELECT dbo.ExtParamValues_V.paramName , dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ') AS NPT73 
             INNER JOIN dbo.spotparameterfilter 
                     ON NPT73.paramname COLLATE database_default = 
                        dbo.spotparameterfilter.NAME 
             INNER JOIN dbo.spot 
                     ON NPT73.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND NPT73.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 
  END