CREATE VIEW UL.ExtraControles
AS
SELECT tbl3.statusAdaptive, tbl3.Model, tbl3.Robot, tbl3.spot, tbl3.[plan], tbl3.plannummer, 'Ultralog' AS typecontrole, tbl3.time_uit_adaptief, tbl3.durationOFF, NULL AS EndTime, 
                  tbl3.lastInspectiontime
FROM     (SELECT *, ROW_NUMBER() OVER (PARTITION BY spot
                  ORDER BY lastInspectiontime DESC) AS counterr
FROM     (SELECT dbo.Timer.Robot, dbo.Spot.Model, dbo.Spot.Number AS spot, UL.UitAdaptive_start.StatusAdaptive, UL.UitAdaptive_start.starttime AS time_uit_adaptief, 
                                    UL.UitAdaptive_start.DurationOFF, MAX(dbo.UltralogInspections.InspectionTime) AS lastInspectiontime, dbo.UltralogInspections.IndexOfTestSeq AS plannummer, 
                                    dbo.Inspectionplan.Name AS [plan], dbo.Inspectionplan.WorkLocation, dbo.Inspectionplan.WorkGroup
                  FROM      UL.UitAdaptive_start INNER JOIN
                                    dbo.Spot ON UL.UitAdaptive_start.SpotID = dbo.Spot.ID INNER JOIN
                                    dbo.Timer ON UL.UitAdaptive_start.TimerID = dbo.Timer.ID INNER JOIN
                                    dbo.UltralogInspections ON dbo.Spot.ID = dbo.UltralogInspections.SpotID INNER JOIN
                                    dbo.Inspectionplan ON dbo.UltralogInspections.InspectionPlanID = dbo.Inspectionplan.ID
									WHERE  (dbo.Inspectionplan.PlanActive = 1)
                  GROUP BY dbo.Timer.Robot, dbo.Spot.Model, dbo.Spot.Number, UL.UitAdaptive_start.StatusAdaptive, UL.UitAdaptive_start.starttime, UL.UitAdaptive_start.DurationOFF, 
                                    dbo.UltralogInspections.IndexOfTestSeq, dbo.Inspectionplan.Name, dbo.Inspectionplan.WorkLocation, dbo.Inspectionplan.WorkGroup) tbl2) tbl3
WHERE  tbl3.counterr = '1' AND tbl3.spot <> '4402266'
--UNION
--SELECT 'juist terug in adaptief' AS status, dbo.Spot.Model, dbo.Timer.Robot, dbo.Spot.Number AS spot, dbo.Inspectionplan.Name AS [plan], 
 --                 CAST(dbo.UltralogInspections.IndexOfTestSeq AS int) AS plannummer, 'Ultralog' AS typecontrole, UL.UitAdaptive_End.starttime, UL.UitAdaptive_End.DurationOFF, 
 --                 UL.UitAdaptive_End.EndTime, MAX(dbo.UltralogInspections.InspectionTime) AS lastInspectiontime
--FROM     dbo.UltralogInspections INNER JOIN
 --                 dbo.Spot ON dbo.UltralogInspections.SpotID = dbo.Spot.ID INNER JOIN
 --                 dbo.Inspectionplan ON dbo.UltralogInspections.InspectionPlanID = dbo.Inspectionplan.ID INNER JOIN
 --                 UL.UitAdaptive_End ON dbo.Spot.ID = UL.UitAdaptive_End.spotid INNER JOIN
 --                 dbo.Timer ON UL.UitAdaptive_End.Timerid = dbo.Timer.ID
--GROUP BY dbo.Timer.Robot, dbo.Spot.Model, dbo.Spot.Number, dbo.UltralogInspections.IndexOfTestSeq, dbo.Inspectionplan.Name, UL.UitAdaptive_End.starttime, 
 --              UL.UitAdaptive_End.EndTime, UL.UitAdaptive_End.DurationOFF
--HAVING (MAX(dbo.UltralogInspections.InspectionTime) < UL.UitAdaptive_End.EndTime)
UNION
SELECT NULL AS status, NULL AS model, tbl.location, NULL AS number, NULL AS ilplan, NULL AS plannummer, tbl.[SBCU alerts], tbl.Timestamp, NULL AS niets, NULL AS niets, NULL 
                  AS niets
FROM     (SELECT TOP (1000) Location, timestamp AS Timestamp, ROW_NUMBER() OVER (PARTITION BY location
                  ORDER BY timestamp DESC) AS Row#, 
                  CASE WHEN logtext LIKE 'SBCU OUT OF USE:%' THEN 'SBCU uit dienst' WHEN logtext LIKE '%Dsetup%' THEN 'SBCU warning' ELSE NULL END AS 'SBCU alerts'
FROM     Alerts.Alerts
WHERE  (Subgroup = 'SBCUalert') AND (timestamp BETWEEN GETDATE() - 1 AND GETDATE())) tbl
WHERE  tbl.Row# = '1'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[25] 4[45] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "UitAdaptive_start (UL)"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 168
               Right = 259
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 7
               Left = 307
               Bottom = 168
               Right = 555
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 7
               Left = 603
               Bottom = 168
               Right = 813
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UltralogInspections"
            Begin Extent = 
               Top = 7
               Left = 861
               Bottom = 168
               Right = 1099
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Inspectionplan"
            Begin Extent = 
               Top = 7
               Left = 1147
               Bottom = 168
               Right = 1357
            End
            DisplayFlags = 280
            TopColumn = 5
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin Crite', @level0type = N'SCHEMA', @level0name = N'UL', @level1type = N'VIEW', @level1name = N'ExtraControles';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'riaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'UL', @level1type = N'VIEW', @level1name = N'ExtraControles';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'UL', @level1type = N'VIEW', @level1name = N'ExtraControles';

