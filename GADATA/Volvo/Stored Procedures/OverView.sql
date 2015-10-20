CREATE PROCEDURE [Volvo].[OverView]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @daysback as int = 1,
   @RobotFilterWild as varchar(10) = '%',
   @LocationFilterWild as varchar(20) = '%',
   @LogSev as int = 10 --vanaf deze severity komt alles door 


AS
BEGIN
---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--Set default values of start and end date
---------------------------------------------------------------------------------------
if ((@StartDate is null) OR (@StartDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @StartDate = GETDATE()-'1900-01-01 12:00:00'
END

if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()

END

---------------------------------------------------------------------------------------
SELECT * FROM GADATA.C4G.Error as C4GE
WHERE 
C4GE.timestamp between @StartDate AND @EndDate
AND 
(
C4GE.Severity > @LogSev
OR 
C4GE.Subgroup IN('Hardware','Encoder') --include list
)
AND 
C4GE.Subgroup NOT IN('Gate/Hold') --Exclude list 
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C3G.Error as C3GE
WHERE 
C3GE.timestamp between @StartDate AND @EndDate
AND 
(
C3GE.Severity > @LogSev
OR 
C3GE.Subgroup IN('Hardware','Encoder','Crash') --include list
)
AND 
C3GE.Subgroup NOT IN('Gate/Hold') --Exclude list 
---------------------------------------------------------------------------------------
UNION 
SELECT * FROM GADATA.C4g.RsBreakdown as C4GB
WHERE 
C4GB.timestamp between @StartDate AND @EndDate
AND 
C4GB.DOWNTIME > 5
AND 
C4GB.Subgroup NOT IN('Gate/Hold','Timer') --Exclude list 
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C4G.Gen_ovr as C4Gs
where 
c4gs.timestamp BETWEEN  @StartDate AND @EndDate
--AND 
--c4gs.idx = 1 
--AND 
--C4gs.Logtekst NOT LIKE '%100%'


order by timestamp desc 
END