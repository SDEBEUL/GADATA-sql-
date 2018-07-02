-- =============================================
-- Author:		Coppejans Jens
-- Create date: <Create Date,,>
-- Description:	Qis Greenfield
-- =============================================
CREATE PROCEDURE [QIS].[QISGA1_SIBO]

AS
BEGIN

	SET NOCOUNT ON;

IF OBJECT_ID('#tempQisGA1SIBO') IS NOT NULL DROP TABLE #tempQisGA1SIBO

 Create table #tempQisGA1SIBO ([Timestamp] datetime
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


        @QueryspotCheck1a nvarchar(max),
        @QueryspotCheck2a nvarchar(max), 
        
		@SQL1a nvarchar(4000),
		@SQL2a nvarchar(4000),
		@SQL3a nvarchar(4000), 
        @ParameterNOKa nvarchar(50),
		@QueryMidairCheck1a nvarchar(max),
		@QueryMidairCheck2a nvarchar(max), 
		@QueryGeneralCheck1a nvarchar(max),
		@QueryGeneralCheck2a nvarchar(max),

	

		@OPENQUERYNPT70 nvarchar(4000),
		@LinkedServerNPT70 nvarchar(4000),

		@OPENQUERYNPT71 nvarchar(4000),
		@LinkedServerNPT71 nvarchar(4000),

		@OPENQUERYNPT72 nvarchar(4000),
		@LinkedServerNPT72 nvarchar(4000),

		@OPENQUERYNPT73 nvarchar(4000),
		@LinkedServerNPT73 nvarchar(4000)
				

SET @LinkedServerNPT70 = '[10.249.227.69\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT70 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT70 + ','''

SET @LinkedServerNPT71 = '[10.249.222.197\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT71 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT71 + ','''

SET @LinkedServerNPT72 = '[10.249.225.135\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT72 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT72 + ','''

SET @LinkedServerNPT73 = '[10.249.222.198\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT73 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT73 + ','''



