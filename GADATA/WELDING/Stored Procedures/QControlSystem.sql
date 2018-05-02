
-- ============================================= 
-- Author:    Coppejans Jens 
-- Create date:  
-- Description:   
-- ============================================= 
CREATE PROCEDURE [WELDING].[QControlSystem] 
AS 
  BEGIN 
      SET nocount ON; 

      ---Update all spot & timerID's from dbo.spot and dbo.timer---- 
      UPDATE welding.qcontrol 
      SET    welding.qcontrol.spotid = dbo.spot.id, 
             welding.qcontrol.timerid = dbo.timer.id 
      FROM   dbo.spot 
             INNER JOIN dbo.timer 
                     ON dbo.spot.timerid = dbo.timer.id 
                        AND dbo.spot.timerid = dbo.timer.id 
             INNER JOIN welding.qcontrol 
                     ON dbo.spot.id = welding.qcontrol.spotid 
                        AND dbo.timer.id = welding.qcontrol.timerid 

      --Update dbo.Weldparameters every hour with values from rgulation and monitoring (p) --- 
      ---NPT22 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([19.148.180.162\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname = dbo.timerparametername.NAME 

      ---NPT23 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([19.148.181.53\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname = dbo.timerparametername.NAME 

      ---NPT24 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([19.148.180.227\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname = dbo.timerparametername.NAME 

      ---NPT26 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([19.148.181.154\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname = dbo.timerparametername.NAME 

      ---NPT27 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([19.148.181.155\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname = dbo.timerparametername.NAME 

      ---NPT28 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([19.148.180.141\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname = dbo.timerparametername.NAME 

      ---NPT29 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([19.148.180.149\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname = dbo.timerparametername.NAME 

      ---NPT30 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([19.148.180.203\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname = dbo.timerparametername.NAME 

      ---NPT31 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([19.148.180.39\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname = dbo.timerparametername.NAME 

      ---NPT32 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([19.148.192.18\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname = dbo.timerparametername.NAME 

      ---NPT33 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([19.148.192.33\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''20000'' AND ''49999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname = dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname = dbo.timerparametername.NAME 

      ---NPT40 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([10.249.240.10\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname COLLATE database_default = 
                        dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      ---NPT41 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([10.249.240.11\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname COLLATE database_default = 
                        dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      ---NPT43 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([10.249.240.13\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname COLLATE database_default = 
                        dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      ---NPT50 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([10.249.225.199\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname COLLATE database_default = 
                        dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      ---NPT51 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([10.249.225.197\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname COLLATE database_default = 
                        dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      ---NPT52 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([10.249.225.198\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname COLLATE database_default = 
                        dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      ---NPT53 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([10.249.240.14\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname COLLATE database_default = 
                        dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      ---NPT54 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([10.249.225.200\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname COLLATE database_default = 
                        dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      ---NPT55 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([10.249.226.5\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname COLLATE database_default = 
                        dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      ---NPT56 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([10.249.225.133\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname COLLATE database_default = 
                        dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      ---NPT57 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([10.249.203.138\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname COLLATE database_default = 
                        dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      ---NPT58 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([10.249.226.7\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname COLLATE database_default = 
                        dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      ---NPT59 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([10.249.226.8\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname COLLATE database_default = 
                        dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      ---NPT70 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([10.249.227.69\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname COLLATE database_default = 
                        dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      ---NPT71 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([10.249.222.197\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname COLLATE database_default = 
                        dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      ---NPT72 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([10.249.225.135\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname COLLATE database_default = 
                        dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      ---NPT73 
      UPDATE dbo.weldparameters 
      SET    dbo.weldparameters.value = uitadaptief.reg 
      ---SELECT        uitadaptief.spotName, uitadaptief.reg AS ActualValues, uitadaptief.ParamName 
      FROM   Openquery([10.249.222.198\bos_sqlserv_2005], ' SELECT DISTINCT dbo.ExtSpotTable_V.spotName, dbo.ExtParamValues_V.value AS reg, dbo.ExtParamValues_V.ParamName FROM            dbo.ExtSpotTable_V INNER JOIN                          dbo.ExtParamValues_V ON dbo.ExtSpotTable_V.timerName = dbo.ExtParamValues_V.timerName AND                           dbo.ExtSpotTable_V.weldProgNo = dbo.ExtParamValues_V.subIndex WHERE        (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2327) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2363) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'') OR  (dbo.ExtParamValues_V.languageCode = 1) AND (dbo.ExtParamValues_V.param_ID = 2974) AND (dbo.ExtSpotTable_V.spotName BETWEEN ''4400000'' AND ''4419999'')  ') AS uitadaptief 
             INNER JOIN dbo.spot 
                     ON uitadaptief.spotname COLLATE database_default = 
                        dbo.spot.number 
             INNER JOIN dbo.weldparameters 
                     ON dbo.spot.id = dbo.weldparameters.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.weldparameters.parameternameid = 
                        dbo.timerparametername.id 
                        AND uitadaptief.paramname COLLATE database_default = 
                            dbo.timerparametername.NAME 

      -----de meest dringende spots gaan filteren om zeker te gaan controleren door UT groep----- 
      -------Insert data in 'uit adaptief' column ---- 
      CREATE TABLE #temptable98 
        ( 
           id  INT, 
           reg BIT, 
           mon BIT 
        ) 

      INSERT INTO #temptable98 
                  (id, 
                   reg, 
                   mon) 
      SELECT dbo.weldparameters.spotid, 
             dbo.weldparameters.value AS reg, 
             WeldParameters_1.value 
      FROM   dbo.spot AS Spot_1 
             INNER JOIN dbo.weldparameters AS WeldParameters_1 
                     ON Spot_1.id = WeldParameters_1.spotid 
             INNER JOIN dbo.spot 
                        INNER JOIN dbo.weldparameters 
                                ON dbo.spot.id = dbo.weldparameters.spotid 
                                   AND dbo.spot.id = dbo.weldparameters.spotid 
                     ON Spot_1.number = dbo.spot.number 
      WHERE  ( dbo.weldparameters.parameternameid = 43 ) 
             AND ( WeldParameters_1.parameternameid = 44 ) 
             AND ( dbo.weldparameters.value = 0 ) 
             AND ( WeldParameters_1.value = 0 ) 

      UPDATE welding.qcontrol 
      SET    welding.qcontrol.[uit adaptief] = CASE 
                                                 WHEN #temptable98.reg = '0' 
                                                      AND #temptable98.mon = '0' 
                                               THEN 
                                                 '1' 
                                                 ELSE '0' 
                                               END 
      FROM   #temptable98 
             INNER JOIN welding.qcontrol 
                     ON #temptable98.id = welding.qcontrol.spotid 

      DROP TABLE #temptable98 

      CREATE TABLE #temptable100 
        ( 
           id  INT, 
           reg BIT, 
           mon BIT 
        ) 

      INSERT INTO #temptable100 
                  (id, 
                   reg, 
                   mon) 
      SELECT dbo.weldparameters.spotid, 
             dbo.weldparameters.value AS reg, 
             WeldParameters_1.value 
      FROM   dbo.spot AS Spot_1 
             INNER JOIN dbo.weldparameters AS WeldParameters_1 
                     ON Spot_1.id = WeldParameters_1.spotid 
             INNER JOIN dbo.spot 
                        INNER JOIN dbo.weldparameters 
                                ON dbo.spot.id = dbo.weldparameters.spotid 
                                   AND dbo.spot.id = dbo.weldparameters.spotid 
                     ON Spot_1.number = dbo.spot.number 
      WHERE  ( dbo.weldparameters.parameternameid = 43 ) 
             AND ( WeldParameters_1.parameternameid = 44 ) 
             AND ( dbo.weldparameters.value = 1 ) 
             AND ( WeldParameters_1.value = 1 ) 

      UPDATE welding.qcontrol 
      SET    welding.qcontrol.[uit adaptief] = CASE 
                                                 WHEN #temptable100.reg = '1' 
                                                      AND #temptable100.mon = 
                                                          '1' 
                                               THEN 
                                                 '0' 
                                                 ELSE '1' 
                                               END 
      FROM   #temptable100 
             INNER JOIN welding.qcontrol 
                     ON #temptable100.id = welding.qcontrol.spotid 

      DROP TABLE #temptable100 

      ---Update losse spotmelding from Qteam and insert into Qcontrol table---- 
      --create temp table--- 
      CREATE TABLE #temptable 
        ( 
           time  DATETIME, 
           loose BIT, 
           id    INT 
        ) 

      INSERT INTO #temptable 
                  (time, 
                   loose, 
                   id) 
      SELECT Max(dbo.ultraloginspections.inspectiontime) AS time, 
             dbo.ultraloginspections.loose, 
             dbo.spot.id 
      FROM   dbo.ultraloginspections 
             INNER JOIN dbo.spot 
                     ON dbo.ultraloginspections.spotid = dbo.spot.id 
      WHERE  ( dbo.ultraloginspections.inspectiontime >= Getdate() - 2 ) 
      GROUP  BY dbo.spot.id, 
                dbo.ultraloginspections.loose 
      HAVING ( dbo.ultraloginspections.loose = 1 ) 

      UPDATE welding.qcontrol 
      SET    welding.qcontrol.coldweldreport = CASE 
             WHEN #temptable.loose = '1' THEN '1' 
             ELSE '0' 
                                               END 
      FROM   welding.qcontrol 
             LEFT OUTER JOIN #temptable 
                          ON welding.qcontrol.spotid = #temptable.id 

      --delete temp table---- 
      DROP TABLE #temptable 

      --- Look after big parameter changes in the datachange from the welding timers 
      ---Datachange is fresh from 1h trigger stored procedure----                     
      --Make temp table--- 
      CREATE TABLE #temptable1 
        ( 
           id             INT, 
           weldtimereduce INT 
        ) 

      --reduce in WeldingTime--- 
      ---INSERT INTO #TempTable1 
      ---SELECT        dbo.spot.ID, SUM(CAST(WELDING.Datachanges.OldValue AS int) - CAST(WELDING.Datachanges.NewValue AS int)) 
      ---                        AS WeldingTimeReduce 
      ---FROM            WELDING.Datachanges INNER JOIN 
      ---                         dbo.Timer ON WELDING.Datachanges.Timer = WELDING.spot.Timer AND WELDING.Datachanges.program = WELDING.spot.Program
      ---WHERE        (WELDING.Datachanges.Timestamp >= GETDATE() - 1) AND (WELDING.Datachanges.Parameter = '2. Weld Time')
      ---GROUP BY WELDING.spot.Spot 
      ---HAVING        (SUM(CAST(WELDING.Datachanges.OldValue AS int) - CAST(WELDING.Datachanges.NewValue AS int)) < - 50)
      ---Update the Qcontrol table--- 
      ---UPDATE WELDING.Qcontrol 
      ---SET WELDING.Qcontrol.[ReduceWeldingTime] =  
      ---CASE WHEN  #TempTable1.weldtimeReduce < '-50' 
      ---THEN  '1'  ELSE '0' END  
      ---FROM  WELDING.Qcontrol LEFT OUTER JOIN #TempTable1 ON WELDING.Qcontrol.spot = #TempTable1.Number
      --delete temp table---- 
      ----DROP TABLE #TempTable1 
      ---Changes in Current---   ----Nog NOK problemen met convert varchar to decimal---- 
      --Make temp table--- 
      ---CREATE TABLE #TempTable2( 
      ---Number int, 
      ---CurrentReduce float ) 
      ---INSERT INTO #TempTable2 
      ---SELECT        WELDING.spot.Spot, 10 * (try_CAST(WELDING.Datachanges.OldValue AS DECIMAL(10,5)) - try_CAST(WELDING.Datachanges.NewValue AS DECIMAL(10,5))) 
      ---                     AS CurrentReduce 
      ---FROM            WELDING.Datachanges INNER JOIN 
      ---                       WELDING.spot ON WELDING.Datachanges.Timer = WELDING.spot.Timer AND WELDING.Datachanges.program = WELDING.spot.Program
      ---WHERE        (WELDING.Datachanges.Timestamp >= GETDATE() - 1) AND (WELDING.Datachanges.Parameter = '2. Heat')
      ---GROUP BY WELDING.spot.Spot 
      ---HAVING        (SUM(CAST(WELDING.Datachanges.OldValue AS DECIMAL(10,5)) - CAST(WELDING.Datachanges.NewValue AS DECIMAL(10,5))) < - 0.5)
      ---Update the Qcontrol table--- 
      ---UPDATE WELDING.Qcontrol 
      ---SET WELDING.Qcontrol.[ReduceCurrent] =  
      ---CASE WHEN  #TempTable2.CurrentReduce < '-0.5' 
      ---THEN  '1'  ELSE '0' END  
      ---FROM  WELDING.Qcontrol LEFT OUTER JOIN #TempTable2 ON WELDING.Qcontrol.spot = #TempTable2.Number
      --delete temp table---- 
      ---DROP TABLE #TempTable2 
      ---SBCU afwijkingen--- 
      --- C3G robots control---- 
      ---CREATE TABLE #TempTable3( 
      -- Timer varchar(25)) 
      --INSERT INTO #TempTable3 
      --SELECT dbo.Timer.Name As Timer 
      --FROM   dbo.SBCUAlertsLast24H INNER JOIN 
      --             dbo.Timer ON dbo.SBCUAlertsLast24H.Robot = dbo.Timer.Robot 
      --UPDATE WELDING.Qcontrol 
      --SET WELDING.Qcontrol.SBCUAlert =  
      --CASE WHEN  #TempTable3.Timer BETWEEN '10000WT01' AND '99999WT01'  THEN  '1'  ELSE '0' END  
      --FROM  WELDING.Qcontrol LEFT OUTER JOIN #TempTable3 ON WELDING.Qcontrol.Timer = #TempTable3.Timer
      --DROP TABLE #TempTable3 
      --- Search after big changes in energy drop ---- >1500 Joule decrease in a week ---- 
      --Make temp table--- 
      --CREATE TABLE #TempTable4( 
      --Number int, 
      --EnergyDrops float ) 
      --INSERT INTO #TempTable4 
      --SELECT        dbo.Spot.Number, MAX(dbo.WeldMeasurements.AvgEnergy) - MIN(WeldMeasurements_1.AvgEnergy) AS EnergyDifference
      ---FROM          dbo.Spot INNER JOIN 
      --              dbo.WeldMeasurements ON dbo.Spot.ID = dbo.WeldMeasurements.SpotId INNER JOIN 
      --             dbo.WeldMeasurements AS WeldMeasurements_1 ON dbo.Spot.ID = WeldMeasurements_1.SpotId
      --WHERE        (WeldMeasurements_1.Date >= GETDATE() - 2) AND (dbo.WeldMeasurements.Date >= GETDATE() - 7)
      --GROUP BY      dbo.Spot.Number 
      --HAVING       (MAX(dbo.WeldMeasurements.AvgEnergy) - MIN(WeldMeasurements_1.AvgEnergy) > 1800) 
      --ORDER BY EnergyDifference DESC 
      --UPDATE WELDING.Qcontrol 
      --SET WELDING.Qcontrol.EnergyDrop =  
      --CASE WHEN  #TempTable4.EnergyDrops > '1800'  THEN  '1'  ELSE '0' END  
      --FROM  WELDING.Qcontrol LEFT OUTER JOIN #TempTable4 ON WELDING.Qcontrol.spot = #TempTable4.Number
      --delete temp table---- 
      --DROP TABLE #TempTable4 
      ----zoek de spots die volgens datum langst geleden zijn gecontroleerd --- prio plannen 
      --Make temp table--- 
      --CREATE TABLE #TempTable5( 
      -- id int, 
      -- LastInspectionDate Datetime ) 
      --INSERT INTO #TempTable5 
      --SELECT         dbo.Spot.ID, MAX(dbo.UltralogInspections.InspectionTime) AS [last inspection Time]
      --FROM           dbo.UltralogInspections INNER JOIN 
      ---  dbo.Spot ON dbo.UltralogInspections.SpotID = dbo.Spot.ID 
      --GROUP BY dbo.Spot.id 
      --ORDER BY [last inspection Time] 
      --UPDATE WELDING.Qcontrol 
      --SET WELDING.Qcontrol.LastInspectionDate =  
      --CASE    WHEN #TempTable5.LastInspectionDate >= GETDATE()-1 THEN '< 24H'  
      --       WHEN #TempTable5.LastInspectionDate < DATEADD(day,-1,GETDATE()) and #TempTable5.LastInspectionDate > DATEADD(day,-2,GETDATE())  THEN 'between 24H and 48H'
      --    WHEN #TempTable5.LastInspectionDate < DATEADD(day,-2,GETDATE()) and #TempTable5.LastInspectionDate > DATEADD(day,-8,GETDATE())  THEN 'between 48H and 1Week'
      --    WHEN #TempTable5.LastInspectionDate < DATEADD(day,-8,GETDATE()) THEN '> 1Week' 
      -- ELSE 'NO ULtralog' 
      -- END 
      --FROM  WELDING.Qcontrol LEFT OUTER JOIN #TempTable5 ON WELDING.Qcontrol.spotid = #TempTable5.id 
      --delete temp table---- 
      --DROP TABLE #TempTable5 
      ---Update Last inspectionDate---- 
      CREATE TABLE #temptable6 
        ( 
           id             INT, 
           inspectiondate DATETIME 
        ) 

      INSERT INTO #temptable6 
      SELECT dbo.spot.id, 
             Max(dbo.ultraloginspections.inspectiontime) AS 
             [last inspection Time] 
      FROM   dbo.ultraloginspections 
             INNER JOIN dbo.spot 
                     ON dbo.ultraloginspections.spotid = dbo.spot.id 
      GROUP  BY dbo.spot.id 
      ORDER  BY [last inspection time] 

      UPDATE welding.qcontrol 
      SET    welding.qcontrol.inspectiondate = #temptable6.inspectiondate 
      FROM   welding.qcontrol 
             LEFT OUTER JOIN #temptable6 
                          ON welding.qcontrol.spotid = #temptable6.id 

      --delete temp table---- 
      DROP TABLE #temptable6 
  ----Check the count of welds between now and the last ultralogControl---- 
  ---CREATE TABLE #TempTable7( 
  -- id int, 
  -- CountofWelds int )                
  -- INSERT INTO #TempTable7 
  --SELECT     dbo.spot.id, SUM(dbo.WeldMeasurements.NbrWeld) AS countofWelds 
  --FROM            dbo.Spot INNER JOIN 
  --        dbo.WeldMeasurements ON dbo.Spot.ID = dbo.WeldMeasurements.SpotId  
  --WHERE        (dbo.WeldMeasurements.Date < GETDATE() AND dbo.WeldMeasurements.Date > WELDING.Qcontrol.[InspectionDate])  
  --GROUP BY dbo.spot.id 
  --UPDATE WELDING.Qcontrol 
  --SET WELDING.Qcontrol.WeldCounterFromLastUL = #TempTable7.CountofWelds 
  --FROM  WELDING.Qcontrol LEFT OUTER JOIN #TempTable7 ON WELDING.Qcontrol.spotid = #TempTable7.id 
  --delete temp table---- 
  --DROP TABLE #TempTable7 
  END