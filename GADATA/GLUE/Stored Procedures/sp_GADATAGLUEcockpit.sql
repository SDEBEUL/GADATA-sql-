





CREATE PROCEDURE [GLUE].[sp_GADATAGLUEcockpit]
--timeparameters
   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
--Filterparameters.
--   @Robot as varchar(25) = '54090r04%',
   @Teamstername as varchar(25) = null
AS
BEGIN

---------------------------------------------------------------------------------------
--Set default values of start and end date
---------------------------------------------------------------------------------------
if ((@StartDate is null) OR (@StartDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @StartDate = GETDATE()-40
END

if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()
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


SELECT DISTINCT  vgm.Controller as RobotName,vgm.time as timestamp,vgm.vultijd_s,vgm.Year,vgm.Week,vgm.Day,vgm.RefAVG,vgm.RefSTDEC,vgm.LCL,vgm.UCL,vgm.RefDp,vgm.RefSS
 FROM GADATA.glue.vultijdspcviewer as vgm
where 
vgm.Controller LIKE @Teamstername
AND
vgm.time between @StartDate and @EndDate



 END