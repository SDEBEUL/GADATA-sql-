-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [QIS].[QisGA4]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

IF OBJECT_ID('#tempQisCheckGA4') IS NOT NULL DROP TABLE #tempQisCheckGA4

 Create table #tempQisCheckGA4 ([Timestamp] datetime
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

		@OPENQUERYNPT40 nvarchar(4000),
		@LinkedServerNPT40 nvarchar(4000),

		@OPENQUERYNPT41 nvarchar(4000),
		@LinkedServerNPT41 nvarchar(4000),

		--@OPENQUERYNPT42 nvarchar(4000),
		--@LinkedServerNPT42 nvarchar(4000),

		@OPENQUERYNPT43 nvarchar(4000),
		@LinkedServerNPT43 nvarchar(4000),

		@OPENQUERYNPT53 nvarchar(4000),
		@LinkedServerNPT53 nvarchar(4000)

					
SET @LinkedServerNPT40 = '[10.249.240.10\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT40 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT40 + ','''

SET @LinkedServerNPT41 = '[10.249.240.11\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT41 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT41 + ','''

--SET @LinkedServerNPT42 = '[10.249.240.12\BOS_SQLSERV_2005]'
--SET @OPENQUERYNPT42 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT42 + ','''

SET @LinkedServerNPT43 = '[10.249.240.13\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT43 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT43 + ','''

SET @LinkedServerNPT53 = '[10.249.240.14\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT53 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT53 + ','''