SET @QueryspotCheck1a = 'INSERT INTO #tempQisGA1SIBO SELECT convert(datetime,Getdate(),102) as timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark
	FROM   (SELECT *  FROM   (SELECT tbl.timername,  tbl.program, tbl.text AS Parameter, tbl.value  AS [BOS6000 Value], welding.qiscontrolparameters.value AS [required Value], welding.qiscontrolparameters.minvalue, welding.qiscontrolparameters.maxvalue, CASE  WHEN tbl.value = welding.qiscontrolparameters.value OR tbl.value BETWEEN  welding.qiscontrolparameters.minvalue AND    welding.qiscontrolparameters.maxvalue THEN  ''Parameter OK''  ELSE ''Parameter NOK''   END  AS Remark                
	FROM   (' 
	SET @QueryspotCheck2a = 'AS derivedtbl_1) AS tbl INNER JOIN welding.qiscontrolparameters ON tbl.param_id = welding.qiscontrolparameters.parameter_id  WHERE  welding.qiscontrolparameters .generalparameter = ''0'' ) tbl )QisCheck '
	
	
	SET @SQL1a = 'SELECT DISTINCT  [BOS_6000_DB].dbo.ExtParamValues_V.timerName, [BOS_6000_DB].dbo.ExtParamValues_V.subIndex AS Program, [BOS_6000_DB].dbo.ExtParamValues_V.value, [BOS_6000_DB].dbo.ExtParamValues_V.text, [BOS_6000_DB].dbo.ExtParamValues_V.param_ID 
	FROM  [BOS_6000_DB].dbo.ExtSpotTable_V INNER JOIN   [BOS_6000_DB].dbo.ExtParamValues_V ON [BOS_6000_DB].dbo.ExtSpotTable_V.timerName = [BOS_6000_DB].dbo.ExtParamValues_V.timerName AND   [BOS_6000_DB].dbo.ExtSpotTable_V.weldProgNo = [BOS_6000_DB].dbo.ExtParamValues_V.subIndex
	WHERE      ([BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1) and  [BOS_6000_DB].dbo.ExtParamValues_V.subIndex between 80 AND 200 '')'
SET 
@QueryMidairCheck1a = 
' INSERT INTO #tempQisGA1SIBO SELECT Getdate() AS Timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark FROM   (SELECT * from (SELECT tbl.timername,                 tbl.program,                 tbl.text                           AS Parameter,                 tbl.value                          AS [BOS6000 Value],                 welding.qiscontrolparameters.value AS [required Value],                 welding.qiscontrolparameters.minvalue,                 welding.qiscontrolparameters.maxvalue,                 CASE                   WHEN tbl.value = welding.qiscontrolparameters.value THEN                   ''Parameter OK''                   ELSE ''Parameter NOK''                END                                AS remark         FROM   ('
SET @QueryMidairCheck2a = '  AS derivedtbl_1) AS tbl  INNER JOIN welding.qiscontrolparameters          ON tbl.param_id = welding.qiscontrolparameters.parameter_id   WHERE  welding.qiscontrolparameters.midairparameter = 1) tbl) Qischeck '
SET @SQL2a = 
'SELECT DISTINCT  [BOS_6000_DB].dbo.ExtParamValues_V.timerName, [BOS_6000_DB].dbo.ExtParamValues_V.subIndex AS Program, [BOS_6000_DB].dbo.ExtParamValues_V.value, [BOS_6000_DB].dbo.ExtParamValues_V.text, [BOS_6000_DB].dbo.ExtParamValues_V.param_ID FROM  [BOS_6000_DB].dbo.ExtSpotTable_V INNER JOIN      [BOS_6000_DB].dbo.ExtParamValues_V ON [BOS_6000_DB].dbo.ExtSpotTable_V.timerName = [BOS_6000_DB].dbo.ExtParamValues_V.timerName AND    [BOS_6000_DB].dbo.ExtSpotTable_V.weldProgNo = [BOS_6000_DB].dbo.ExtParamValues_V.subIndex  WHERE        ([BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1) and  [BOS_6000_DB].dbo.ExtParamValues_V.subIndex = 253'')'
SET @QueryGeneralCheck1a =
' INSERT INTO #tempQisGA1SIBO SELECT  convert(datetime,Getdate(),102) AS Timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark FROM   (SELECT * from (SELECT tbl.timername,                 tbl.program,                 tbl.text                           AS Parameter,                 tbl.value                          AS [BOS6000 Value],                 welding.qiscontrolparameters.value AS [required Value],                 welding.qiscontrolparameters.minvalue,                 welding.qiscontrolparameters.maxvalue,                 CASE                   WHEN tbl.value = welding.qiscontrolparameters.value THEN                   ''Parameter OK''                   ELSE ''Parameter NOK''                END                                AS remark         FROM   ('
SET @QueryGeneralCheck2a = ' AS derivedtbl_1) AS tbl INNER JOIN welding.qiscontrolparameters ON tbl.param_id = welding.qiscontrolparameters.parameter_id)tbl)QisCheck '
SET @SQL3a = 
'SELECT DISTINCT                           [BOS_6000_DB].[dbo].[ExtParamValues_V].timerName, [ExtParamValues_V].[subindex] AS Program, [BOS_6000_DB].[dbo].[ExtParamValues_V].value,  [BOS_6000_DB].[dbo].[ExtParamValues_V].param_id,  [BOS_6000_DB].[dbo].[ExtParamValues_V].text  FROM  [BOS_6000_DB].[dbo].[ExtParamValues_V]  WHERE [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2305 or [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2306 or [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2307''  )'
SET
 @ParameterNOKa =
 'WHERE  Qischeck.remark = ''PARAMETER NOK'' ' 


exec (@QueryspotCheck1a + @OPENQUERYNPT70+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT70+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1a + @OPENQUERYNPT70+@SQL3a + @QueryGeneralCheck2a + @ParameterNOKa ) 



exec (@QueryspotCheck1a + @OPENQUERYNPT71+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT71+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1a + @OPENQUERYNPT71+@SQL3a + @QueryGeneralCheck2a + @ParameterNOKa ) 

exec (@QueryspotCheck1a + @OPENQUERYNPT72+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT72+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1a + @OPENQUERYNPT72+@SQL3a + @QueryGeneralCheck2a + @ParameterNOKa ) 

exec (@QueryspotCheck1a + @OPENQUERYNPT73+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT73+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1a + @OPENQUERYNPT73+@SQL3a + @QueryGeneralCheck2a + @ParameterNOKa ) 



---select * from #tempQisGA1SIBO WHERE TimerName <> 'test'
--insert the new qis data into welding.qis

insert into QIS.QISLOG_GA1_SIBO

SELECT         #tempQisGA1SIBO.Timestamp AS temptime,  #tempQisGA1SIBO.TimerName AS tempTimer,  #tempQisGA1SIBO.program AS tempprogram, 
                          #tempQisGA1SIBO.parameter AS tempparameter,  #tempQisGA1SIBO.bos6000Value AS tempBos6000Value,  #tempQisGA1SIBO.RequiredValue AS tempValue, 
                          #tempQisGA1SIBO.remark AS tempRemark
FROM            QIS.QISLOG_GA1_SIBO RIGHT OUTER JOIN
                        #tempQisGA1SIBO ON QIS.QISLOG_GA1_SIBO.parameter =  #tempQisGA1SIBO.parameter AND QIS.QISLOG_GA1_SIBO.program =  #tempQisGA1SIBO.program AND 
                         QIS.QISLOG_GA1_SIBO.TimerName =  #tempQisGA1SIBO.TimerName
WHERE        (QIS.QISLOG_GA1_SIBO.TimerName IS NULL) AND (QIS.QISLOG_GA1_SIBO.program IS NULL) AND (QIS.QISLOG_GA1_SIBO.parameter IS NULL) AND ( #tempQisGA1SIBO.TimerName <> N'test')
--insert the old Qis data 
Delete from QIS.QISLOG_GA1_SIBO

FROM            QIS.QISLOG_GA1_SIBO LEFT OUTER JOIN
                         #tempQisGA1SIBO ON QIS.QISLOG_GA1_SIBO.parameter = #tempQisGA1SIBO.parameter AND QIS.QISLOG_GA1_SIBO.program = #tempQisGA1SIBO.program AND 
                         QIS.QISLOG_GA1_SIBO.TimerName = #tempQisGA1SIBO.TimerName
WHERE        (#tempQisGA1SIBO.Timestamp IS NULL) AND (#tempQisGA1SIBO.TimerName IS NULL) AND (#tempQisGA1SIBO.program IS NULL) AND (#tempQisGA1SIBO.parameter IS NULL) 

delete from QIS.QISLOG_GA1_SIBO
--delete the recording data
--SELECT        QIS.QISLOG_GA1_SIBO.Timestamp, QIS.QISLOG_GA1_SIBO.TimerName, QIS.QISLOG_GA1_SIBO.program, QIS.QISLOG_GA1_SIBO.parameter, QIS.QISLOG_GA1_SIBO.bos6000Value, QIS.QISLOG_GA1_SIBO.RequiredValue, 
     --                    QIS.QISLOG_GA1_SIBO.remark
FROM            QIS.QISLOG_GA1_SIBO LEFT OUTER JOIN
                         QIS.QISLOG_GA1_SIBO AS Qis_1 ON QIS.QISLOG_GA1_SIBO.TimerName = Qis_1.TimerName AND QIS.QISLOG_GA1_SIBO.program = Qis_1.program
WHERE        (QIS.QISLOG_GA1_SIBO.parameter LIKE N'regulation (P)%') AND (QIS.QISLOG_GA1_SIBO.bos6000Value = 0) AND (Qis_1.bos6000Value = 0) AND 
                         (Qis_1.parameter LIKE N'Monitoring (P)%') OR
                         (QIS.QISLOG_GA1_SIBO.parameter LIKE N'Monitoring (P)%') AND (QIS.QISLOG_GA1_SIBO.bos6000Value = 0) AND (Qis_1.bos6000Value = 0) AND 
                         (Qis_1.parameter LIKE N'regulation (P)%')


drop table #tempQisGA1SIBO

END