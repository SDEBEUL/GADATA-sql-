
CREATE PROCEDURE [GLUE].[sp_GADATAGLUEcockpit4]
--timeparameters
   @StartDate as varchar(32) = null,
   @EndDate as varchar(32) = null,
--Filterparameters.
--   @Robot as varchar(25) = '54090r04%',
   @Teamstername as varchar(25) = null
AS
BEGIN

---------------------------------------------------------------------------------------
--Set default values of start and end date
---------------------------------------------------------------------------------------
if (@StartDate is null) 
BEGIN
SET @StartDate = CAST(GETDATE()-40 AS date)
END

if (@EndDate is null)
BEGIN
SET @EndDate = CAST(GETDATE() AS date)
END
--for handeling 'today' clause in dt selectors
if (@EndDate = '1900-01-01 00:00:00:000')
BEGIN
SET @enddate = CAST(getdate() AS date)
END
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--Als er een weldgun name word gebruikt zoeken we de juiste robot en tool id op..
---------------------------------------------------------------------------------------

/*if (@Teamstername is not null)
BEGIN
SET @Robot = (SELECT TOP 1 '%' + CONCAT(LEFT(@Teamstername,5),'R',RIGHT(@Teamstername,2)) + '%')

END */
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--dit is echt iets kaka... ik wil dus voor al de verschillende 'data' bronnen
--is het nu sbcu / cilinder / midair een grafiek kunnen maken waar tijd altijd in lijn is voor de verschillende grafieken.
--dat wil zeggen dat ik eerst al de timestamp van al de databronnen moet selecteren en deze moet combineren ... UUGH 
---------------------------------------------------------------------------------------


 SELECT  vgm.Controller as RobotName,vgm.time, vgm.gemiddelde_vultijd_s as 'gemiddelde_vultijd_s',vgm.Year,vgm.Week,vgm.Day,vgm.RefAVG,vgm.RefSTDEC,vgm.UCLnumber,vgm.UCL3,vgm.UCL4,vgm.UCL5,vgm.UCLx,vgm.RefDp,vgm.RefSS
 FROM GADATA.glue.vultijdspcviewer5 as vgm
where 
vgm.Controller LIKE @Teamstername
AND
vgm.time between LEFT(@StartDate,10) and LEFT(@EndDate,10)

--vgm.Controller LIKE '22040SH10'
--AND
--vgm.time between LEFT('2016-10-05 00:00:00',10) and LEFT('2016-10-10 00:00:00',10)

/*SELECT  vgm.Controller as RobotName,vgm.time, vgm.gemiddelde_vultijd_s as 'gemiddelde_vultijd_s',vgm.Year,vgm.Week,vgm.Day
FROM GADATA.GLUE.vultijd_gemiddelde_mediaan as vgm
where
vgm.Controller LIKE @Teamstername
AND
vgm.time between LEFT(@StartDate,10) and LEFT(@EndDate,10)
END*/


 --select LEFT('2016-10-05 00:00:000',10)


 END