SET @QueryspotCheck1a = 'INSERT INTO #tempQisCheckGA4 SELECT convert(datetime,Getdate(),102) as timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark
	FROM   (SELECT *  FROM   (SELECT tbl.timername,  tbl.program, tbl.text AS Parameter, tbl.value  AS [BOS6000 Value], welding.qiscontrolparameters.value AS [required Value], welding.qiscontrolparameters.minvalue, welding.qiscontrolparameters.maxvalue, CASE  WHEN tbl.value = welding.qiscontrolparameters.value OR tbl.value BETWEEN  welding.qiscontrolparameters.minvalue AND    welding.qiscontrolparameters.maxvalue THEN  ''Parameter OK''  ELSE ''Parameter NOK''   END  AS Remark                
	FROM   (' 
	SET @QueryspotCheck2a = 'AS derivedtbl_1) AS tbl INNER JOIN welding.qiscontrolparameters ON tbl.param_id = welding.qiscontrolparameters.parameter_id  WHERE  welding.qiscontrolparameters .generalparameter = ''0'' ) tbl )QisCheck '
	
	
	SET @SQL1a = 'SELECT DISTINCT  [BOS_6000_DB].dbo.ExtParamValues_V.timerName, [BOS_6000_DB].dbo.ExtParamValues_V.subIndex AS Program, [BOS_6000_DB].dbo.ExtParamValues_V.value, [BOS_6000_DB].dbo.ExtParamValues_V.text, [BOS_6000_DB].dbo.ExtParamValues_V.param_ID 
	FROM  [BOS_6000_DB].dbo.ExtSpotTable_V INNER JOIN   [BOS_6000_DB].dbo.ExtParamValues_V ON [BOS_6000_DB].dbo.ExtSpotTable_V.timerName = [BOS_6000_DB].dbo.ExtParamValues_V.timerName AND   [BOS_6000_DB].dbo.ExtSpotTable_V.weldProgNo = [BOS_6000_DB].dbo.ExtParamValues_V.subIndex
	WHERE      ([BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1) and  [BOS_6000_DB].dbo.ExtParamValues_V.subIndex between 80 AND 200 '')'
SET 
@QueryMidairCheck1a = 
' INSERT INTO #tempQisCheckGA4 SELECT Getdate() AS Timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark FROM   (SELECT * from (SELECT tbl.timername,                 tbl.program,                 tbl.text                           AS Parameter,                 tbl.value                          AS [BOS6000 Value],                 welding.qiscontrolparameters.value AS [required Value],                 welding.qiscontrolparameters.minvalue,                 welding.qiscontrolparameters.maxvalue,                 CASE                   WHEN tbl.value = welding.qiscontrolparameters.value THEN                   ''Parameter OK''                   ELSE ''Parameter NOK''                END                                AS remark         FROM   ('
SET @QueryMidairCheck2a = '  AS derivedtbl_1) AS tbl  INNER JOIN welding.qiscontrolparameters          ON tbl.param_id = welding.qiscontrolparameters.parameter_id   WHERE  welding.qiscontrolparameters.midairparameter = 1) tbl) Qischeck '
SET @SQL2a = 
'SELECT DISTINCT  [BOS_6000_DB].dbo.ExtParamValues_V.timerName, [BOS_6000_DB].dbo.ExtParamValues_V.subIndex AS Program, [BOS_6000_DB].dbo.ExtParamValues_V.value, [BOS_6000_DB].dbo.ExtParamValues_V.text, [BOS_6000_DB].dbo.ExtParamValues_V.param_ID FROM  [BOS_6000_DB].dbo.ExtSpotTable_V INNER JOIN      [BOS_6000_DB].dbo.ExtParamValues_V ON [BOS_6000_DB].dbo.ExtSpotTable_V.timerName = [BOS_6000_DB].dbo.ExtParamValues_V.timerName AND    [BOS_6000_DB].dbo.ExtSpotTable_V.weldProgNo = [BOS_6000_DB].dbo.ExtParamValues_V.subIndex  WHERE        ([BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1) and  [BOS_6000_DB].dbo.ExtParamValues_V.subIndex = 253'')'
SET @QueryGeneralCheck1a =
' INSERT INTO #tempQisCheckGA4 SELECT  convert(datetime,Getdate(),102) AS Timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark FROM   (SELECT * from (SELECT tbl.timername,                 tbl.program,                 tbl.text                           AS Parameter,                 tbl.value                          AS [BOS6000 Value],                 welding.qiscontrolparameters.value AS [required Value],                 welding.qiscontrolparameters.minvalue,                 welding.qiscontrolparameters.maxvalue,                 CASE                   WHEN tbl.value = welding.qiscontrolparameters.value THEN                   ''Parameter OK''                   ELSE ''Parameter NOK''                END                                AS remark         FROM   ('
SET @QueryGeneralCheck2a = ' AS derivedtbl_1) AS tbl INNER JOIN welding.qiscontrolparameters ON tbl.param_id = welding.qiscontrolparameters.parameter_id)tbl)QisCheck '
SET @SQL3a = 
'SELECT DISTINCT                           [BOS_6000_DB].[dbo].[ExtParamValues_V].timerName, [ExtParamValues_V].[subindex] AS Program, [BOS_6000_DB].[dbo].[ExtParamValues_V].value,  [BOS_6000_DB].[dbo].[ExtParamValues_V].param_id,  [BOS_6000_DB].[dbo].[ExtParamValues_V].text  FROM  [BOS_6000_DB].[dbo].[ExtParamValues_V]  WHERE [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2305 or [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2306 or [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2307''  )'
SET
 @ParameterNOKa =
 'WHERE  Qischeck.remark = ''PARAMETER NOK'' ' 



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
exec (@QueryGeneralCheck1a + @OPENQUERYNPT43+@SQL3a + @QueryGeneralCheck2a + @ParameterNOKa ) 
exec (@QueryspotCheck1a + @OPENQUERYNPT53+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT53+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1a + @OPENQUERYNPT53+@SQL3a + @QueryGeneralCheck2a+ @ParameterNOKa ) 



---select * from #tempQisCheckGA4 WHERE TimerName <> 'test'
--insert the new qis data into welding.qis

insert into QIS.QISLOG_GA4 

SELECT         #tempQisCheckGA4.Timestamp AS temptime,  #tempQisCheckGA4.TimerName AS tempTimer,  #tempQisCheckGA4.program AS tempprogram, 
                          #tempQisCheckGA4.parameter AS tempparameter,  #tempQisCheckGA4.bos6000Value AS tempBos6000Value,  #tempQisCheckGA4.RequiredValue AS tempValue, 
                          #tempQisCheckGA4.remark AS tempRemark
FROM            QIS.QISLOG_GA4 RIGHT OUTER JOIN
                        #tempQisCheckGA4 ON QIS.QISLOG_GA4.parameter =  #tempQisCheckGA4.parameter AND QIS.QISLOG_GA4.program =  #tempQisCheckGA4.program AND 
                         QIS.QISLOG_GA4.TimerName =  #tempQisCheckGA4.TimerName
WHERE        (QIS.QISLOG_GA4.TimerName IS NULL) AND (QIS.QISLOG_GA4.program IS NULL) AND (QIS.QISLOG_GA4.parameter IS NULL) AND ( #tempQisCheckGA4.TimerName <> N'test')
--insert the old Qis data 
Delete from QIS.QISLOG_GA4

FROM            QIS.QISLOG_GA4 LEFT OUTER JOIN
                         #tempQisCheckGA4 ON QIS.QISLOG_GA4.parameter = #tempQisCheckGA4.parameter AND QIS.QISLOG_GA4.program = #tempQisCheckGA4.program AND 
                         QIS.QISLOG_GA4.TimerName = #tempQisCheckGA4.TimerName
WHERE        (#tempQisCheckGA4.Timestamp IS NULL) AND (#tempQisCheckGA4.TimerName IS NULL) AND (#tempQisCheckGA4.program IS NULL) AND (#tempQisCheckGA4.parameter IS NULL) 

delete from QIS.QISLOG_GA4 
--delete the recording data
--SELECT        QIS.QISLOG_GA4.Timestamp, QIS.QISLOG_GA4.TimerName, QIS.QISLOG_GA4.program, QIS.QISLOG_GA4.parameter, QIS.QISLOG_GA4.bos6000Value, QIS.QISLOG_GA4.RequiredValue, 
     --                    QIS.QISLOG_GA4.remark
FROM            QIS.QISLOG_GA4 LEFT OUTER JOIN
                         QIS.QISLOG_GA4 AS Qis_1 ON QIS.QISLOG_GA4.TimerName = Qis_1.TimerName AND QIS.QISLOG_GA4.program = Qis_1.program
WHERE        (QIS.QISLOG_GA4.parameter LIKE N'regulation (P)%') AND (QIS.QISLOG_GA4.bos6000Value = 0) AND (Qis_1.bos6000Value = 0) AND 
                         (Qis_1.parameter LIKE N'Monitoring (P)%') OR
                         (QIS.QISLOG_GA4.parameter LIKE N'Monitoring (P)%') AND (QIS.QISLOG_GA4.bos6000Value = 0) AND (Qis_1.bos6000Value = 0) AND 
                         (Qis_1.parameter LIKE N'regulation (P)%')


drop table #tempQisCheckGA4
END