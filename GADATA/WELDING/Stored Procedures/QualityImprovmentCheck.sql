-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [WELDING].[QualityImprovmentCheck]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--make temp table
IF OBJECT_ID('#tempQischeck') IS NOT NULL DROP TABLE #tempQischeck

 Create table #tempQischeck ([Timestamp] datetime
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

SET @QueryspotCheck1 = 'INSERT INTO #tempQischeck SELECT convert(datetime,Getdate(),102) as timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark
	FROM   (SELECT *  FROM   (SELECT tbl.timername,  tbl.program, tbl.text AS Parameter, tbl.value  AS [BOS6000 Value], welding.qiscontrolparameters.value AS [required Value], welding.qiscontrolparameters.minvalue, welding.qiscontrolparameters.maxvalue, CASE  WHEN tbl.value = welding.qiscontrolparameters.value OR tbl.value BETWEEN  welding.qiscontrolparameters.minvalue AND    welding.qiscontrolparameters.maxvalue THEN  ''Parameter OK''  ELSE ''Parameter NOK''   END  AS Remark                
	FROM   (' 
	SET @QueryspotCheck2 = 'AS derivedtbl_1) AS tbl INNER JOIN welding.qiscontrolparameters ON tbl.param_id = welding.qiscontrolparameters.parameter_id  WHERE  welding.qiscontrolparameters .generalparameter = ''0'' ) tbl )QisCheck '
	
	
	SET @SQL1 = 'SELECT DISTINCT  [BOS_6000_DB].dbo.ExtParamValues_V.timerName, [BOS_6000_DB].dbo.ExtParamValues_V.subIndex AS Program, [BOS_6000_DB].dbo.ExtParamValues_V.value, [BOS_6000_DB].dbo.ExtParamValues_V.text, [BOS_6000_DB].dbo.ExtParamValues_V.param_ID 
	FROM  [BOS_6000_DB].dbo.ExtSpotTable_V INNER JOIN   [BOS_6000_DB].dbo.ExtParamValues_V ON [BOS_6000_DB].dbo.ExtSpotTable_V.timerName = [BOS_6000_DB].dbo.ExtParamValues_V.timerName AND   [BOS_6000_DB].dbo.ExtSpotTable_V.weldProgNo = [BOS_6000_DB].dbo.ExtParamValues_V.subIndex
	WHERE      ([BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1) and  [BOS_6000_DB].dbo.ExtParamValues_V.subIndex between 100 AND 235 '')'
SET 
@QueryMidairCheck1 = 
' INSERT INTO #tempQischeck SELECT Getdate() AS Timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark FROM   (SELECT * from (SELECT tbl.timername,                 tbl.program,                 tbl.text                           AS Parameter,                 tbl.value                          AS [BOS6000 Value],                 welding.qiscontrolparameters.value AS [required Value],                 welding.qiscontrolparameters.minvalue,                 welding.qiscontrolparameters.maxvalue,                 CASE                   WHEN tbl.value = welding.qiscontrolparameters.value THEN                   ''Parameter OK''                   ELSE ''Parameter NOK''                END                                AS remark         FROM   ('
SET @QueryMidairCheck2 = '  AS derivedtbl_1) AS tbl  INNER JOIN welding.qiscontrolparameters          ON tbl.param_id = welding.qiscontrolparameters.parameter_id   WHERE  welding.qiscontrolparameters.midairparameter = 1) tbl) Qischeck '
SET @SQL2 = 
'SELECT DISTINCT  [BOS_6000_DB].dbo.ExtParamValues_V.timerName, [BOS_6000_DB].dbo.ExtParamValues_V.subIndex AS Program, [BOS_6000_DB].dbo.ExtParamValues_V.value, [BOS_6000_DB].dbo.ExtParamValues_V.text, [BOS_6000_DB].dbo.ExtParamValues_V.param_ID FROM  [BOS_6000_DB].dbo.ExtSpotTable_V INNER JOIN      [BOS_6000_DB].dbo.ExtParamValues_V ON [BOS_6000_DB].dbo.ExtSpotTable_V.timerName = [BOS_6000_DB].dbo.ExtParamValues_V.timerName AND    [BOS_6000_DB].dbo.ExtSpotTable_V.weldProgNo = [BOS_6000_DB].dbo.ExtParamValues_V.subIndex WHERE        ([BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1) and  [BOS_6000_DB].dbo.ExtParamValues_V.subIndex between 237 AND 254'')'
SET @QueryGeneralCheck1 =
' INSERT INTO #tempQischeck SELECT  convert(datetime,Getdate(),102) AS Timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark FROM   (SELECT * from (SELECT tbl.timername,                 tbl.program,                 tbl.text                           AS Parameter,                 tbl.value                          AS [BOS6000 Value],                 welding.qiscontrolparameters.value AS [required Value],                 welding.qiscontrolparameters.minvalue,                 welding.qiscontrolparameters.maxvalue,                 CASE                   WHEN tbl.value = welding.qiscontrolparameters.value THEN                   ''Parameter OK''                   ELSE ''Parameter NOK''                END                                AS remark         FROM   ('
SET @QueryGeneralCheck2 = ' AS derivedtbl_1) AS tbl INNER JOIN welding.qiscontrolparameters ON tbl.param_id = welding.qiscontrolparameters.parameter_id)tbl)QisCheck '
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


DECLARE @QueryspotCheck1a nvarchar(max),
        @QueryspotCheck2a nvarchar(max), 
        
		@SQL1a nvarchar(4000),
		@SQL2a nvarchar(4000),
		@SQL3a nvarchar(4000), 
        @ParameterNOKa nvarchar(50),
		@QueryMidairCheck1a nvarchar(max),
		@QueryMidairCheck2a nvarchar(max), 
		@QueryGeneralCheck1a nvarchar(max),
		@QueryGeneralCheck2a nvarchar(max),

		@OPENQUERYNPT40 nvarchar(4000),
		@LinkedServerNPT40 nvarchar(4000),

		@OPENQUERYNPT41 nvarchar(4000),
		@LinkedServerNPT41 nvarchar(4000),

		--@OPENQUERYNPT42 nvarchar(4000),
		--@LinkedServerNPT42 nvarchar(4000),

		@OPENQUERYNPT43 nvarchar(4000),
		@LinkedServerNPT43 nvarchar(4000),

		@OPENQUERYNPT70 nvarchar(4000),
		@LinkedServerNPT70 nvarchar(4000),

		@OPENQUERYNPT71 nvarchar(4000),
		@LinkedServerNPT71 nvarchar(4000),

		@OPENQUERYNPT72 nvarchar(4000),
		@LinkedServerNPT72 nvarchar(4000),

		@OPENQUERYNPT73 nvarchar(4000),
		@LinkedServerNPT73 nvarchar(4000)



					
SET @LinkedServerNPT40 = '[10.249.240.10\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT40 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT40 + ','''

SET @LinkedServerNPT41 = '[10.249.240.11\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT41 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT41 + ','''

--SET @LinkedServerNPT42 = '[10.249.240.12\BOS_SQLSERV_2005]'
--SET @OPENQUERYNPT42 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT42 + ','''

SET @LinkedServerNPT43 = '[10.249.240.13\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT43 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT43 + ','''

SET @LinkedServerNPT70 = '[10.249.227.69\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT70 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT70 + ','''

SET @LinkedServerNPT71 = '[10.249.222.197\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT71 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT71 + ','''

SET @LinkedServerNPT72 = '[10.249.225.135\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT72 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT72 + ','''

SET @LinkedServerNPT73 = '[10.249.222.198\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT73 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT73 + ','''



SET @QueryspotCheck1a = 'INSERT INTO #tempQischeck SELECT convert(datetime,Getdate(),102) as timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark
	FROM   (SELECT *  FROM   (SELECT tbl.timername,  tbl.program, tbl.text AS Parameter, tbl.value  AS [BOS6000 Value], welding.qiscontrolparameters.value AS [required Value], welding.qiscontrolparameters.minvalue, welding.qiscontrolparameters.maxvalue, CASE  WHEN tbl.value = welding.qiscontrolparameters.value OR tbl.value BETWEEN  welding.qiscontrolparameters.minvalue AND    welding.qiscontrolparameters.maxvalue THEN  ''Parameter OK''  ELSE ''Parameter NOK''   END  AS Remark                
	FROM   (' 
	SET @QueryspotCheck2a = 'AS derivedtbl_1) AS tbl INNER JOIN welding.qiscontrolparameters ON tbl.param_id = welding.qiscontrolparameters.parameter_id  WHERE  welding.qiscontrolparameters .generalparameter = ''0'' ) tbl )QisCheck '
	
	
	SET @SQL1a = 'SELECT DISTINCT  [BOS_6000_DB].dbo.ExtParamValues_V.timerName, [BOS_6000_DB].dbo.ExtParamValues_V.subIndex AS Program, [BOS_6000_DB].dbo.ExtParamValues_V.value, [BOS_6000_DB].dbo.ExtParamValues_V.text, [BOS_6000_DB].dbo.ExtParamValues_V.param_ID 
	FROM  [BOS_6000_DB].dbo.ExtSpotTable_V INNER JOIN   [BOS_6000_DB].dbo.ExtParamValues_V ON [BOS_6000_DB].dbo.ExtSpotTable_V.timerName = [BOS_6000_DB].dbo.ExtParamValues_V.timerName AND   [BOS_6000_DB].dbo.ExtSpotTable_V.weldProgNo = [BOS_6000_DB].dbo.ExtParamValues_V.subIndex
	WHERE      ([BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1) and  [BOS_6000_DB].dbo.ExtParamValues_V.subIndex between 80 AND 200 '')'
SET 
@QueryMidairCheck1a = 
' INSERT INTO #tempQischeck SELECT Getdate() AS Timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark FROM   (SELECT * from (SELECT tbl.timername,                 tbl.program,                 tbl.text                           AS Parameter,                 tbl.value                          AS [BOS6000 Value],                 welding.qiscontrolparameters.value AS [required Value],                 welding.qiscontrolparameters.minvalue,                 welding.qiscontrolparameters.maxvalue,                 CASE                   WHEN tbl.value = welding.qiscontrolparameters.value THEN                   ''Parameter OK''                   ELSE ''Parameter NOK''                END                                AS remark         FROM   ('
SET @QueryMidairCheck2a = '  AS derivedtbl_1) AS tbl  INNER JOIN welding.qiscontrolparameters          ON tbl.param_id = welding.qiscontrolparameters.parameter_id   WHERE  welding.qiscontrolparameters.midairparameter = 1) tbl) Qischeck '
SET @SQL2a = 
'SELECT DISTINCT  [BOS_6000_DB].dbo.ExtParamValues_V.timerName, [BOS_6000_DB].dbo.ExtParamValues_V.subIndex AS Program, [BOS_6000_DB].dbo.ExtParamValues_V.value, [BOS_6000_DB].dbo.ExtParamValues_V.text, [BOS_6000_DB].dbo.ExtParamValues_V.param_ID FROM  [BOS_6000_DB].dbo.ExtSpotTable_V INNER JOIN      [BOS_6000_DB].dbo.ExtParamValues_V ON [BOS_6000_DB].dbo.ExtSpotTable_V.timerName = [BOS_6000_DB].dbo.ExtParamValues_V.timerName AND    [BOS_6000_DB].dbo.ExtSpotTable_V.weldProgNo = [BOS_6000_DB].dbo.ExtParamValues_V.subIndex  WHERE        ([BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1) and  [BOS_6000_DB].dbo.ExtParamValues_V.subIndex = 253'')'
SET @QueryGeneralCheck1a =
' INSERT INTO #tempQischeck SELECT  convert(datetime,Getdate(),102) AS Timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark FROM   (SELECT * from (SELECT tbl.timername,                 tbl.program,                 tbl.text                           AS Parameter,                 tbl.value                          AS [BOS6000 Value],                 welding.qiscontrolparameters.value AS [required Value],                 welding.qiscontrolparameters.minvalue,                 welding.qiscontrolparameters.maxvalue,                 CASE                   WHEN tbl.value = welding.qiscontrolparameters.value THEN                   ''Parameter OK''                   ELSE ''Parameter NOK''                END                                AS remark         FROM   ('
SET @QueryGeneralCheck2a = ' AS derivedtbl_1) AS tbl INNER JOIN welding.qiscontrolparameters ON tbl.param_id = welding.qiscontrolparameters.parameter_id)tbl)QisCheck '
SET @SQL3a = 
'SELECT DISTINCT                           [BOS_6000_DB].[dbo].[ExtParamValues_V].timerName, [ExtParamValues_V].[subindex] AS Program, [BOS_6000_DB].[dbo].[ExtParamValues_V].value,  [BOS_6000_DB].[dbo].[ExtParamValues_V].param_id,  [BOS_6000_DB].[dbo].[ExtParamValues_V].text  FROM  [BOS_6000_DB].[dbo].[ExtParamValues_V]  WHERE [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2305 or [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2306 or [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2307''  )'
SET
 @ParameterNOKa =
 'WHERE  Qischeck.remark = ''PARAMETER NOK'' ' 

  ---brownfield LKN_Wooshin

exec (@QueryspotCheck1a + @OPENQUERYNPT40+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT40+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1a + @OPENQUERYNPT40+@SQL3a + @QueryGeneralCheck2a + @ParameterNOKa ) 
exec (@QueryspotCheck1a + @OPENQUERYNPT41+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT41+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1a + @OPENQUERYNPT41+@SQL3a + @QueryGeneralCheck2a + @ParameterNOKa ) 
--exec (@QueryspotCheck1 + @OPENQUERYNPT42+@SQL1 + @QueryspotCheck2 + @ParameterNOK ) 
--exec (@QueryMidairCheck1 + @OPENQUERYNPT42+@SQL2 + @QueryMidairCheck2 + @ParameterNOK ) 
--exec (@QueryGeneralCheck1 + @OPENQUERYNPT42+@SQL3 + @QueryGeneralCheck2 + @ParameterNOK ) 
exec (@QueryspotCheck1a + @OPENQUERYNPT43+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT43+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT43+@SQL3a + @QueryGeneralCheck2a + @ParameterNOKa ) 
exec (@QueryspotCheck1a + @OPENQUERYNPT70+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT70+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT70+@SQL3a + @QueryGeneralCheck2a + @ParameterNOKa ) 
exec (@QueryspotCheck1a + @OPENQUERYNPT71+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT71+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT71+@SQL3a + @QueryGeneralCheck2a + @ParameterNOKa ) 
exec (@QueryspotCheck1a + @OPENQUERYNPT72+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT72+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT72+@SQL3a + @QueryGeneralCheck2a + @ParameterNOKa ) 
exec (@QueryspotCheck1a + @OPENQUERYNPT73+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT73+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT73+@SQL3a + @QueryGeneralCheck2a + @ParameterNOKa ) 



DECLARE @QueryspotCheck1b nvarchar(max),
        @QueryspotCheck2b nvarchar(max), 
        
		@SQL1b nvarchar(4000),
		@SQL2b nvarchar(4000),
		@SQL3b nvarchar(4000), 
        @ParameterNOKb nvarchar(50),
		@QueryMidairCheck1b nvarchar(max),
		@QueryMidairCheck2b nvarchar(max), 
		@QueryGeneralCheck1b nvarchar(max),
		@QueryGeneralCheck2b nvarchar(max),

		@OPENQUERYNPT50 nvarchar(4000),
		@LinkedServerNPT50 nvarchar(4000),

		@OPENQUERYNPT51 nvarchar(4000),
		@LinkedServerNPT51 nvarchar(4000),

		@OPENQUERYNPT52 nvarchar(4000),
		@LinkedServerNP52 nvarchar(4000),

		@OPENQUERYNPT53 nvarchar(4000),
		@LinkedServerNPT53 nvarchar(4000),

		@OPENQUERYNPT54 nvarchar(4000),
		@LinkedServerNPT54 nvarchar(4000),

		@OPENQUERYNPT55 nvarchar(4000),
		@LinkedServerNPT55 nvarchar(4000),

		@OPENQUERYNPT56 nvarchar(4000),
		@LinkedServerNPT56 nvarchar(4000),

		@OPENQUERYNPT57 nvarchar(4000),
		@LinkedServerNPT57 nvarchar(4000),

		@OPENQUERYNPT58 nvarchar(4000),
		@LinkedServerNPT58 nvarchar(4000),

		@OPENQUERYNPT59 nvarchar(4000),
		@LinkedServerNPT59 nvarchar(4000)



					
SET @LinkedServerNPT50 = '[10.249.225.199\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT50 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT50 + ','''

SET @LinkedServerNPT51 = '[10.249.225.197\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT51 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT51 + ','''

SET @LinkedServerNP52 = '[10.249.225.198\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT52 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNP52 + ','''

SET @LinkedServerNPT53 = '[10.249.240.14\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT53 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT53 + ','''

SET @LinkedServerNPT54 = '[10.249.225.200\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT54 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT54 + ','''

SET @LinkedServerNPT55 = '[10.249.226.5\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT55 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT55 + ','''

SET @LinkedServerNPT56 = '[10.249.225.133\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT56 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT56 + ','''

SET @LinkedServerNPT57 = '[10.249.203.138\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT57 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT57 + ','''

SET @LinkedServerNPT58 = '[10.249.226.7\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT58 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT58 + ','''

SET @LinkedServerNPT59 = '[10.249.226.8\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT59 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT59 + ','''



SET @QueryspotCheck1b = 'INSERT INTO #tempQischeck SELECT convert(datetime,Getdate(),102) as timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark
	FROM   (SELECT *  FROM   (SELECT tbl.timername,  tbl.program, tbl.text AS Parameter, tbl.value  AS [BOS6000 Value], welding.qiscontrolparameters.value AS [required Value], welding.qiscontrolparameters.minvalue, welding.qiscontrolparameters.maxvalue, CASE  WHEN tbl.value = welding.qiscontrolparameters.value OR tbl.value BETWEEN  welding.qiscontrolparameters.minvalue AND    welding.qiscontrolparameters.maxvalue THEN  ''Parameter OK''  ELSE ''Parameter NOK''   END  AS Remark                
	FROM   (' 
	SET @QueryspotCheck2b = 'AS derivedtbl_1) AS tbl INNER JOIN welding.qiscontrolparameters ON tbl.param_id = welding.qiscontrolparameters.parameter_id  WHERE  welding.qiscontrolparameters .generalparameter = ''0'' ) tbl )QisCheck '
	
	
	SET @SQL1b = 'SELECT DISTINCT  [BOS_6000_DB].dbo.ExtParamValues_V.timerName, [BOS_6000_DB].dbo.ExtParamValues_V.subIndex AS Program, [BOS_6000_DB].dbo.ExtParamValues_V.value, [BOS_6000_DB].dbo.ExtParamValues_V.text, [BOS_6000_DB].dbo.ExtParamValues_V.param_ID 
	FROM  [BOS_6000_DB].dbo.ExtSpotTable_V INNER JOIN   [BOS_6000_DB].dbo.ExtParamValues_V ON [BOS_6000_DB].dbo.ExtSpotTable_V.timerName = [BOS_6000_DB].dbo.ExtParamValues_V.timerName AND   [BOS_6000_DB].dbo.ExtSpotTable_V.weldProgNo = [BOS_6000_DB].dbo.ExtParamValues_V.subIndex
	WHERE      ([BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1) and  [BOS_6000_DB].dbo.ExtParamValues_V.subIndex between 80 AND 200 '')'
SET 
@QueryMidairCheck1b = 
' INSERT INTO #tempQischeck SELECT Getdate() AS Timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark FROM   (SELECT * from (SELECT tbl.timername,                 tbl.program,                 tbl.text                           AS Parameter,                 tbl.value                          AS [BOS6000 Value],                 welding.qiscontrolparameters.value AS [required Value],                 welding.qiscontrolparameters.minvalue,                 welding.qiscontrolparameters.maxvalue,                 CASE                   WHEN tbl.value = welding.qiscontrolparameters.value THEN                   ''Parameter OK''                   ELSE ''Parameter NOK''                END                                AS remark         FROM   ('
SET @QueryMidairCheck2b = '  AS derivedtbl_1) AS tbl  INNER JOIN welding.qiscontrolparameters          ON tbl.param_id = welding.qiscontrolparameters.parameter_id   WHERE  welding.qiscontrolparameters.midairparameter = 1) tbl) Qischeck '
SET @SQL2b = 
'SELECT DISTINCT  [BOS_6000_DB].dbo.ExtParamValues_V.timerName, [BOS_6000_DB].dbo.ExtParamValues_V.subIndex AS Program, [BOS_6000_DB].dbo.ExtParamValues_V.value, [BOS_6000_DB].dbo.ExtParamValues_V.text, [BOS_6000_DB].dbo.ExtParamValues_V.param_ID FROM  [BOS_6000_DB].dbo.ExtSpotTable_V INNER JOIN      [BOS_6000_DB].dbo.ExtParamValues_V ON [BOS_6000_DB].dbo.ExtSpotTable_V.timerName = [BOS_6000_DB].dbo.ExtParamValues_V.timerName AND    [BOS_6000_DB].dbo.ExtSpotTable_V.weldProgNo = [BOS_6000_DB].dbo.ExtParamValues_V.subIndex WHERE        ([BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1) and  [BOS_6000_DB].dbo.ExtParamValues_V.subIndex = 253'')'
SET @QueryGeneralCheck1b =
' INSERT INTO #tempQischeck SELECT  convert(datetime,Getdate(),102) AS Timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark FROM   (SELECT * from (SELECT tbl.timername,                 tbl.program,                 tbl.text                           AS Parameter,                 tbl.value                          AS [BOS6000 Value],                 welding.qiscontrolparameters.value AS [required Value],                 welding.qiscontrolparameters.minvalue,                 welding.qiscontrolparameters.maxvalue,                 CASE                   WHEN tbl.value = welding.qiscontrolparameters.value THEN                   ''Parameter OK''                   ELSE ''Parameter NOK''                END                                AS remark         FROM   ('
SET @QueryGeneralCheck2b = ' AS derivedtbl_1) AS tbl INNER JOIN welding.qiscontrolparameters ON tbl.param_id = welding.qiscontrolparameters.parameter_id)tbl)QisCheck '
SET @SQL3b = 
'SELECT DISTINCT                           [BOS_6000_DB].[dbo].[ExtParamValues_V].timerName, [ExtParamValues_V].[subindex] AS Program, [BOS_6000_DB].[dbo].[ExtParamValues_V].value,  [BOS_6000_DB].[dbo].[ExtParamValues_V].param_id,  [BOS_6000_DB].[dbo].[ExtParamValues_V].text  FROM  [BOS_6000_DB].[dbo].[ExtParamValues_V]  WHERE [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2305 or [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2306 or [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2307''  )'
SET
 @ParameterNOKb =
 'WHERE  Qischeck.remark = ''PARAMETER NOK'' ' 


 --- Querys Womau greenfield

exec (@QueryspotCheck1b + @OPENQUERYNPT50+@SQL1b + @QueryspotCheck2b + @ParameterNOKb ) 
exec (@QueryMidairCheck1b + @OPENQUERYNPT50+@SQL2b + @QueryMidairCheck2b + @ParameterNOKb ) 
exec (@QueryGeneralCheck1b + @OPENQUERYNPT50+@SQL3b + @QueryGeneralCheck2b + @ParameterNOKb ) 
exec (@QueryspotCheck1b + @OPENQUERYNPT51+@SQL1b + @QueryspotCheck2b + @ParameterNOKb ) 
exec (@QueryMidairCheck1b + @OPENQUERYNPT51+@SQL2b + @QueryMidairCheck2b + @ParameterNOKb ) 
exec (@QueryGeneralCheck1b + @OPENQUERYNPT51+@SQL3b + @QueryGeneralCheck2b + @ParameterNOKb ) 
exec (@QueryspotCheck1b + @OPENQUERYNPT52+@SQL1b + @QueryspotCheck2b + @ParameterNOKb ) 
exec (@QueryMidairCheck1b + @OPENQUERYNPT52+@SQL2b + @QueryMidairCheck2b + @ParameterNOKb ) 
exec (@QueryGeneralCheck1b + @OPENQUERYNPT52+@SQL3b + @QueryGeneralCheck2b + @ParameterNOKb ) 
exec (@QueryspotCheck1b + @OPENQUERYNPT53+@SQL1b + @QueryspotCheck2b + @ParameterNOKb ) 
exec (@QueryMidairCheck1b + @OPENQUERYNPT53+@SQL2b + @QueryMidairCheck2b + @ParameterNOKb ) 
exec (@QueryGeneralCheck1b + @OPENQUERYNPT53+@SQL3b + @QueryGeneralCheck2b + @ParameterNOKb ) 
exec (@QueryspotCheck1b + @OPENQUERYNPT54+@SQL1b + @QueryspotCheck2b + @ParameterNOKb ) 
exec (@QueryMidairCheck1b + @OPENQUERYNPT54+@SQL2b + @QueryMidairCheck2b + @ParameterNOKb ) 
exec (@QueryGeneralCheck1b + @OPENQUERYNPT54+@SQL3b + @QueryGeneralCheck2b + @ParameterNOKb ) 
exec (@QueryspotCheck1b + @OPENQUERYNPT55+@SQL1b + @QueryspotCheck2b + @ParameterNOKb ) 
exec (@QueryMidairCheck1b + @OPENQUERYNPT55+@SQL2b + @QueryMidairCheck2b + @ParameterNOKb ) 
exec (@QueryGeneralCheck1b + @OPENQUERYNPT55+@SQL3b + @QueryGeneralCheck2b + @ParameterNOKb ) 
exec (@QueryspotCheck1b + @OPENQUERYNPT56+@SQL1b + @QueryspotCheck2b + @ParameterNOKb ) 
exec (@QueryMidairCheck1b + @OPENQUERYNPT56+@SQL2b + @QueryMidairCheck2b + @ParameterNOKb ) 
exec (@QueryGeneralCheck1b + @OPENQUERYNPT56+@SQL3b + @QueryGeneralCheck2b + @ParameterNOKb ) 
exec (@QueryspotCheck1b + @OPENQUERYNPT57+@SQL1b + @QueryspotCheck2b + @ParameterNOKb ) 
exec (@QueryMidairCheck1b + @OPENQUERYNPT57+@SQL2b + @QueryMidairCheck2b + @ParameterNOKb ) 
exec (@QueryGeneralCheck1b + @OPENQUERYNPT57+@SQL3b + @QueryGeneralCheck2b + @ParameterNOKb ) 
exec (@QueryspotCheck1b + @OPENQUERYNPT58+@SQL1b + @QueryspotCheck2b + @ParameterNOKb ) 
exec (@QueryMidairCheck1b + @OPENQUERYNPT58+@SQL2b + @QueryMidairCheck2b + @ParameterNOKb ) 
exec (@QueryGeneralCheck1b + @OPENQUERYNPT58+@SQL3b + @QueryGeneralCheck2b + @ParameterNOKb ) 
exec (@QueryspotCheck1b + @OPENQUERYNPT59+@SQL1b + @QueryspotCheck2b + @ParameterNOKb ) 
exec (@QueryMidairCheck1b + @OPENQUERYNPT59+@SQL2b + @QueryMidairCheck2b + @ParameterNOKb ) 
exec (@QueryGeneralCheck1b + @OPENQUERYNPT59+@SQL3b + @QueryGeneralCheck2b + @ParameterNOKb ) 







---select * from #tempQischeck WHERE TimerName <> 'test'
--insert the new qis data into welding.qis
insert into WELDING.Qis

SELECT         #tempQischeck.Timestamp AS temptime,  #tempQischeck.TimerName AS tempTimer,  #tempQischeck.program AS tempprogram, 
                          #tempQischeck.parameter AS tempparameter,  #tempQischeck.bos6000Value AS tempBos6000Value,  #tempQischeck.RequiredValue AS tempValue, 
                          #tempQischeck.remark AS tempRemark
FROM            WELDING.Qis RIGHT OUTER JOIN
                        #tempQischeck ON WELDING.Qis.parameter =  #tempQischeck.parameter AND WELDING.Qis.program =  #tempQischeck.program AND 
                         WELDING.Qis.TimerName =  #tempQischeck.TimerName
WHERE        (WELDING.Qis.TimerName IS NULL) AND (WELDING.Qis.program IS NULL) AND (WELDING.Qis.parameter IS NULL) AND ( #tempQischeck.TimerName <> N'test')
--insert the old Qis data 
Delete from welding.Qis

FROM            WELDING.Qis LEFT OUTER JOIN
                         #tempQischeck ON WELDING.Qis.parameter = #tempQischeck.parameter AND WELDING.Qis.program = #tempQischeck.program AND 
                         WELDING.Qis.TimerName = #tempQischeck.TimerName
WHERE        (#tempQischeck.Timestamp IS NULL) AND (#tempQischeck.TimerName IS NULL) AND (#tempQischeck.program IS NULL) AND (#tempQischeck.parameter IS NULL) 

delete from WELDING.Qis
--delete the recording data
--SELECT        WELDING.Qis.Timestamp, WELDING.Qis.TimerName, WELDING.Qis.program, WELDING.Qis.parameter, WELDING.Qis.bos6000Value, WELDING.Qis.RequiredValue, 
     --                    WELDING.Qis.remark
FROM            WELDING.Qis LEFT OUTER JOIN
                         WELDING.Qis AS Qis_1 ON WELDING.Qis.TimerName = Qis_1.TimerName AND WELDING.Qis.program = Qis_1.program
WHERE        (WELDING.Qis.parameter LIKE N'regulation (P)%') AND (WELDING.Qis.bos6000Value = 0) AND (Qis_1.bos6000Value = 0) AND 
                         (Qis_1.parameter LIKE N'Monitoring (P)%') OR
                         (WELDING.Qis.parameter LIKE N'Monitoring (P)%') AND (WELDING.Qis.bos6000Value = 0) AND (Qis_1.bos6000Value = 0) AND 
                         (Qis_1.parameter LIKE N'regulation (P)%')


drop table #tempQischeck
END