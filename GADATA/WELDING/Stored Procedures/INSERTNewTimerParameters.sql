-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE welding.INSERTNewTimerParameters
AS
BEGIN

	SET NOCOUNT ON;


insert into dbo.TimerParameters ([ParameterNameID]
      ,[TimerID]
      ,[Value]
      ,[electrode])
---npt22
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.180.162\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                         AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt23
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.181.53\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                         AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt24
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.180.227\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt26
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.181.154\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                    AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName  collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt27
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.181.155\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                         AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt28
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.180.141\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt29
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.180.149\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt30
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.180.203\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                       AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt31
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.180.39\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                     AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt32
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.192.18\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                    AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt33
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.192.33\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                   AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt40
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.240.10\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                  AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt41
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.240.11\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                         AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt42
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.240.12\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                        AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt43
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.240.13\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                   AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt50
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.225.199\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
               AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt51
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.225.197\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                  AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt52
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.225.198\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                       AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt53
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.240.14\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
        AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt54
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.225.200\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
          AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName  collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt55
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.226.5\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                 AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt56
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.225.133\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
              AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt57
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.203.138\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                      AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt58
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.226.7\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                     AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt59
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.226.8\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                       AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt70
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.227.69\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                     AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt71
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.222.197\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                   AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt72
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.225.135\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                     AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName  collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
union
--npt73
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Timer.ID AS timerID, npt22.value collate database_default, npt22.subindex AS electrode
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.222.198\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                   AS npt22 INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name ON dbo.TimerParameterName.LocalDbID = npt22.param_ID LEFT OUTER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID
WHERE        (dbo.TimerParameterName.IsElectrodeData = 1) AND (dbo.TimerParameters.ParameterNameID IS NULL)
END