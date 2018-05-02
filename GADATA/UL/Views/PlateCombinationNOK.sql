CREATE VIEW UL.PlateCombinationNOK
AS
SELECT DISTINCT 
                         TOP (100) PERCENT COUNT(dbo.Spot.ID) AS CountNOKThickness, dbo.Inspectionplan.Name, dbo.Spot.Number, dbo.Timer.Name AS Expr2, 
                         dbo.NPT.Name AS Expr3
FROM            dbo.Inspectionplan INNER JOIN
                         dbo.UltralogInspections ON dbo.Inspectionplan.ID = dbo.UltralogInspections.InspectionPlanID INNER JOIN
                         dbo.Spot ON dbo.UltralogInspections.SpotID = dbo.Spot.ID INNER JOIN
                         dbo.Timer ON dbo.Spot.TimerID = dbo.Timer.ID AND dbo.Spot.TimerID = dbo.Timer.ID INNER JOIN
                         dbo.NPT ON dbo.Timer.NptId = dbo.NPT.ID
WHERE        (dbo.UltralogInspections.InspectionTime >= GETDATE() - 64)
GROUP BY dbo.UltralogInspections.TotalThickness, dbo.UltralogInspections.MeasuredThickness, dbo.Inspectionplan.Name, dbo.Spot.Number, dbo.Timer.Name, 
                         dbo.NPT.Name
HAVING        (dbo.UltralogInspections.MeasuredThickness > dbo.UltralogInspections.TotalThickness) AND (COUNT(dbo.Spot.ID) > 4)
ORDER BY COUNT(dbo.Spot.ID)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'UL', @level1type = N'VIEW', @level1name = N'PlateCombinationNOK';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 3885
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'UL', @level1type = N'VIEW', @level1name = N'PlateCombinationNOK';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[18] 2[17] 3) )"
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
         Begin Table = "Inspectionplan"
            Begin Extent = 
               Top = 14
               Left = 36
               Bottom = 229
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UltralogInspections"
            Begin Extent = 
               Top = 13
               Left = 257
               Bottom = 228
               Right = 450
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 13
               Left = 489
               Bottom = 230
               Right = 688
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 6
               Left = 726
               Bottom = 135
               Right = 896
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NPT"
            Begin Extent = 
               Top = 6
               Left = 934
               Bottom = 247
               Right = 1104
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
         Width = 2700
         Width = 3360
         Width = 1890
         Width = 3375
         Width = 1260
         Width = 5670
         Width = 2700
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900', @level0type = N'SCHEMA', @level0name = N'UL', @level1type = N'VIEW', @level1name = N'PlateCombinationNOK';

