
-- ============================================= 
-- Author:     
-- Create date: <7/03/2017,,> 
-- Description:   
-- ============================================= 
CREATE PROCEDURE [dbo].[WeldingTool] @spot  AS VARCHAR(25), 
                                    @Timer AS VARCHAR(25) 
AS 
  BEGIN 
      SET nocount ON; 

      --- data from weldmeasurements--- 
      SELECT [date], 
             [name] 
             AS Timer, 
             number 
             AS Spotnr, 
             dbo.spot.program, 
             NULL 
             AS TimerFault, 
             NULL 
             AS ProductionLoss, 
             zone, 
             CONVERT(DECIMAL(5, 1), 100 * Cast(dbo.weldmeasurements.nbrsplash AS 
                                               DECIMAL(10, 5)) / 
                                    Cast(dbo.weldmeasurements.nbrweld AS 
                                         DECIMAL(10, 5))) AS 
             [Spatters%], 
             CONVERT(DECIMAL(5, 1), 100 * Cast(dbo.weldmeasurements.nbrreweld AS 
                                               DECIMAL(10, 5)) / 
                                    Cast(dbo.weldmeasurements.nbrweld AS 
                                         DECIMAL(10, 5))) AS 
             PsfReweld, 
             [nbrweld], 
             [avgenergy], 
             [avgpsf], 
             [stdpsf] 
             AS [%AfwijkingPSF], 
             [avgweldtime], 
             NULL 
             AS UltralogTime, 
             NULL 
             AS [Losse spot?], 
             NULL 
             AS [OK spot?], 
             NULL 
             AS [SmallNugget?], 
             NULL 
             AS [StickWeld?], 
             NULL 
             AS [BadTroughWeld?], 
             NULL 
             AS [MeasuredThickness], 
             NULL 
             AS [TotalThickness], 
             NULL 
             AS [InspectorComment], 
             NULL 
             AS bodynummer, 
             NULL 
             AS ParameterChange, 
             NULL 
             AS before, 
             NULL 
             AS after, 
             NULL 
             AS CDSID, 
             NULL 
             AS NPT, 
             NULL 
             AS [Pressure], 
             NULL 
             Squeeze, 
             NULL 
             AS [KA_1], 
             NULL 
             AS [WELD1], 
             NULL 
             AS [COOL_1], 
             NULL 
             AS [KA_2], 
             NULL 
             AS [WELD2], 
             NULL 
             AS [COOL_2], 
             NULL 
             AS [KA_3], 
             NULL 
             AS [WELD3], 
             NULL 
             AS [HOLD], 
             NULL 
             AS [PRprofile ON ?], 
             NULL 
             AS [thickness1], 
             NULL 
             AS [Material1], 
             NULL 
             AS [Coating1], 
             NULL 
             AS [Thickness2], 
             NULL 
             AS [Material2], 
             NULL 
             AS [Coating2], 
             NULL 
             AS [thickness3], 
             NULL 
             AS [Material3], 
             NULL 
             AS [Coating3], 
             NULL 
             AS [thickness4], 
             NULL 
             AS [Material4], 
             NULL 
             AS [Coating4] 
      FROM   [GADATA].[dbo].[weldmeasurements] 
             INNER JOIN dbo.spot 
                     ON dbo.weldmeasurements.spotid = dbo.spot.id 
             INNER JOIN [GADATA].[dbo].[timer] 
                     ON [GADATA].[dbo].[spot].timerid = 
                        [GADATA].[dbo].[timer].id 
      WHERE  [date] >= Getdate() - 365 
             AND number = @spot 
             AND NAME = @Timer 
      UNION 
      --- data from ultralog--- 
      SELECT dbo.ultraloginspections.inspectiontime, 
             dbo.timer.NAME                         AS timer, 
             dbo.spot.number, 
             dbo.spot.program, 
             NULL                                   AS TimerFault, 
             NULL                                   AS ProductionLoss, 
             NULL                                   AS Loose, 
             NULL                                   AS spot, 
             NULL                                   AS Expr1, 
             NULL                                   AS Expr2, 
             NULL                                   AS Expr3, 
             NULL                                   AS Expr4, 
             NULL                                   AS Expr5, 
             NULL                                   AS Expr6, 
             dbo.ultraloginspections.inspectiontime AS Expr7, 
             dbo.ultraloginspections.loose          AS Expr8, 
             dbo.ultraloginspections.ok, 
             dbo.ultraloginspections.smallnugget, 
             dbo.ultraloginspections.stickweld, 
             dbo.ultraloginspections.badtroughweld, 
             dbo.ultraloginspections.measuredthickness, 
             dbo.ultraloginspections.totalthickness, 
             dbo.ultraloginspections.inspectorcomment, 
             dbo.ultraloginspections.bodynbr, 
             NULL                                   AS Expr9, 
             NULL                                   AS Expr10, 
             NULL                                   AS ParameterChange, 
             NULL                                   AS before, 
             NULL                                   AS NPT, 
             NULL                                   AS Expr11, 
             NULL                                   AS Expr12, 
             NULL                                   AS Expr13, 
             NULL                                   AS Expr14, 
             NULL                                   AS Expr15, 
             NULL                                   AS Expr16, 
             NULL                                   AS Expr17, 
             NULL                                   AS Expr18, 
             NULL                                   AS Expr19, 
             NULL                                   AS Expr20, 
             NULL                                   AS Expr21, 
             NULL                                   AS Expr22, 
             NULL                                   AS Expr23, 
             NULL                                   AS Expr24, 
             NULL                                   AS Expr25, 
             NULL                                   AS Expr26, 
             NULL                                   AS Expr27, 
             NULL                                   AS Expr28, 
             NULL                                   AS Expr29, 
             NULL                                   AS Expr30, 
             NULL                                   AS Expr31, 
             NULL                                   AS thickness4, 
             NULL                                   AS Material4, 
             NULL                                   AS Coating4 
      FROM   dbo.ultraloginspections 
             INNER JOIN dbo.spot 
                     ON dbo.ultraloginspections.spotid = dbo.spot.id 
             INNER JOIN dbo.timer 
                     ON dbo.spot.timerid = dbo.timer.id 
                        AND dbo.spot.timerid = dbo.timer.id 
      WHERE  [inspectiontime] >= Getdate() - 365 
             AND number = @spot 
             AND dbo.timer.NAME = @Timer 
      UNION 
      --- data from dbo.datachange----data from schema Welding not possible => different data types used --- 
      SELECT dbo.spotdatachange.datetime, 
             dbo.timer.NAME, 
             dbo.spot.number, 
             dbo.spot.program, 
             NULL                               AS Expr1, 
             NULL                               AS spot, 
             dbo.spot.zone, 
             NULL                               AS spot1, 
             NULL                               AS spot2, 
             NULL                               AS spot3, 
             NULL                               AS spot4, 
             NULL                               AS spot5, 
             NULL                               AS spot7, 
             NULL                               AS spot8, 
             NULL                               AS spot9, 
             NULL                               AS spot10, 
             NULL                               AS spot11, 
             NULL                               AS spot13, 
             NULL                               AS spot14, 
             NULL                               AS spot15, 
             NULL                               AS spot16, 
             NULL                               AS spot17, 
             NULL                               AS spot19, 
             NULL                               AS spot100, 
             dbo.timerparametername.description AS parmameter, 
             dbo.spotdatachange.oldvalue, 
             dbo.spotdatachange.newvalue, 
             dbo.users.cdsid, 
             dbo.npt.NAME                       AS NPT, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS Spot, 
             NULL                               AS [thickness4], 
             NULL                               AS [Material4], 
             NULL                               AS [Coating4] 
      FROM   dbo.spot 
             INNER JOIN dbo.timer 
                     ON dbo.spot.timerid = dbo.timer.id 
                        AND dbo.spot.timerid = dbo.timer.id 
                        AND dbo.spot.timerid = dbo.timer.id 
             INNER JOIN dbo.spotdatachange 
                     ON dbo.spot.id = dbo.spotdatachange.spotid 
             INNER JOIN dbo.timerparametername 
                     ON dbo.spotdatachange.parameterid = 
                        dbo.timerparametername.id 
             INNER JOIN dbo.users 
                     ON dbo.spotdatachange.userid = dbo.users.id 
             INNER JOIN dbo.npt 
                     ON dbo.timer.nptid = dbo.npt.id 
                        AND dbo.timer.nptid = dbo.npt.id 
                        AND dbo.timer.nptid = dbo.npt.id 
      WHERE  ( dbo.spotdatachange.datetime >= Getdate() - 365 ) 
             AND dbo.spot.number = @spot 
             AND dbo.timer.NAME = @Timer 
      UNION 
      --- data from datachange on timer level --only timer data--- 
      SELECT dbo.timerdatachange.datetime AS Date, 
             dbo.timer.NAME               AS Timer, 
             @spot, 
             NULL                         AS spot, 
             NULL                         AS TimerFault, 
             NULL                         AS ProductionLoss, 
             NULL                         AS spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             dbo.timerparametername.description, 
             dbo.timerdatachange.oldvalue, 
             dbo.timerdatachange.newvalue, 
             dbo.users.cdsid, 
             dbo.npt.NAME                 AS NPT, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS Spot, 
             NULL                         AS [thickness4], 
             NULL                         AS [Material4], 
             NULL                         AS [Coating4] 
      FROM   dbo.timerparametername 
             INNER JOIN dbo.timerdatachange 
                     ON dbo.timerparametername.id = 
                        dbo.timerdatachange.parameterid 
             INNER JOIN dbo.users 
                     ON dbo.timerdatachange.userid = dbo.users.id 
             INNER JOIN dbo.timer 
                     ON dbo.timerdatachange.timerid = dbo.timer.id 
             INNER JOIN dbo.npt 
                     ON dbo.timer.nptid = dbo.npt.id 
      WHERE  datetime >= Getdate() - 365 
             AND dbo.timer.NAME = @Timer 
      UNION 
      --- plate and parameter combination--- 
      SELECT [date], 
             [timer], 
             number, 
             [program], 
             NULL AS TimerFault, 
             NULL AS ProductionLoss, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             NULL AS Spot, 
             [pressure], 
             [squeeze], 
             [ka_1], 
             [weld1], 
             [cool_1], 
             [ka_2], 
             [weld2], 
             [cool_2], 
             [ka_3], 
             [weld3], 
             [hold], 
             [prprofile on ?], 
             [thickness1], 
             [material1], 
             [coating1], 
             [thickness2], 
             [material2], 
             [coating2], 
             [thickness3], 
             [material3], 
             [coating3], 
             [thickness4], 
             [material4], 
             [coating4] 
      FROM   [GADATA].[LAUNCH].[joiningparameterplatesga] 
      WHERE  number = @spot 
             AND timer = @Timer 
      UNION 
      --- Show all TimerFaults ---- 
      SELECT datetime, 
             Name as timer, 
             number, 
             program , 
             WeldFaultName, 
             NULL    AS ProductionLoss, 
             NULL    AS WeldmasterComment, 
             NULL    AS spot, 
             NULL    AS Loose, 
             NULL    AS Expr1, 
             NULL    AS Expr2, 
             NULL    AS Expr3, 
             NULL    AS Expr4, 
             NULL    AS Expr5, 
             NULL    AS Expr6, 
             NULL    AS Expr9, 
             NULL    AS Expr10, 
             NULL    AS Expr12, 
             NULL    AS Expr13, 
             NULL    AS Expr14, 
             NULL    AS Expr15, 
             NULL    AS Expr16, 
             NULL    AS Expr17, 
             NULL    AS Expr18, 
             NULL    AS Expr19, 
             NULL    AS Expr20, 
             NULL    AS Expr21, 
             NULL    AS Expr22, 
             NULL    AS Expr23, 
             NULL    AS Expr24, 
             NULL    AS Expr25, 
             NULL    AS Expr26, 
             NULL    AS Expr27, 
             NULL    AS Expr28, 
             NULL    AS Expr29, 
             NULL    AS Expr30, 
             NULL    AS Expr31, 
             NULL    AS thickness4, 
             NULL    AS Material4, 
             NULL    AS Coating4, 
             NULL    AS Expr7, 
             NULL    AS Expr8, 
             NULL    AS Expr32, 
             NULL    AS Expr33, 
             NULL    AS Expr34, 
             NULL    AS Expr35, 
             NULL    AS Expr11, 
             NULL    AS Expr36, 
             NULL    AS Expr37, 
             NULL    AS Expr38, 
             NULL    AS Expr39, 
             NULL    AS Expr40, 
             NULL    AS Expr41 
     FROM            dbo.Timer INNER JOIN
                     dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                     dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID INNER JOIN
                     dbo.WeldFaultName ON dbo.WeldFaultLog.WeldFaultID = dbo.WeldFaultName.ID
      WHERE  datetime >= Getdate() - 365 
             AND number = @spot 
             AND Name = @Timer 
      UNION 
      --- TDT --- 
      ---From dbo.teardown----- 
      SELECT launch.teardowntest.date, 
             dbo.timer.NAME AS timer, 
             dbo.spot.number, 
             dbo.spot.program, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             launch.teardowntest.date, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             [nuggetdemand], 
             [teardownnugget], 
             NULL           AS TDTMTOComment, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             dbo.npt.NAME, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS Spot, 
             NULL           AS spot, 
             NULL           AS spot, 
             NULL           AS spot, 
             NULL           AS [thickness4], 
             NULL           AS [Material4], 
             NULL           AS [Coating4] 
      FROM   dbo.timer 
             INNER JOIN dbo.npt 
                     ON dbo.timer.nptid = dbo.npt.id 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND dbo.timer.id = dbo.spot.timerid 
             INNER JOIN launch.teardowntest 
                     ON dbo.spot.id = launch.teardowntest.spotid 
                        AND dbo.spot.id = launch.teardowntest.spotid 
                        AND dbo.spot.id = launch.teardowntest.spotid 
      WHERE  launch.teardowntest.date >= Getdate() - 600 
             AND number = @spot 
             AND dbo.timer.NAME = @timer 
  END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[WeldingTool] TO [AASPOT_a]
    AS [dbo];

