CREATE PROCEDURE [dbo].[sp_UL_LooseSpotRep]

AS

if (OBJECT_ID('tempdb..#LooseSpotRep') is not null) drop table #LooseSpotRep
	SELECT 
		UltralogInspections.ID, 
		UltralogInspections.InspectionTime,
		UltralogInspections.SpotID,
		UltralogInspections.InspectorID,
		UltralogInspections.InspectorComment,
		UltralogInspections.IndexOfTestSeq, 
		UltralogInspections.Loose,
		ROW_NUMBER() OVER (PARTITION BY UltralogInspections.SpotID ORDER BY UltralogInspections.InspectionTime DESC) AS rnDESC 

	INTO #LooseSpotRep 
	FROM GADATA.dbo.UltralogInspections
	WHERE (UltralogInspections.InspectorComment LIKE '%Braam%') OR (UltralogInspections.InspectorComment LIKE '%Positie%') OR (UltralogInspections.Loose = 1 AND UltralogInspections.InspectorComment NOT LIKE '%Hamer%')


	SELECT 
		Spot.Number,
		#LooseSpotRep.ID,
		FirstOccurrence = LLooseSpotRep.InspectionTime, 
		#LooseSpotRep.InspectionTime AS 'recurrence',		
		Users.CDSID,
		#LooseSpotRep.InspectorComment,
		EersteEvaluatie = iif(#LooseSpotRep.Loose=1,'los','Positie of braam'),
		TweedeEvaluatie = iif(LLooseSpotRep.Loose=1,'los','Positie of braam'),	
		DATEDIFF(DAY,LLooseSpotRep.InspectionTime,#LooseSpotRep.InspectionTime) AS 'DaysBetweenReport'

	FROM #LooseSpotRep
	Join GADATA.dbo.Spot AS Spot
		ON (#LooseSpotRep.SpotID = Spot.ID)
	JOIN #LooseSpotRep AS LLooseSpotRep
		ON 
		(#LooseSpotRep.rnDESC = LLooseSpotRep.rnDESC - 1)  
        AND 
        (#LooseSpotRep.SpotID = LLooseSpotRep.SpotID)
	Join GADATA.dbo.Users AS Users
		ON (#LooseSpotRep.InspectorID = Users.ID)


	WHERE DATEDIFF(DAY,LLooseSpotRep.InspectionTime,#LooseSpotRep.InspectionTime) < 31
			  

ORDER BY FirstOccurrence ASC