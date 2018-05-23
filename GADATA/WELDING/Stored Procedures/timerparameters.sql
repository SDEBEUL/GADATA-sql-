-- =============================================
-- Author:		Coppejans Jens
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE welding.timerparameters

AS
BEGIN

	SET NOCOUNT ON;
--NPT22
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([19.148.180.162\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT23
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([19.148.181.53\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT24
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([19.148.180.227\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID

--NPT26
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([19.148.181.154\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT27
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([19.148.181.155\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT28
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([19.148.180.141\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT29
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([19.148.180.149\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT30
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([19.148.180.203\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT31
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([19.148.180.39\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT32
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([19.148.192.18\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT33
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([19.148.192.33\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
---greenfield
--NPT40
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([10.249.240.10\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT41
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([10.249.240.11\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT42
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([10.249.240.12\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT43
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([10.249.240.13\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT50
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([10.249.225.199\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT51
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([10.249.225.197\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT52
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([10.249.225.198\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT53
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([10.249.240.14\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT54
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([10.249.225.200\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT55
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([10.249.226.5\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT56
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([10.249.225.133\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT57
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([10.249.203.138\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT58
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([10.249.226.7\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT59
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([10.249.226.8\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT70
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([10.249.227.69\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT71
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([10.249.222.197\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT72
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([10.249.225.135\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID
--NPT73
UPDATE dbo.TimerParameters
SET dbo.TimerParameters.Value = NPT22.Value 

FROM            OPENQUERY([10.249.222.198\bos_sqlserv_2005], 
                         'select [timerName]
      ,[subindex]
      ,[param_ID]
      ,[value]
  FROM [BOS_6000_DB].[dbo].[ExtParamValues_RDS_V]
WHERE        [dbo].[ExtParamValues_RDS_V].languageCode = 1 AND subIndex BETWEEN 1 AND 5
')
                          AS npt22 INNER JOIN
                         dbo.TimerParameterName ON npt22.param_ID = dbo.TimerParameterName.LocalDbID INNER JOIN
                         dbo.Timer ON npt22.timerName collate database_default = dbo.Timer.Name INNER JOIN
                         dbo.TimerParameters ON dbo.TimerParameterName.ID = dbo.TimerParameters.ParameterNameID AND dbo.Timer.ID = dbo.TimerParameters.TimerID

END