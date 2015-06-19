CREATE VIEW dbo.UltralogMeasurements
AS
SELECT dbo.UltralogInspections.InspectionTime, dbo.Inspectionplan.Name, dbo.Users.CDSID, dbo.Spot.Number, dbo.Timer.Robot, dbo.UltralogInspections.BodyNbr, 
                  dbo.UltralogInspections.InspectorComment, dbo.UltralogInspections.OK, dbo.UltralogInspections.Loose, dbo.UltralogInspections.SmallNugget, 
                  dbo.UltralogInspections.StickWeld, dbo.UltralogInspections.BadTroughWeld, dbo.UltralogInspections.MeasuredThickness, dbo.UltralogInspections.MinIdentation, 
                  dbo.UltralogInspections.TotalThickness, dbo.PlateType.Thickness AS Pl1Thickness, dbo.PlateType.Material AS Pl1material, dbo.PlateType.Coating AS Pl1Coating, 
                  PlateType_1.Thickness AS Pl2Thickness, PlateType_1.Material AS Pl2material, PlateType_1.Coating AS Pl2Coating, PlateType_2.Thickness AS Pl3Thickness, 
                  PlateType_2.Material AS Pl3material, PlateType_2.Coating AS Pl3Coating, PlateType_3.Thickness AS Pl4Thickness, PlateType_3.Material AS Pl4material, 
                  PlateType_3.Coating AS Pl4Coating
FROM     dbo.Spot INNER JOIN
                  dbo.Inspectionplan INNER JOIN
                  dbo.UltralogInspections ON dbo.Inspectionplan.ID = dbo.UltralogInspections.InspectionPlanID ON dbo.Spot.ID = dbo.UltralogInspections.SpotID INNER JOIN
                  dbo.UltralogStations ON dbo.UltralogInspections.StationID = dbo.UltralogStations.ID INNER JOIN
                  dbo.Users ON dbo.UltralogInspections.InspectorID = dbo.Users.ID INNER JOIN
                  dbo.Timer ON dbo.Spot.TimerID = dbo.Timer.ID INNER JOIN
                  dbo.PlateCombinations ON dbo.Spot.PlateCombinationtId = dbo.PlateCombinations.ID INNER JOIN
                  dbo.PlateType ON dbo.PlateCombinations.Plate1ID = dbo.PlateType.ID INNER JOIN
                  dbo.PlateType AS PlateType_1 ON dbo.PlateCombinations.Plate2ID = PlateType_1.ID INNER JOIN
                  dbo.PlateType AS PlateType_2 ON dbo.PlateCombinations.Plate3ID = PlateType_2.ID INNER JOIN
                  dbo.PlateType AS PlateType_3 ON dbo.PlateCombinations.Plate4ID = PlateType_3.ID
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'UltralogMeasurements';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateType"
            Begin Extent = 
               Top = 13
               Left = 1146
               Bottom = 174
               Right = 1340
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateType_1"
            Begin Extent = 
               Top = 175
               Left = 1151
               Bottom = 336
               Right = 1345
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateType_2"
            Begin Extent = 
               Top = 331
               Left = 1163
               Bottom = 492
               Right = 1357
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateType_3"
            Begin Extent = 
               Top = 446
               Left = 1152
               Bottom = 607
               Right = 1346
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 33
         Width = 284
         Width = 1992
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
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 2136
         Width = 1476
         Width = 1032
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
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1956
         Alias = 1512
         Table = 1872
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'UltralogMeasurements';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[45] 4[15] 2[20] 3) )"
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
         Top = -240
         Left = -240
      End
      Begin Tables = 
         Begin Table = "Spot"
            Begin Extent = 
               Top = 106
               Left = 549
               Bottom = 434
               Right = 781
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Inspectionplan"
            Begin Extent = 
               Top = 34
               Left = 0
               Bottom = 238
               Right = 194
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UltralogInspections"
            Begin Extent = 
               Top = 12
               Left = 270
               Bottom = 466
               Right = 492
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UltralogStations"
            Begin Extent = 
               Top = 406
               Left = 0
               Bottom = 523
               Right = 194
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 230
               Left = 0
               Bottom = 391
               Right = 194
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 306
               Left = 843
               Bottom = 467
               Right = 1037
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateCombinations"
            Begin Extent = 
               Top = 31
               Left = 890
               Bottom = 224
               Right = 1087
           ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'UltralogMeasurements';

