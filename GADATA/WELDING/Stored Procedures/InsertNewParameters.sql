-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE welding.InsertNewParameters

AS
BEGIN

	SET NOCOUNT ON;
---insert if new parameter is found

insert into dbo.WeldParameters (ParameterNameID,SpotID,Value)
---npt22
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.180.162\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL)
union
---npt23
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.181.53\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union

      --NPT24--- OK  

SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.180.227\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union

--npt26

SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.181.154\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 

--npt26
union
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.181.155\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt28


SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.180.141\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt29
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.180.149\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL)
union
--npt30

SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.180.203\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 

union
--npt31
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.180.39\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt32
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.192.18\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt33
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([19.148.192.33\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName , dbo.ExtParamValues_V.value  , dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22  INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt40
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.240.10\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value , dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt31
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default 
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.240.11\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt42
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.240.12\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname  COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt43
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.240.13\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt50
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.225.199\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt51
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.225.197\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL)  
union
--npt52
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.225.198\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt53
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.240.14\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 

union
--npt54
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.225.200\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt55
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.226.5\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt56
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.225.133\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt57
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.203.138\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt58
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.226.7\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt59
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.226.8\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt70
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.227.69\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt71
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.222.197\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt72
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.225.135\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 
union
--npt73
SELECT        dbo.TimerParameterName.ID AS parameterID, dbo.Spot.ID AS spotid, NPT22.value COLLATE database_default
FROM            dbo.TimerParameterName INNER JOIN
                         OPENQUERY([10.249.222.198\bos_sqlserv_2005], 
                         ' SELECT        dbo.ExtParamValues_V.paramName, dbo.ExtParamValues_V.value, dbo.ExtSpotTable_V.spotname, dbo.ExtParamValues_V.param_ID FROM            dbo.ExtParamValues_V INNER JOIN                          dbo.ExtSpotTable_V ON dbo.ExtParamValues_V.timerName = dbo.ExtSpotTable_V.timerName AND                           dbo.ExtParamValues_V.subIndex = dbo.ExtSpotTable_V.weldProgNo WHERE       dbo.ExtParamValues_V.languageCode = 1   ')
                          AS NPT22 INNER JOIN
                         dbo.Spot ON NPT22.spotname COLLATE database_default = dbo.Spot.Number AND NPT22.spotname = dbo.Spot.Number INNER JOIN
                         dbo.SpotParameterFilter ON NPT22.paramName COLLATE database_default = dbo.SpotParameterFilter.Name ON 
                         dbo.TimerParameterName.Name = dbo.SpotParameterFilter.Name LEFT OUTER JOIN
                         dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID
WHERE        (dbo.WeldParameters.ParameterNameID IS NULL) 

END