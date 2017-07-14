CREATE PROCEDURE [dbo].[sp_UL_InspectionTimes]
	@pausetime AS datetime = null

AS


if (OBJECT_ID('tempdb..#UltralogInspectionsRnDesc') is not null) drop table #UltralogInspectionsRnDesc
	SELECT 
		UltralogInspections.ID, 
		UltralogInspections.InspectionTime,
		UltralogInspections.StationID, 
		--dbo_Inspectionplan.Name, 
		--dbo_Users.CDSID, 
		UltralogInspections.IndexOfTestSeq, 
		UltralogInspections.Loose,
		UltralogInspections.InspectionPlanID,
		UltralogInspections.InspectorID,
		ROW_NUMBER() OVER (PARTITION BY UltralogInspections.StationID ORDER BY UltralogInspections.InspectionTime DESC) AS rnDESC 

	INTO #UltralogInspectionsRnDesc 
	FROM GADATA.dbo.UltralogInspections


	SELECT
		
		#UltralogInspectionsRnDesc.InspectionTime,
		#UltralogInspectionsRnDesc.StationID, 
		#UltralogInspectionsRnDesc.IndexOfTestSeq, 
		#UltralogInspectionsRnDesc.Loose,
		cast((#UltralogInspectionsRnDesc.InspectionTime - LUltralogInspectionsRnDesc.InspectionTime) as float) AS 'inspectionDurationInsec',
		inspectionplan = Ip.Name,
		Inspector = Users.CDSID

	FROM #UltralogInspectionsRnDesc
	JOIN #UltralogInspectionsRnDesc AS LUltralogInspectionsRnDesc
		ON (#UltralogInspectionsRnDesc.rnDESC = LUltralogInspectionsRnDesc.rnDESC - 1.0)  
              AND 
              (#UltralogInspectionsRnDesc.StationID = LUltralogInspectionsRnDesc.StationID) 
	JOIN GADATA.dbo.Inspectionplan AS Ip
		On (#UltralogInspectionsRnDesc.InspectionPlanID = Ip.ID)
	JOIN GADATA.dbo.Users AS Users
		ON (#UltralogInspectionsRnDesc.InspectorID = Users.ID)
	WHERE #UltralogInspectionsRnDesc.IndexOfTestSeq > 1
		AND #UltralogInspectionsRnDesc.InspectionTime - LUltralogInspectionsRnDesc.InspectionTime < @pausetime