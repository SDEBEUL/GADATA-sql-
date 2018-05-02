-- =============================================
-- Author:		Coppejans Jens
-- Create date: <Create Date,,>
-- Description:	NewQis
-- =============================================
CREATE PROCEDURE [WELDING].[QualityImprovementCheck]


AS 
BEGIN 

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

		@OPENQUERYNPT01 nvarchar(4000),
		@LinkedServerNPT01 nvarchar(4000),

		@OPENQUERYNPT04 nvarchar(4000),
		@LinkedServerNPT04 nvarchar(4000),

		@OPENQUERYNPT05 nvarchar(4000),
		@LinkedServerNPT05 nvarchar(4000),

		@OPENQUERYNPT06 nvarchar(4000),
		@LinkedServerNPT06 nvarchar(4000)

			
SET @LinkedServerNPT01 = '[19.148.189.9\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT01 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT01 + ','''
SET @LinkedServerNPT04 = '[19.148.170.244\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT04 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT04 + ','''
SET @LinkedServerNPT05 = '[19.148.170.103\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT05 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT05 + ','''
SET @LinkedServerNPT06 = '[19.148.184.10\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT06 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT06 + ','''


SET @QueryspotCheck1 = 'INSERT INTO welding.Qis SELECT Getdate() AS Timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark
	FROM   (SELECT *  FROM   (SELECT tbl.timername,  tbl.program, tbl.text AS Parameter, tbl.value  AS [BOS6000 Value], welding.qiscontrolparameters.value AS [required Value], welding.qiscontrolparameters.minvalue, welding.qiscontrolparameters.maxvalue, CASE  WHEN tbl.value = welding.qiscontrolparameters.value OR tbl.value BETWEEN  welding.qiscontrolparameters.minvalue AND    welding.qiscontrolparameters.maxvalue THEN  ''Parameter OK''  ELSE ''Parameter NOK''   END  AS Remark                
	FROM   (' 
	SET @QueryspotCheck2 = 'AS derivedtbl_1) AS tbl INNER JOIN welding.qiscontrolparameters ON tbl.param_id = welding.qiscontrolparameters.parameter_id  WHERE  welding.qiscontrolparameters .generalparameter = ''0'') tbl )QisCheck '
	
	
	SET @SQL1 = 'SELECT DISTINCT  [BOS_6000_DB].dbo.ExtParamValues_V.timerName, [BOS_6000_DB].dbo.ExtParamValues_V.subIndex AS Program, [BOS_6000_DB].dbo.ExtParamValues_V.value, [BOS_6000_DB].dbo.ExtParamValues_V.text, [BOS_6000_DB].dbo.ExtParamValues_V.param_ID 
	FROM  [BOS_6000_DB].dbo.ExtSpotTable_V INNER JOIN   [BOS_6000_DB].dbo.ExtParamValues_V ON [BOS_6000_DB].dbo.ExtSpotTable_V.timerName = [BOS_6000_DB].dbo.ExtParamValues_V.timerName AND   [BOS_6000_DB].dbo.ExtSpotTable_V.weldProgNo = [BOS_6000_DB].dbo.ExtParamValues_V.subIndex
	WHERE      ([BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1) and  [BOS_6000_DB].dbo.ExtParamValues_V.subIndex between 0 AND 235 '')'
SET 
@QueryMidairCheck1 = 
' INSERT INTO welding.Qis SELECT Getdate() AS Timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark FROM   (SELECT * from (SELECT tbl.timername,                 tbl.program,                 tbl.text                           AS Parameter,                 tbl.value                          AS [BOS6000 Value],                 welding.qiscontrolparameters.value AS [required Value],                 welding.qiscontrolparameters.minvalue,                 welding.qiscontrolparameters.maxvalue,                 CASE                   WHEN tbl.value = welding.qiscontrolparameters.value THEN                   ''Parameter OK''                   ELSE ''Parameter NOK''                END                                AS remark         FROM   ('
SET @QueryMidairCheck2 = '  AS derivedtbl_1) AS tbl  INNER JOIN welding.qiscontrolparameters          ON tbl.param_id = welding.qiscontrolparameters.parameter_id   WHERE  welding.qiscontrolparameters.midairparameter = 1) tbl) Qischeck '
SET @SQL2 = 
'SELECT DISTINCT  [BOS_6000_DB].dbo.ExtParamValues_V.timerName, [BOS_6000_DB].dbo.ExtParamValues_V.subIndex AS Program, [BOS_6000_DB].dbo.ExtParamValues_V.value, [BOS_6000_DB].dbo.ExtParamValues_V.text, [BOS_6000_DB].dbo.ExtParamValues_V.param_ID FROM  [BOS_6000_DB].dbo.ExtSpotTable_V INNER JOIN      [BOS_6000_DB].dbo.ExtParamValues_V ON [BOS_6000_DB].dbo.ExtSpotTable_V.timerName = [BOS_6000_DB].dbo.ExtParamValues_V.timerName AND    [BOS_6000_DB].dbo.ExtSpotTable_V.weldProgNo = [BOS_6000_DB].dbo.ExtParamValues_V.subIndex WHERE        ([BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1) and  [BOS_6000_DB].dbo.ExtParamValues_V.subIndex between 236 AND 255'')'
SET @QueryGeneralCheck1 =
' INSERT INTO welding.Qis SELECT Getdate() AS Timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark FROM   (SELECT * from (SELECT tbl.timername,                 tbl.program,                 tbl.text                           AS Parameter,                 tbl.value                          AS [BOS6000 Value],                 welding.qiscontrolparameters.value AS [required Value],                 welding.qiscontrolparameters.minvalue,                 welding.qiscontrolparameters.maxvalue,                 CASE                   WHEN tbl.value = welding.qiscontrolparameters.value THEN                   ''Parameter OK''                   ELSE ''Parameter NOK''                END                                AS remark         FROM   ('
SET @QueryGeneralCheck2 = ' AS derivedtbl_1) AS tbl INNER JOIN welding.qiscontrolparameters ON tbl.param_id = welding.qiscontrolparameters.parameter_id)tbl)QisCheck '
SET @SQL3 = 
'SELECT DISTINCT                           [BOS_6000_DB].[dbo].[ExtParamValues_V].timerName, [ExtParamValues_V].[subindex] AS Program, [BOS_6000_DB].[dbo].[ExtParamValues_V].value,  [BOS_6000_DB].[dbo].[ExtParamValues_V].param_id,  [BOS_6000_DB].[dbo].[ExtParamValues_V].text  FROM  [BOS_6000_DB].[dbo].[ExtParamValues_V]  WHERE [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2305 or [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2306 or [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2307''  )'
SET
 @ParameterNOK =
 'WHERE  Qischeck.remark = ''PARAMETER NOK'' ' 


exec (@QueryspotCheck1 + @OPENQUERYNPT01+@SQL1 + @QueryspotCheck2 + @ParameterNOK ) 
exec (@QueryMidairCheck1 + @OPENQUERYNPT01+@SQL2 + @QueryMidairCheck2 + @ParameterNOK ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT01+@SQL3 + @QueryGeneralCheck2 + @ParameterNOK ) 
exec (@QueryspotCheck1 + @OPENQUERYNPT04+@SQL1 + @QueryspotCheck2 + @ParameterNOK ) 
exec (@QueryMidairCheck1 + @OPENQUERYNPT04+@SQL2 + @QueryMidairCheck2 + @ParameterNOK ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT04+@SQL3 + @QueryGeneralCheck2 + @ParameterNOK ) 
exec (@QueryspotCheck1 + @OPENQUERYNPT05+@SQL1 + @QueryspotCheck2 + @ParameterNOK ) 
exec (@QueryMidairCheck1 + @OPENQUERYNPT05+@SQL2 + @QueryMidairCheck2 + @ParameterNOK ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT05+@SQL3 + @QueryGeneralCheck2 + @ParameterNOK ) 
exec (@QueryspotCheck1 + @OPENQUERYNPT06+@SQL1 + @QueryspotCheck2 + @ParameterNOK ) 
exec (@QueryMidairCheck1 + @OPENQUERYNPT06+@SQL2 + @QueryMidairCheck2 + @ParameterNOK ) 
exec (@QueryGeneralCheck1 + @OPENQUERYNPT06+@SQL3 + @QueryGeneralCheck2 + @ParameterNOK ) 



END