
-- ============================================= 
-- Author:    Coppejans Jens 
-- Create date:  
-- Description:   
-- ============================================= 
CREATE PROCEDURE [dbo].[PSFTool] @NPT CHAR(5) 
AS 
  BEGIN 
      SET nocount ON; 

      SELECT *, '70' as lowerTol
      FROM   (SELECT        dbo.NPT.Name as npt, dbo.Timer.Name AS timer, dbo.WeldMeasurements.Date, dbo.WeldMeasurements.Shift, dbo.Spot.Number as spotnummer, dbo.WeldMeasurements.AvgPSF, 
                         dbo.WeldMeasurements.NbrWeld, dbo.Spot.Program, dbo.WeldMeasurements.AvgPSF - 4 * dbo.WeldMeasurements.StdPSF AS stdDev, dbo.Spot.ID, 
                         dbo.WeldParameters.Value AS [Cond.TolBand]
FROM            dbo.WeldMeasurements INNER JOIN
                         dbo.Spot ON dbo.WeldMeasurements.SpotId = dbo.Spot.ID INNER JOIN
                         dbo.Timer ON dbo.Spot.TimerID = dbo.Timer.ID INNER JOIN
                         dbo.NPT ON dbo.Timer.NptId = dbo.NPT.ID INNER JOIN
                         dbo.WeldParameters ON dbo.Spot.ID = dbo.WeldParameters.SpotID INNER JOIN
                         dbo.TimerParameterName ON dbo.WeldParameters.ParameterNameID = dbo.TimerParameterName.ID
WHERE        (NOT (dbo.WeldMeasurements.AvgPSF IS NULL)) AND (dbo.WeldMeasurements.AvgPSF <> 0) AND (dbo.WeldMeasurements.Date >= CONVERT(DATETIME, 
                         '2017-01-01 00:00:00', 102)) AND (dbo.NPT.Name = @NPT) AND (dbo.TimerParameterName.ID = 55) )AS tbl1 
             INNER JOIN (SELECT dbo.npt.NAME, 
                                dbo.timer.NAME                   AS timers, 
                                dbo.spot.number, 
                                dbo.spot.program                 AS prg, 
                                Max(dbo.spotdatachange.newvalue) AS [Curve Date] 
                         FROM   dbo.npt 
                                INNER JOIN dbo.timer 
                                        ON dbo.npt.id = dbo.timer.nptid 
                                INNER JOIN dbo.spot 
                                        ON dbo.timer.id = dbo.spot.timerid 
                                INNER JOIN dbo.spotdatachange 
                                        ON dbo.spot.id = 
                                           dbo.spotdatachange.spotid 
                                INNER JOIN dbo.timerparametername 
                                        ON dbo.spotdatachange.parameterid = 
                                           dbo.timerparametername.id 
                         WHERE   dbo.timerparametername.description = 
                                  N'&Date/Time'  
                                AND dbo.npt.NAME = @NPT 
                         GROUP  BY dbo.npt.NAME, 
                                   dbo.timer.NAME, 
                                   dbo.spot.number, 
                                   dbo.spot.program) AS tbl2 
                     ON tbl1.spotnummer = tbl2.number 
  END