CREATE PROCEDURE [dbo].[parameter_analyse]
	@startime as date = null,
	@plate1thickness as float = 0, 
	@plate2thickness as float = 0, 
	@plate3thickness as float = 0, 
	@plate4thickness as float = 0,
	@tollerance as float = 0
AS


	SELECT 		
 		Spot.Number,
		100*(1-(Sum(WeldMeasurements.NbrSplash*1.0)/Sum(WeldMeasurements.NbrWeld))) AS 'spatterfree%',
		Sum([NbrWeld]*[AvgEnergy])/Sum([NbrWeld]) AS 'energy',
		100*(1-Sum(WeldMeasurements.NbrReweld*1.0)/Sum(WeldMeasurements.NbrWeld)) AS 'PSF%',
		PlateCombination.ID AS 'PlateCombinationID',
		ParameterName.Name AS 'ParameterName',
		WeldParameters.Value,
		Spot.ElectrodeDia,
		p1.Thickness AS 'plate1 Thickness',
		p1.Material AS 'plate1 Material',
		p1.Coating AS 'plate1 Coating',
		p2.Thickness AS 'plate2 Thickness',
		p2.Material AS 'plate2 Material',
		p2.Coating AS 'plate2 Coating',
		p3.Thickness AS 'plate3 Thickness',
		p3.Material AS 'plate3 Material',
		p3.Coating AS 'plate3 Coating',
		p4.Thickness AS 'plate4 Thickness',
		p4.Material AS 'plate4 Material',
		p4.Coating AS 'plate4 Coating',
		Timer.Name AS 'timer',
		NPT.Name AS 'NPT',
		Spot.Zone AS 'Zone'
	FROM GADATA.dbo.Spot AS Spot
		JOIN GADATA.dbo.Timer AS Timer
			ON Timer.ID = Spot.TimerID
		JOIN GADATA.dbo.NPT AS NPT
			ON Timer.NptId = NPT.ID
		JOIN GADATA.dbo.PlateCombinations AS Platecombination
			ON Platecombination.ID = Spot.PlateCombinationtId
		JOIN GADATA.dbo.PlateType AS p1 
			ON  p1.ID = Platecombination.Plate1ID
		JOIN GADATA.dbo.PlateType AS p2 
			ON  p2.ID = Platecombination.Plate2ID
		JOIN GADATA.dbo.PlateType AS p3 
			ON  p3.ID = Platecombination.Plate3ID
		JOIN GADATA.dbo.PlateType AS p4 
			ON  p4.ID = Platecombination.Plate4ID
		JOIN GADATA.dbo.WeldMeasurements AS WeldMeasurements
			ON WeldMeasurements.SpotId = Spot.ID
		JOIN GADATA.dbo.WeldParameters AS WeldParameters 
			ON Spot.ID = WeldParameters.SpotID 
		JOIN GADATA.dbo.TimerParameterName AS ParameterName
			ON ParameterName.ID = WeldParameters.ParameterNameID
	WHERE (p1.Thickness)>=@plate1thickness-@tollerance And (p1.Thickness)<=@plate1thickness+@tollerance
		AND (p2.Thickness)>=@plate2thickness-@tollerance And (p2.Thickness)<=@plate2thickness+@tollerance
		AND (p3.Thickness)>=@plate3thickness-@tollerance And (p3.Thickness)<=@plate3thickness+@tollerance
		AND (p4.Thickness)>=@plate4thickness-@tollerance And (p4.Thickness)<=@plate4thickness+@tollerance
		AND WeldMeasurements.Date>@startime
	

	GROUP BY 
		Spot.Number, 
		PlateCombination.ID, 
		ParameterName.Name, 
		WeldParameters.Value, 
		Spot.ElectrodeDia, 
		p1.Thickness, 
		p1.Material, 
		p1.Coating, 
		p2.Thickness, 
		p2.Material, 
		p2.Coating,
		p3.Thickness, 
		p3.Material, 
		p3.Coating, 
		p4.Thickness, 
		p4.Material, 
		p4.Coating, 
		Timer.Name,
		Spot.Zone,
		NPT.Name