-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [UL].[ImportLaptop6]

AS
BEGIN

	SET NOCOUNT ON;

---insert the ultralog data----

begin try

insert into GADATA.dbo.raw_Ultra_laptop6 

SELECT distinct localDB.[SpotName]
,localDB.[InspectionResultName]
,localDB.[EvaluationClass]
,localDB.[AutoComment]
,localDB.[InspectorComment]
,localDB.[ResultComment]
,localDB.[ResultCommentOperator]
,localDB.[NuggetDiameter]
,localDB.[NuggetDiameter2]
,localDB.[InspectionMethod]
,localDB.[PartName]
,localDB.[InspectionplanName]
,localDB.[GroupOfSpots]
,localDB.[WeldStation]
,localDB.[MeasuredThickness]
,localDB.[NamePlate1]
,localDB.[MaterialPlate1]
,localDB.[ThicknessPlate1]
,localDB.[NamePlate2]
,localDB.[MaterialPlate2]
,localDB.[ThicknessPlate2]
,localDB.[NamePlate3]
,localDB.[MaterialPlate3]
,localDB.[ThicknessPlate3]
,localDB.[Inspector]
,localDB.[NominalNuggetDiameter]
,localDB.[InspectionDate]
,localDB.[InspectionTime]
,localDB.[NumberOfSpots]
,localDB.[NumberOfOKSpots]
,localDB.[NumberOfNOKSpots]
,localDB.[IndexOfEvaluationClass]
,localDB.[IndexOfInspectionMethod]
,localDB.[CorrectProbeUsed]
,localDB.[UsedProbeName]
,localDB.[UsedProbeNumber]
,localDB.[UsedProbeDiameter]
,localDB.[UsedProbeFrequency]
,localDB.[ProbeControl]
,localDB.[BackwallEchoCnt]
,localDB.[FlawEchoCnt]
,localDB.[GasporeEchoCnt]
,localDB.[BackwallAmplitudeDifference1]
,localDB.[BackwallAmplitudeDifference2]
,localDB.[Gain]
,localDB.[DisplayDelay]
,localDB.[DisplayWidth]
,localDB.[SoundVelocity]
,localDB.[ProbeDelay]
,localDB.[UTInstrumentSetting]
,localDB.[UTEvaluationAssistance]
,localDB.[UTEvaluationAssistanceName]
,localDB.[AutoFreeze]
,localDB.[DefinedProbeName]
,localDB.[DefinedProbeNumber]
,localDB.[DefinedProbeDiameter]
,localDB.[DefinedProbeFrequency]
,localDB.[EvaluationThreshold]
,localDB.[EvaluationThresholdFE]
,localDB.[EvaluationThresholdGP]
,localDB.[ToleranceOfElectrodeMark]
,localDB.[ToleranceOfElectrodeMarkMM]
,localDB.[ToleranceOfGaspore]
,localDB.[GasporeEchos]
,localDB.[MinimumIndentation]
,localDB.[MinimumIndentationMM]
,localDB.[IndexOfTestsequence]
,localDB.[IndexOfPointSequence]
,localDB.[TestStation]
,localDB.[StoreOKResult]
,localDB.[StoreAscanResult]
,localDB.[ObjectplanProgrammer]
,localDB.[ObjectplanDate]
,localDB.[ObjectplanTime]
,localDB.[ObjectplanName]
,localDB.[ObjectplanPath]
,localDB.[Method]
,localDB.[SpotWeldType]
,localDB.[InspectionplanProgrammer]
,localDB.[InspectionplanDate]
,localDB.[InspectionplanTime]
,localDB.[InspectionResult]
,localDB.[IDInspection]
,localDB.[PlanID]
,localDB.[PartID]
,localDB.[JointID]
,localDB.[PartIdentification]
,localDB.[JointComment]
,localDB.[ResultFrameNumber]
,localDB.[FEEvaluationAfterIE]
,localDB.[USBoxSerialNo]
,localDB.[ExportToCentralDatastore]
,localDB.[EvaluationParameter]

                          
FROM            OPENQUERY([GNL100BS95BS1\SQLEXPRESS], 'select * from [UL_Laptop6].[dbo].[raw_Ultra_laptop6]') AS LocalDB LEFT OUTER JOIN
                         dbo.raw_Ultra_laptop6 ON LocalDB.InspectionTime = dbo.raw_Ultra_laptop6.InspectionTime AND 
                         LocalDB.InspectionDate = dbo.raw_Ultra_laptop6.InspectionDate AND LocalDB.SpotName = dbo.raw_Ultra_laptop6.SpotName
						 where dbo.raw_Ultra_laptop6.InspectionDate is null and dbo.raw_Ultra_laptop6.InspectionTime  is null

------delete local records older then a month-------
delete
from [GNL100BS95BS1\SQLEXPRESS].[UL_Laptop6].[dbo].[raw_Ultra_laptop6]
where InspectionDate  < Dateadd(day, -31, Getdate()) 

end try

begin catch
INSERT INTO [UL].[ErrorHandling]([procedure]
      ,[ErrorNumber]
      ,[ErrorSeverity]
      ,[ErrorState]
      ,[ErrorLine]
      ,[ErrorMessage]
	  ,[timestamp])

  SELECT 
    '[UL].[ImportLaptop6]_fault_catch'
    ,ERROR_NUMBER() AS ErrorNumber  
    ,ERROR_SEVERITY() AS ErrorSeverity  
    ,ERROR_STATE() AS ErrorState  
    ,ERROR_LINE() AS ErrorLine  
    ,ERROR_MESSAGE() AS ErrorMessage
	,GETDATE();  
end catch




END