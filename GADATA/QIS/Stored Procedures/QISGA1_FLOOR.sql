-- =============================================
-- Author:		Coppejans Jens
-- Create date: <Create Date,,>
-- Description:	Qis Greenfield
-- =============================================
CREATE PROCEDURE [QIS].[QISGA1_FLOOR]

AS
BEGIN

	SET NOCOUNT ON;

IF OBJECT_ID('#tempQGA1_floor') IS NOT NULL DROP TABLE #tempQGA1_floor

 Create table #tempQGA1_floor ([Timestamp] datetime
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

		@OPENQUERYNPT50 nvarchar(4000),
		@LinkedServerNPT50 nvarchar(4000),

		@OPENQUERYNPT51 nvarchar(4000),
		@LinkedServerNPT51 nvarchar(4000),

		@OPENQUERYNPT52 nvarchar(4000),
		@LinkedServerNPT52 nvarchar(4000),

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

SET @LinkedServerNPT52 = '[10.249.225.198\BOS_SQLSERV_2005]'
SET @OPENQUERYNPT52 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT52 + ','''

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
SET @OPENQUERYNPT59 = 'SELECT timername, program,  value,  text,  param_id  FROM OPENQUERY ('+ @LinkedServerNPT59+ ','''



SET @QueryspotCheck1a = 'INSERT INTO #tempQGA1_floor SELECT convert(datetime,Getdate(),102) as timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark
	FROM   (SELECT *  FROM   (SELECT tbl.timername,  tbl.program, tbl.text AS Parameter, tbl.value  AS [BOS6000 Value], welding.qiscontrolparameters.value AS [required Value], welding.qiscontrolparameters.minvalue, welding.qiscontrolparameters.maxvalue, CASE  WHEN tbl.value = welding.qiscontrolparameters.value OR tbl.value BETWEEN  welding.qiscontrolparameters.minvalue AND    welding.qiscontrolparameters.maxvalue THEN  ''Parameter OK''  ELSE ''Parameter NOK''   END  AS Remark                
	FROM   (' 
	SET @QueryspotCheck2a = 'AS derivedtbl_1) AS tbl INNER JOIN welding.qiscontrolparameters ON tbl.param_id = welding.qiscontrolparameters.parameter_id  WHERE  welding.qiscontrolparameters .generalparameter = ''0'' ) tbl )QisCheck '
	
	
	SET @SQL1a = 'SELECT DISTINCT  [BOS_6000_DB].dbo.ExtParamValues_V.timerName, [BOS_6000_DB].dbo.ExtParamValues_V.subIndex AS Program, [BOS_6000_DB].dbo.ExtParamValues_V.value, [BOS_6000_DB].dbo.ExtParamValues_V.text, [BOS_6000_DB].dbo.ExtParamValues_V.param_ID 
	FROM  [BOS_6000_DB].dbo.ExtSpotTable_V INNER JOIN   [BOS_6000_DB].dbo.ExtParamValues_V ON [BOS_6000_DB].dbo.ExtSpotTable_V.timerName = [BOS_6000_DB].dbo.ExtParamValues_V.timerName AND   [BOS_6000_DB].dbo.ExtSpotTable_V.weldProgNo = [BOS_6000_DB].dbo.ExtParamValues_V.subIndex
	WHERE      ([BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1) and  [BOS_6000_DB].dbo.ExtParamValues_V.subIndex between 80 AND 200 '')'
SET 
@QueryMidairCheck1a = 
' INSERT INTO #tempQGA1_floor SELECT Getdate() AS Timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark FROM   (SELECT * from (SELECT tbl.timername,                 tbl.program,                 tbl.text                           AS Parameter,                 tbl.value                          AS [BOS6000 Value],                 welding.qiscontrolparameters.value AS [required Value],                 welding.qiscontrolparameters.minvalue,                 welding.qiscontrolparameters.maxvalue,                 CASE                   WHEN tbl.value = welding.qiscontrolparameters.value THEN                   ''Parameter OK''                   ELSE ''Parameter NOK''                END                                AS remark         FROM   ('
SET @QueryMidairCheck2a = '  AS derivedtbl_1) AS tbl  INNER JOIN welding.qiscontrolparameters          ON tbl.param_id = welding.qiscontrolparameters.parameter_id   WHERE  welding.qiscontrolparameters.midairparameter = 1) tbl) Qischeck '
SET @SQL2a = 
'SELECT DISTINCT  [BOS_6000_DB].dbo.ExtParamValues_V.timerName, [BOS_6000_DB].dbo.ExtParamValues_V.subIndex AS Program, [BOS_6000_DB].dbo.ExtParamValues_V.value, [BOS_6000_DB].dbo.ExtParamValues_V.text, [BOS_6000_DB].dbo.ExtParamValues_V.param_ID FROM  [BOS_6000_DB].dbo.ExtSpotTable_V INNER JOIN      [BOS_6000_DB].dbo.ExtParamValues_V ON [BOS_6000_DB].dbo.ExtSpotTable_V.timerName = [BOS_6000_DB].dbo.ExtParamValues_V.timerName AND    [BOS_6000_DB].dbo.ExtSpotTable_V.weldProgNo = [BOS_6000_DB].dbo.ExtParamValues_V.subIndex  WHERE        ([BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1) and  [BOS_6000_DB].dbo.ExtParamValues_V.subIndex = 253'')'
SET @QueryGeneralCheck1a =
' INSERT INTO #tempQGA1_floor SELECT  convert(datetime,Getdate(),102) AS Timestamp,  Qischeck.timername,  Qischeck.program,  Qischeck.parameter,  Qischeck.[bos6000 value],  Qischeck.[required value],  Qischeck.remark FROM   (SELECT * from (SELECT tbl.timername,                 tbl.program,                 tbl.text                           AS Parameter,                 tbl.value                          AS [BOS6000 Value],                 welding.qiscontrolparameters.value AS [required Value],                 welding.qiscontrolparameters.minvalue,                 welding.qiscontrolparameters.maxvalue,                 CASE                   WHEN tbl.value = welding.qiscontrolparameters.value THEN                   ''Parameter OK''                   ELSE ''Parameter NOK''                END                                AS remark         FROM   ('
SET @QueryGeneralCheck2a = ' AS derivedtbl_1) AS tbl INNER JOIN welding.qiscontrolparameters ON tbl.param_id = welding.qiscontrolparameters.parameter_id)tbl)QisCheck '
SET @SQL3a = 
'SELECT DISTINCT                           [BOS_6000_DB].[dbo].[ExtParamValues_V].timerName, [ExtParamValues_V].[subindex] AS Program, [BOS_6000_DB].[dbo].[ExtParamValues_V].value,  [BOS_6000_DB].[dbo].[ExtParamValues_V].param_id,  [BOS_6000_DB].[dbo].[ExtParamValues_V].text  FROM  [BOS_6000_DB].[dbo].[ExtParamValues_V]  WHERE [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2305 or [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2306 or [BOS_6000_DB].dbo.ExtParamValues_V.languageCode = 1 AND param_id = 2307''  )'
SET
 @ParameterNOKa =
 'WHERE  Qischeck.remark = ''PARAMETER NOK'' ' 



exec (@QueryspotCheck1a + @OPENQUERYNPT50+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT50+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1a + @OPENQUERYNPT50+@SQL3a + @QueryGeneralCheck2a + @ParameterNOKa ) 
exec (@QueryspotCheck1a + @OPENQUERYNPT51+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT51+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1a + @OPENQUERYNPT51+@SQL3a + @QueryGeneralCheck2a + @ParameterNOKa ) 
exec (@QueryspotCheck1a + @OPENQUERYNPT52+@SQL1a + @QueryspotCheck2a + @ParameterNOK ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT52+@SQL2a + @QueryMidairCheck2a + @ParameterNOK ) 
exec (@QueryGeneralCheck1a + @OPENQUERYNPT52+@SQL3a + @QueryGeneralCheck2a + @ParameterNOK ) 

exec (@QueryspotCheck1a + @OPENQUERYNPT54+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT54+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1a + @OPENQUERYNPT54+@SQL3a + @QueryGeneralCheck2a+ @ParameterNOKa ) 
exec (@QueryspotCheck1a + @OPENQUERYNPT55+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT55+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1a + @OPENQUERYNPT55+@SQL3a + @QueryGeneralCheck2a+ @ParameterNOKa )
exec (@QueryspotCheck1a + @OPENQUERYNPT56+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT56+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1a + @OPENQUERYNPT56+@SQL3a + @QueryGeneralCheck2a+ @ParameterNOKa )  
exec (@QueryspotCheck1a + @OPENQUERYNPT57+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT57+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1a + @OPENQUERYNPT57+@SQL3a + @QueryGeneralCheck2a+ @ParameterNOKa ) 
exec (@QueryspotCheck1a + @OPENQUERYNPT58+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT58+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1a + @OPENQUERYNPT58+@SQL3a + @QueryGeneralCheck2a+ @ParameterNOKa ) 
exec (@QueryspotCheck1a + @OPENQUERYNPT59+@SQL1a + @QueryspotCheck2a + @ParameterNOKa ) 
exec (@QueryMidairCheck1a + @OPENQUERYNPT59+@SQL2a + @QueryMidairCheck2a + @ParameterNOKa ) 
exec (@QueryGeneralCheck1a + @OPENQUERYNPT59+@SQL3a + @QueryGeneralCheck2a+ @ParameterNOKa ) 






---select * from #tempQGA1_floor WHERE TimerName <> 'test'
--insert the new qis data into welding.qis

insert into Qis.QisLOG_GA1_FLOOR

SELECT         #tempQGA1_floor.Timestamp AS temptime,  #tempQGA1_floor.TimerName AS tempTimer,  #tempQGA1_floor.program AS tempprogram, 
                          #tempQGA1_floor.parameter AS tempparameter,  #tempQGA1_floor.bos6000Value AS tempBos6000Value,  #tempQGA1_floor.RequiredValue AS tempValue, 
                          #tempQGA1_floor.remark AS tempRemark
FROM            Qis.QisLOG_GA1_FLOOR RIGHT OUTER JOIN
                        #tempQGA1_floor ON Qis.QisLOG_GA1_FLOOR.parameter =  #tempQGA1_floor.parameter AND Qis.QisLOG_GA1_FLOOR.program =  #tempQGA1_floor.program AND 
                         Qis.QisLOG_GA1_FLOOR.TimerName =  #tempQGA1_floor.TimerName
WHERE        (Qis.QisLOG_GA1_FLOOR.TimerName IS NULL) AND (Qis.QisLOG_GA1_FLOOR.program IS NULL) AND (Qis.QisLOG_GA1_FLOOR.parameter IS NULL) AND ( #tempQGA1_floor.TimerName <> N'test')
--insert the old Qis data 
Delete from Qis.QisLOG_GA1_FLOOR

FROM            Qis.QisLOG_GA1_FLOOR LEFT OUTER JOIN
                         #tempQGA1_floor ON Qis.QisLOG_GA1_FLOOR.parameter = #tempQGA1_floor.parameter AND Qis.QisLOG_GA1_FLOOR.program = #tempQGA1_floor.program AND 
                         Qis.QisLOG_GA1_FLOOR.TimerName = #tempQGA1_floor.TimerName
WHERE        (#tempQGA1_floor.Timestamp IS NULL) AND (#tempQGA1_floor.TimerName IS NULL) AND (#tempQGA1_floor.program IS NULL) AND (#tempQGA1_floor.parameter IS NULL) 

delete from Qis.QisLOG_GA1_FLOOR
--delete the recording data
--SELECT        Qis.QisLOG_GA1_FLOOR.Timestamp, Qis.QisLOG_GA1_FLOOR.TimerName, Qis.QisLOG_GA1_FLOOR.program, Qis.QisLOG_GA1_FLOOR.parameter, Qis.QisLOG_GA1_FLOOR.bos6000Value, Qis.QisLOG_GA1_FLOOR.RequiredValue, 
     --                    Qis.QisLOG_GA1_FLOOR.remark
FROM            Qis.QisLOG_GA1_FLOOR LEFT OUTER JOIN
                         Qis.QisLOG_GA1_FLOOR AS Qis_1 ON Qis.QisLOG_GA1_FLOOR.TimerName = Qis_1.TimerName AND Qis.QisLOG_GA1_FLOOR.program = Qis_1.program
WHERE        (Qis.QisLOG_GA1_FLOOR.parameter LIKE N'regulation (P)%') AND (Qis.QisLOG_GA1_FLOOR.bos6000Value = 0) AND (Qis_1.bos6000Value = 0) AND 
                         (Qis_1.parameter LIKE N'Monitoring (P)%') OR
                         (Qis.QisLOG_GA1_FLOOR.parameter LIKE N'Monitoring (P)%') AND (Qis.QisLOG_GA1_FLOOR.bos6000Value = 0) AND (Qis_1.bos6000Value = 0) AND 
                         (Qis_1.parameter LIKE N'regulation (P)%')


drop table #tempQGA1_floor

END