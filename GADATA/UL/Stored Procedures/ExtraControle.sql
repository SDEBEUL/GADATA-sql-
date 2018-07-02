-- =============================================
-- Author:		Coppejans Jens
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [UL].[ExtraControle]

AS
BEGIN

	SET NOCOUNT ON;

--------------------------------------------------------------------------------
------  info also update the tolerance bands parameters for adaptivity----------
--------------------------------------------------------------------------------
  --Update dbo.Weldparameters with values from rgulation and monitoring (p) !!!!!  to check out adaptivity --- 
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


---After update Weldparameter tables----- search after new spots out of adaptivity mode  --------
---------------------------------------------------------------------------------------------
 
								  
								  
CREATE table #uitadaptive ( spotid int, timerid int, status nchar(20), durationoff time, starttime datetime)								                         

insert into #uitadaptive


SELECT Uitadaptief.ID as spotID, Uitadaptief.TimerID, CASE WHEN Uitadaptief.reg = 0 AND  Uitadaptief.mon = 0 THEN 'Uit Adaptief' ELSE 'In adaptief' END as StatusAdaptive
, '00:00:00' as duration , GETDATE() as StartimeOFF

FROM     (SELECT dbo.Spot.ID, dbo.Spot.TimerID, dbo.WeldParameters.Value AS reg, WeldParameters_1.Value AS mon, dbo.Spot.Number
                  FROM      dbo.Spot INNER JOIN
                                    dbo.WeldParameters ON dbo.Spot.ID = dbo.WeldParameters.SpotID INNER JOIN
                                    dbo.WeldParameters AS WeldParameters_1 ON dbo.Spot.ID = WeldParameters_1.SpotID
                  WHERE   (dbo.WeldParameters.ParameterNameID = 43) AND (WeldParameters_1.ParameterNameID = 44) AND (dbo.Spot.Number BETWEEN 29999 AND 49999) AND 
                                    (WeldParameters_1.Value = 0) AND (dbo.WeldParameters.Value = 0) OR
                                    (dbo.WeldParameters.ParameterNameID = 43) AND (WeldParameters_1.ParameterNameID = 44) AND (dbo.Spot.Number BETWEEN 4400000 AND 4419999) AND 
                                    (WeldParameters_1.Value = 0) AND (dbo.WeldParameters.Value = 0)
									
									) AS Uitadaptief

--JOIN with the spots actually welding the last days----
--------------------------------------------------------

                                      inner join   (

SELECT  dbo.WeldMeasurements.SpotId, SUM(dbo.WeldMeasurements.NbrWeld) AS sum_of_Welds
FROM     dbo.WeldMeasurements INNER JOIN
                  dbo.Spot ON dbo.WeldMeasurements.SpotId = dbo.Spot.ID
WHERE  (dbo.Spot.Number BETWEEN 20000 AND 49999) AND (dbo.WeldMeasurements.Date >= GETDATE() - 3) OR
                  (dbo.Spot.Number BETWEEN 4400000 AND 4419999) AND (dbo.WeldMeasurements.Date >= GETDATE() - 3)
GROUP BY dbo.WeldMeasurements.SpotId 

                                                   )welds 
												   on Uitadaptief.ID = welds.SpotId

----Check if spot exists in table Uit_adaptive_start	---
											  
insert into ul.uitadaptive_start ( [SpotID]
                                 ,[TimerID]
                                 ,[StatusAdaptive]
                                 ,[DurationOFF]
							     ,[Starttime]      ) 
								 
								 SELECT #uitadaptive.spotid,#uitadaptive.timerid,#uitadaptive.status, #uitadaptive.durationoff, #uitadaptive.starttime 
								 from   #uitadaptive


								 LEFT OUTER JOIN
                         UL.UitAdaptive_start ON #uitadaptive.spotid = UL.UitAdaptive_start.SpotID
WHERE        (UL.UitAdaptive_start.starttime IS NULL)
												  

------------Update time uit adaptive-----------------------

UPDATE UL.UitAdaptive_start
SET UL.UitAdaptive_start.durationOFF = Dateadd(ss, 300, UL.UitAdaptive_start.durationOFF)
FROM ( select  #uitadaptive.durationoff   from #uitadaptive inner join UL.UitAdaptive_start ON  #uitadaptive.spotid =  UL.UitAdaptive_start.spotID )Queryupdate

--------Give END on spots back in adaptive mode------------

insert into ul.uitadaptive_end (  [SpotID]
                                 ,[TimerID]
                                 ,[text]
                                 ,[DurationOFF]
							     ,[Starttime]
								 ,[WMComment]
								 ,[EndTime]      ) 

SELECT UL.UitAdaptive_start.spotid, UL.UitAdaptive_start.timerID,UL.UitAdaptive_start.statusAdaptive, UL.UitAdaptive_start.DurationOFF, UL.UitAdaptive_start.starttime, null as WMcomment, getdate()
FROM UL.UitAdaptive_start LEFT OUTER JOIN #uitadaptive ON UL.UitAdaptive_start.spotID = #uitadaptive.spotid
WHERE #uitadaptive.starttime is null

--------delete spots back in adaptive in table start------------

DELETE from UL.UitAdaptive_start
from UL.UitAdaptive_start LEFT OUTER JOIN #uitadaptive ON UL.UitAdaptive_start.spotid = #uitadaptive.spotid
WHERE #uitadaptive.starttime is null

Drop table #uitadaptive

END


---delete from UL.UitAdaptive_start