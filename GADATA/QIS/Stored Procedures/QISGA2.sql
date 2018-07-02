-- =============================================
-- Author:		Coppejans Jens
-- Create date: <Create Date,,>
-- Description:	Qis Brownfield
-- =============================================
CREATE PROCEDURE [QIS].[QISGA2]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--make temp table
IF OBJECT_ID('#tempQisBrownfield') IS NOT NULL DROP TABLE #tempQisBrownfield

 Create table #tempQisBrownfield ([Timestamp] datetime
      ,[TimerName] nchar(25)
      ,[program] int
      ,[parameter] nchar(250)
      ,[bos6000Value] int
      ,[RequiredValue] int
      ,[remark] nchar(50) )

DECLARE @QueryspotCheck1 nvarchar(max),
        @QueryspotCheck2 nvarchar(max), 
        
		@SQL1 nvarchar(4000),
		@SQL2 nvarchar(4000),
		@SQL3 nvarchar(4000), 
        @ParameterNOK nvarchar(50),
		@QueryMidairCheck1 nvarchar(max),
		@QueryMidairCheck2 nvarchar(max), 
		@QueryGeneralCheck1 nvarchar(max),
		@QueryGeneralCheck2 nvarchar(max),

		@OPENQUERYNPT22 nvarchar(4000),
		@LinkedServerNPT22 nvarchar(4000),

		@OPENQUERYNPT23 nvarchar(4000),
		@LinkedServerNPT23 nvarchar(4000),

		@OPENQUERYNPT24 nvarchar(4000),
		@LinkedServerNPT24 nvarchar(4000),

		@OPENQUERYNPT26 nvarchar(4000),
		@LinkedServerNPT26 nvarchar(4000),

		@OPENQUERYNPT27 nvarchar(4000),
		@LinkedServerNPT27 nvarchar(4000),

		@OPENQUERYNPT28 nvarchar(4000),
		@LinkedServerNPT28 nvarchar(4000),

		@OPENQUERYNPT29 nvarchar(4000),
		@LinkedServerNPT29 nvarchar(4000),

		@OPENQUERYNPT30 nvarchar(4000),
		@LinkedServerNPT30 nvarchar(4000),

		@OPENQUERYNPT31 nvarchar(4000),
		@LinkedServerNPT31 nvarchar(4000),

		@OPENQUERYNPT32 nvarchar(4000),
		@LinkedServerNPT32 nvarchar(4000),

		@OPENQUERYNPT33 nvarchar(4000),
		@LinkedServerNPT33 nvarchar(4000)

					
SET @LinkedServerNPT22 = '[19.148.180.162\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT22 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT22 + ','''

SET @LinkedServerNPT23 = '[19.148.181.53\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT23 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT23 + ','''

SET @LinkedServerNPT24 = '[19.148.180.227\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT24 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT24 + ','''

SET @LinkedServerNPT26 = '[19.148.181.154\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT26 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT26 + ','''

SET @LinkedServerNPT27 = '[19.148.181.155\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT27 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT27 + ','''

SET @LinkedServerNPT28 = '[19.148.180.141\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT28 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT28 + ','''

SET @LinkedServerNPT29 = '[19.148.180.149\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT29 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT29 + ','''

SET @LinkedServerNPT30 = '[19.148.180.203\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT30 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT30 + ','''

SET @LinkedServerNPT31 = '[19.148.180.39\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT31 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT31 + ','''

SET @LinkedServerNPT32 = '[19.148.192.18\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT32 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT32 + ','''

