CREATE VIEW dbo.[Joining_matrixes]
AS
SELECT        TOP (100) PERCENT dbo.Timer.Name, dbo.Timer.Robot, dbo.NPT.Name AS NPT, dbo.Spot.Number, dbo.Spot.ElectrodeDia, dbo.Spot.Program, dbo.Spot.Zone, 
                         Plate1.Thickness AS [Plate1 Thickness], Plate1.Material AS [Plate1 Material], Plate1.Coating AS [Plate1 Coating], Plate2.Thickness AS [Plate2 Thickness], 
                         Plate2.Material AS [Plate2 Material], Plate2.Coating AS [Plate2 Coating], Plate3.Thickness AS [Plate3 Thickness], Plate3.Material AS [Plate3 Material], 
                         Plate3.Coating AS [Plate3 Coating], Plate4.Thickness AS [Plate4 Thickness], Plate4.Material AS [Plate4 Material], Plate4.Coating AS [Plate4 Coating], 
                         dbo.WeldMeasurements.NbrWeld
FROM            dbo.PlateCombinations INNER JOIN
                         dbo.Spot ON dbo.PlateCombinations.ID = dbo.Spot.PlateCombinationtId INNER JOIN
                         dbo.Timer ON dbo.Spot.TimerID = dbo.Timer.ID INNER JOIN
                         dbo.NPT ON dbo.Timer.NptId = dbo.NPT.ID INNER JOIN
                         dbo.PlateType AS Plate2 ON dbo.PlateCombinations.Plate2ID = Plate2.ID INNER JOIN
                         dbo.PlateType AS Plate3 ON dbo.PlateCombinations.Plate3ID = Plate3.ID INNER JOIN
                         dbo.PlateType AS Plate4 ON dbo.PlateCombinations.Plate4ID = Plate4.ID INNER JOIN
                         dbo.PlateType AS Plate1 ON dbo.PlateCombinations.Plate1ID = Plate1.ID INNER JOIN
                         dbo.WeldMeasurements ON dbo.Spot.ID = dbo.WeldMeasurements.SpotId
WHERE        (dbo.Spot.Program <> 0)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[11] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
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
         Begin Table = "PlateCombinations"
            Begin Extent = 
               Top = 24
               Left = 322
               Bottom = 197
               Right = 492
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Plate2"
            Begin Extent = 
               Top = 126
               Left = 8
               Bottom = 255
               Right = 178
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 80
               Left = 528
               Bottom = 319
               Right = 727
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 16
               Left = 763
               Bottom = 169
               Right = 933
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NPT"
            Begin Extent = 
               Top = 219
               Left = 761
               Bottom = 375
               Right = 931
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Plate1"
            Begin Extent = 
               Top = 11
               Left = 9
               Bottom = 140
               Right = 179
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Plate4"
            Begin Extent = 
               Top = 274
               Left = 182
               Bottom = 403
               Right = 352
            End
            DisplayFlags = 280
   ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Joining_matrixes';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Joining_matrixes';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'         TopColumn = 0
         End
         Begin Table = "Plate3"
            Begin Extent = 
               Top = 233
               Left = 70
               Bottom = 362
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldMeasurements"
            Begin Extent = 
               Top = 0
               Left = 1167
               Bottom = 315
               Right = 1337
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
      Begin ColumnWidths = 26
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1890
         Width = 1680
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Joining_matrixes';

