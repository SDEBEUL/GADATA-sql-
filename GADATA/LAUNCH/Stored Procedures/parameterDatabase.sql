-- =============================================
-- Author:		Coppejans Jens
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE LAUNCH.parameterDatabase 
	-- Add the parameters for the stored procedure here

@plate1 as decimal,
@plate2 as decimal,
@plate3 as decimal,
@plate4 as decimal,
@coating as bit,
@boron as bit

AS
BEGIN

	SET NOCOUNT ON;



 SELECT        LAUNCH.JoiningParameterPlatesGA.Pressure, LAUNCH.JoiningParameterPlatesGA.KA_1, LAUNCH.JoiningParameterPlatesGA.WELD1, 
                         LAUNCH.JoiningParameterPlatesGA.COOL_1, LAUNCH.JoiningParameterPlatesGA.KA_2, LAUNCH.JoiningParameterPlatesGA.WELD2, 
                         LAUNCH.JoiningParameterPlatesGA.COOL_2, LAUNCH.JoiningParameterPlatesGA.KA_3, LAUNCH.JoiningParameterPlatesGA.WELD3, 
                         LAUNCH.JoiningParameterPlatesGA.HOLD, LAUNCH.JoiningParameterPlatesGA.[PRprofile ON ?], LAUNCH.JoiningParameterPlatesGA.Number, 
                         AVG(dbo.WeldMeasurements.AvgPSF) AS AVGPSF, AVG(dbo.WeldMeasurements.StdPSF) AS stdPSF, LAUNCH.JoiningParameterPlatesGA.TIMER
FROM            dbo.Spot INNER JOIN
                         dbo.WeldMeasurements ON dbo.Spot.ID = dbo.WeldMeasurements.SpotId INNER JOIN
                         LAUNCH.JoiningParameterPlatesGA ON dbo.Spot.Number = LAUNCH.JoiningParameterPlatesGA.Number
WHERE        (LAUNCH.JoiningParameterPlatesGA.thickness1 = @plate1) AND (LAUNCH.JoiningParameterPlatesGA.Thickness2 = @plate2) AND (LAUNCH.JoiningParameterPlatesGA.Thickness2 = @plate3)
AND (LAUNCH.JoiningParameterPlatesGA.Thickness2 = @plate4)
AND 
                         (dbo.WeldMeasurements.Date >= GETDATE() - 5)
GROUP BY LAUNCH.JoiningParameterPlatesGA.Pressure, LAUNCH.JoiningParameterPlatesGA.KA_1, LAUNCH.JoiningParameterPlatesGA.WELD1, 
                         LAUNCH.JoiningParameterPlatesGA.COOL_1, LAUNCH.JoiningParameterPlatesGA.KA_2, LAUNCH.JoiningParameterPlatesGA.WELD2, 
                         LAUNCH.JoiningParameterPlatesGA.COOL_2, LAUNCH.JoiningParameterPlatesGA.KA_3, LAUNCH.JoiningParameterPlatesGA.WELD3, 
                         LAUNCH.JoiningParameterPlatesGA.HOLD, LAUNCH.JoiningParameterPlatesGA.[PRprofile ON ?], LAUNCH.JoiningParameterPlatesGA.Number, 
                         LAUNCH.JoiningParameterPlatesGA.TIMER 
	
END