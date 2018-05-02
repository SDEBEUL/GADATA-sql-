CREATE VIEW WELDING.SmallNuggetsLastWeekV316
AS
SELECT        TOP (100) PERCENT dbo.NPT.Name AS NPT, dbo.Timer.Name AS Timer, SUM(CAST(dbo.UltralogInspections.SmallNugget AS INT)) AS smallnugget, 
                         dbo.Spot.Number AS spot
FROM            dbo.Spot INNER JOIN
                         dbo.UltralogInspections ON dbo.Spot.ID = dbo.UltralogInspections.SpotID INNER JOIN
                         dbo.Timer ON dbo.Spot.TimerID = dbo.Timer.ID INNER JOIN
                         dbo.NPT ON dbo.Timer.NptId = dbo.NPT.ID
WHERE        (dbo.Spot.Number BETWEEN 30000 AND 49999) AND (dbo.UltralogInspections.InspectionTime >= GETDATE() - 7) AND (dbo.UltralogInspections.SmallNugget = 1) OR
                         (dbo.Spot.Number BETWEEN 4400000 AND 4419999) AND (dbo.UltralogInspections.InspectionTime >= GETDATE() - 7) AND (dbo.UltralogInspections.SmallNugget = 1)
GROUP BY dbo.UltralogInspections.SmallNugget, dbo.Spot.Number, dbo.Timer.Name, dbo.NPT.Name
ORDER BY dbo.UltralogInspections.SmallNugget DESC
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'SmallNuggetsLastWeekV316';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'   End
End
', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'SmallNuggetsLastWeekV316';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[28] 2[21] 3) )"
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
         Begin Table = "Spot"
            Begin Extent = 
               Top = 7
               Left = 41
               Bottom = 162
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UltralogInspections"
            Begin Extent = 
               Top = 8
               Left = 369
               Bottom = 153
               Right = 562
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 5
               Left = 633
               Bottom = 134
               Right = 803
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NPT"
            Begin Extent = 
               Top = 6
               Left = 841
               Bottom = 149
               Right = 1011
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1575
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2295
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 3720
         Alias = 1695
         Table = 3870
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2610
         Or = 3015
         Or = 1350
         Or = 1350
      End
', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'SmallNuggetsLastWeekV316';