SET @LinkedServerNPT33 = '[19.148.192.33\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT33 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT33 + ','''

SET @QueryspotCheck1 = 'INSERT INTO #tempQisBrownfield SELECT convert(datetime,Getdate(),102) as timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark
	FROM   (SELECT *  FROM   (SELECT tbl.timername,  tbl.program, tbl.text AS Parameter, tbl.value  AS [BOS6000 Value], welding.Qiscontrolparameters.value AS [required Value], welding.Qiscontrolparameters.minvalue, welding.Qiscontrolparameters.maxvalue, CASE  WHEN tbl.value = welding.Qiscontrolparameters.value OR tbl.value BETWEEN  welding.Qiscontrolparameters.minvalue AND    welding.Qiscontrolparameters.maxvalue THEN  ''Parameter OK''  ELSE ''Parameter NOK''   END  AS Remark                
	FROM   (' 
	SET @QueryspotCheck2 = 'AS derivedtbl_1) AS tbl INNER JOIN welding.Qiscontrolparameters ON tbl.param_id = welding.Qiscontrolparameters.parameter_id  WHERE  welding.Qiscontrolparameters .generalparameter = ''0'' ) tbl )QisCheck '
	
	
	SET @SQL1 = 'SELECT DISTINCT  [BOS_6000_DB].dbo.ExtParamValues_V.timerName, [BOS_6000_DB].dbo.ExtParamValues_V.subIndex AS Program, [BOS_6000_DB].dbo.ExtParamValues_V.value, [BOS_6000_DB].dbo.ExtParamValues_V.text, [BOS_6000_DB].dbo.ExtParamValues_V.param_ID 
	FROM  [BOS_6000_DB].dbo.ExtSpotTable_V INNER JOIN   [BOS_6000_DB].dbo.ExtParamValues_V ON [BOS_6000_DB].dbo.ExtSpotTable_V.timerName = [BOS_6000_DB].dbo.ExtParamValues_V.timerName AND   [BOS_6000_DB].dbo.ExtSpotTable_V.weldProgNo = [BOS_6000_DB].dbo.ExtParamValues_V.subIndex
	WHERE      ([BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1) and  [BOS_6000_DB].dbo.ExtParamValues_V.subIndex between 100 AND 235 '')'
SET 
@QueryMidairCheck1 = 
' INSERT INTO #tempQisBrownfield SELECT Getdate() AS Timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark FROM   (SELECT * from (SELECT tbl.timername,                 tbl.program,                 tbl.text                           AS Parameter,                 tbl.value                          AS [BOS6000 Value],                 welding.Qiscontrolparameters.value AS [required Value],                 welding.Qiscontrolparameters.minvalue,                 welding.Qiscontrolparameters.maxvalue,                 CASE                   WHEN tbl.value = welding.Qiscontrolparameters.value THEN                   ''Parameter OK''                   ELSE ''Parameter NOK''                END                                AS remark         FROM   ('
SET @QueryMidairCheck2 = '  AS derivedtbl_1) AS tbl  INNER JOIN welding.Qiscontrolparameters          ON tbl.param_id = welding.Qiscontrolparameters.parameter_id   WHERE  welding.Qiscontrolparameters.midairparameter = 1) tbl) Qischeck '
SET @SQL2 = 
'SELECT DISTINCT  [BOS_6000_DB].dbo.ExtParamValues_V.timerName, [BOS_6000_DB].dbo.ExtParamValues_V.subIndex AS Program, [BOS_6000_DB].dbo.ExtParamValues_V.value, [BOS_6000_DB].dbo.ExtParamValues_V.text, [BOS_6000_DB].dbo.ExtParamValues_V.param_ID FROM  [BOS_6000_DB].dbo.ExtSpotTable_V INNER JOIN      [BOS_6000_DB].dbo.ExtParamValues_V ON [BOS_6000_DB].dbo.ExtSpotTable_V.timerName = [BOS_6000_DB].dbo.ExtParamValues_V.timerName AND    [BOS_6000_DB].dbo.ExtSpotTable_V.weldProgNo = [BOS_6000_DB].dbo.ExtParamValues_V.subIndex WHERE        ([BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1) and  [BOS_6000_DB].dbo.ExtParamValues_V.subIndex between 237 AND 254'')'
SET @QueryGeneralCheck1 =
' INSERT INTO #tempQisBrownfield SELECT  convert(datetime,Getdate(),102) AS Timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark FROM   (SELECT * from (SELECT tbl.timername,                 tbl.program,                 tbl.text                           AS Parameter,                 tbl.value                          AS [BOS6000 Value],                 welding.Qiscontrolparameters.value AS [required Value],                 welding.Qiscontrolparameters.minvalue,                 welding.Qiscontrolparameters.maxvalue,                 CASE                   WHEN tbl.value = welding.Qiscontrolparameters.value THEN                   ''Parameter OK''                   ELSE ''Parameter NOK''                END                                AS remark         FROM   ('
SET @QueryGeneralCheck2 = ' AS derivedtbl_1) AS tbl INNER JOIN welding.Qiscontrolparameters ON tbl.param_id = welding.Qiscontrolparameters.parameter_id)tbl)QisCheck '
SET @SQL3 = 
'SELECT DISTINCT                           [BOS_6000_DB].[dbo].[ExtParamValues_V].timerName, [ExtParamValues_V].[subindex] AS Program, [BOS_6000_DB].[dbo].[ExtParamValues_V].value,  [BOS_6000_DB].[dbo].[ExtParamValues_V].param_id,  [BOS_6000_DB].[dbo].[ExtParamValues_V].text  FROM  [BOS_6000_DB].[dbo].[ExtParamValues_V]  WHERE [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2305 or [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2306 or [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2307''  )'
SET
 @ParameterNOK =
 'WHERE  Qischeck.remark = ''PARAMETER NOK'' ' 

 ---brownfield Querys

exec (@QueryspotCheck1 + @OPENQUERYNPT22+@SQL1 + @QueryspotCheck2 + @ParameterNOK ) 
exec (@QueryMidairCheck1 + @OPENQUERYNPT22+@SQL2 + @QueryMidairCheck2 + @ParameterNOK ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT22+@SQL3 + @QueryGeneralCheck2 + @ParameterNOK ) 
exec (@QueryspotCheck1 + @OPENQUERYNPT23+@SQL1 + @QueryspotCheck2 + @ParameterNOK ) 
exec (@QueryMidairCheck1 + @OPENQUERYNPT23+@SQL2 + @QueryMidairCheck2 + @ParameterNOK ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT23+@SQL3 + @QueryGeneralCheck2 + @ParameterNOK ) 
exec (@QueryspotCheck1 + @OPENQUERYNPT24+@SQL1 + @QueryspotCheck2 + @ParameterNOK ) 
exec (@QueryMidairCheck1 + @OPENQUERYNPT24+@SQL2 + @QueryMidairCheck2 + @ParameterNOK ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT24+@SQL3 + @QueryGeneralCheck2 + @ParameterNOK ) 
exec (@QueryspotCheck1 + @OPENQUERYNPT26+@SQL1 + @QueryspotCheck2 + @ParameterNOK ) 
exec (@QueryMidairCheck1 + @OPENQUERYNPT26+@SQL2 + @QueryMidairCheck2 + @ParameterNOK ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT26+@SQL3 + @QueryGeneralCheck2 + @ParameterNOK ) 
exec (@QueryspotCheck1 + @OPENQUERYNPT27+@SQL1 + @QueryspotCheck2 + @ParameterNOK ) 
exec (@QueryMidairCheck1 + @OPENQUERYNPT27+@SQL2 + @QueryMidairCheck2 + @ParameterNOK ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT27+@SQL3 + @QueryGeneralCheck2 + @ParameterNOK ) 
exec (@QueryspotCheck1 + @OPENQUERYNPT28+@SQL1 + @QueryspotCheck2 + @ParameterNOK ) 
exec (@QueryMidairCheck1 + @OPENQUERYNPT28+@SQL2 + @QueryMidairCheck2 + @ParameterNOK ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT28+@SQL3 + @QueryGeneralCheck2 + @ParameterNOK ) 
exec (@QueryspotCheck1 + @OPENQUERYNPT29+@SQL1 + @QueryspotCheck2 + @ParameterNOK ) 
exec (@QueryMidairCheck1 + @OPENQUERYNPT29+@SQL2 + @QueryMidairCheck2 + @ParameterNOK ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT29+@SQL3 + @QueryGeneralCheck2 + @ParameterNOK ) 
exec (@QueryspotCheck1 + @OPENQUERYNPT30+@SQL1 + @QueryspotCheck2 + @ParameterNOK ) 
exec (@QueryMidairCheck1 + @OPENQUERYNPT30+@SQL2 + @QueryMidairCheck2 + @ParameterNOK ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT30+@SQL3 + @QueryGeneralCheck2 + @ParameterNOK ) 
exec (@QueryspotCheck1 + @OPENQUERYNPT31+@SQL1 + @QueryspotCheck2 + @ParameterNOK ) 
exec (@QueryMidairCheck1 + @OPENQUERYNPT31+@SQL2 + @QueryMidairCheck2 + @ParameterNOK ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT31+@SQL3 + @QueryGeneralCheck2 + @ParameterNOK ) 
exec (@QueryspotCheck1 + @OPENQUERYNPT32+@SQL1 + @QueryspotCheck2 + @ParameterNOK ) 
exec (@QueryMidairCheck1 + @OPENQUERYNPT32+@SQL2 + @QueryMidairCheck2 + @ParameterNOK ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT32+@SQL3 + @QueryGeneralCheck2 + @ParameterNOK ) 
exec (@QueryspotCheck1 + @OPENQUERYNPT33+@SQL1 + @QueryspotCheck2 + @ParameterNOK ) 
exec (@QueryMidairCheck1 + @OPENQUERYNPT33+@SQL2 + @QueryMidairCheck2 + @ParameterNOK ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT33+@SQL3 + @QueryGeneralCheck2 + @ParameterNOK ) 







---select * from #tempQisBrownfield WHERE TimerName <> 'test'
--insert the new qis data into QIS.QISLOG_GA2
insert into QIS.QISLOG_GA2

SELECT         #tempQisBrownfield.Timestamp AS temptime,  #tempQisBrownfield.TimerName AS tempTimer,  #tempQisBrownfield.program AS tempprogram, 
                          #tempQisBrownfield.parameter AS tempparameter,  #tempQisBrownfield.bos6000Value AS tempBos6000Value,  #tempQisBrownfield.RequiredValue AS tempValue, 
                          #tempQisBrownfield.remark AS tempRemark
FROM            QIS.QISLOG_GA2 RIGHT OUTER JOIN
                        #tempQisBrownfield ON QIS.QISLOG_GA2.parameter =  #tempQisBrownfield.parameter AND QIS.QISLOG_GA2.program =  #tempQisBrownfield.program AND 
                         QIS.QISLOG_GA2.TimerName =  #tempQisBrownfield.TimerName
WHERE        (QIS.QISLOG_GA2.TimerName IS NULL) AND (QIS.QISLOG_GA2.program IS NULL) AND (QIS.QISLOG_GA2.parameter IS NULL) AND ( #tempQisBrownfield.TimerName <> N'test')
--insert the old Qis data 
Delete from QIS.QISLOG_GA2

FROM            QIS.QISLOG_GA2 LEFT OUTER JOIN
                         #tempQisBrownfield ON QIS.QISLOG_GA2.parameter = #tempQisBrownfield.parameter AND QIS.QISLOG_GA2.program = #tempQisBrownfield.program AND 
                         QIS.QISLOG_GA2.TimerName = #tempQisBrownfield.TimerName
WHERE        (#tempQisBrownfield.Timestamp IS NULL) AND (#tempQisBrownfield.TimerName IS NULL) AND (#tempQisBrownfield.program IS NULL) AND (#tempQisBrownfield.parameter IS NULL) 

delete from QIS.QISLOG_GA2
--delete the recording data
--SELECT        QIS.QISLOG_GA2.Timestamp, QIS.QISLOG_GA2.TimerName, QIS.QISLOG_GA2.program, QIS.QISLOG_GA2.parameter, QIS.QISLOG_GA2.bos6000Value, QIS.QISLOG_GA2.RequiredValue, 
     --                    QIS.QISLOG_GA2.remark
FROM            QIS.QISLOG_GA2 LEFT OUTER JOIN
                         QIS.QISLOG_GA2 AS Qis_1 ON QIS.QISLOG_GA2.TimerName = Qis_1.TimerName AND QIS.QISLOG_GA2.program = Qis_1.program
WHERE        (QIS.QISLOG_GA2.parameter LIKE N'regulation (P)%') AND (QIS.QISLOG_GA2.bos6000Value = 0) AND (Qis_1.bos6000Value = 0) AND 
                         (Qis_1.parameter LIKE N'Monitoring (P)%') OR
                         (QIS.QISLOG_GA2.parameter LIKE N'Monitoring (P)%') AND (QIS.QISLOG_GA2.bos6000Value = 0) AND (Qis_1.bos6000Value = 0) AND 
                         (Qis_1.parameter LIKE N'regulation (P)%')


drop table #tempQisBrownfield
END