CREATE VIEW dbo.UltralogMeasurementsIndentation
AS
SELECT        dbo.UltralogInspections.ID, dbo.Inspectionplan.Name, dbo.Spot.Number, dbo.Spot.PlateCombinationtId, dbo.PlateCombinations.Plate1ID, 
                         dbo.PlateCombinations.Plate2ID, dbo.PlateCombinations.Plate3ID, dbo.PlateCombinations.Plate4ID, dbo.UltralogInspections.BodyNbr, 
                         dbo.UltralogInspections.InspectorComment, dbo.Users.CDSID, dbo.UltralogInspections.InspectionTime, dbo.UltralogInspections.Loose, dbo.UltralogInspections.OK, 
                         dbo.UltralogInspections.SmallNugget, dbo.UltralogInspections.StickWeld, dbo.UltralogInspections.BadTroughWeld, dbo.UltralogInspections.MeasuredThickness, 
                         dbo.UltralogInspections.TotalThickness
FROM            dbo.UltralogInspections INNER JOIN
                         dbo.UltralogStations ON dbo.UltralogInspections.StationID = dbo.UltralogStations.ID INNER JOIN
                         dbo.Spot ON dbo.UltralogInspections.SpotID = dbo.Spot.ID INNER JOIN
                         dbo.Users ON dbo.UltralogInspections.InspectorID = dbo.Users.ID INNER JOIN
                         dbo.Inspectionplan ON dbo.UltralogInspections.InspectionPlanID = dbo.Inspectionplan.ID INNER JOIN
                         dbo.PlateCombinations ON dbo.Spot.PlateCombinationtId = dbo.PlateCombinations.ID
WHERE        (NOT (dbo.UltralogInspections.TotalThickness IS NULL))
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[43] 4[33] 2[7] 3) )"
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
         Begin Table = "UltralogInspections"
            Begin Extent = 
               Top = 0
               Left = 38
               Bottom = 367
               Right = 231
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UltralogStations"
            Begin Extent = 
               Top = 340
               Left = 305
               Bottom = 435
               Right = 475
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 41
               Left = 305
               Bottom = 275
               Right = 504
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 184
               Left = 304
               Bottom = 313
               Right = 474
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Inspectionplan"
            Begin Extent = 
               Top = 19
               Left = 508
               Bottom = 148
               Right = 678
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "PlateCombinations"
            Begin Extent = 
               Top = 158
               Left = 536
               Bottom = 307
               Right = 706
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
      Begin ColumnWidths = 20
         Width = 284
         Width = ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'UltralogMeasurementsIndentation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'UltralogMeasurementsIndentation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'UltralogMeasurementsIndentation';

