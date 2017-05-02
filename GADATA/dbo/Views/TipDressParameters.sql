CREATE VIEW dbo.TipDressParameters
AS
SELECT TOP (100) PERCENT dbo.SpotDataChange.DateTime, dbo.NPT.Name AS NPT, dbo.Timer.Name AS Timer, dbo.Spot.Program AS Electrode, 
                  dbo.TimerParameterName.Description, dbo.SpotDataChange.OldValue, dbo.SpotDataChange.NewValue, dbo.Users.CDSID
FROM     dbo.SpotDataChange INNER JOIN
                  dbo.Spot ON dbo.SpotDataChange.SpotID = dbo.Spot.ID INNER JOIN
                  dbo.Timer ON dbo.Spot.TimerID = dbo.Timer.ID INNER JOIN
                  dbo.NPT ON dbo.Timer.NptId = dbo.NPT.ID INNER JOIN
                  dbo.TimerParameterName ON dbo.SpotDataChange.ParameterID = dbo.TimerParameterName.ID INNER JOIN
                  dbo.Users ON dbo.SpotDataChange.UserID = dbo.Users.ID
WHERE  (dbo.TimerParameterName.LocalDbID = 90) OR
                  (dbo.TimerParameterName.LocalDbID = 97) OR
                  (dbo.TimerParameterName.LocalDbID = 100) OR
                  (dbo.TimerParameterName.LocalDbID = 91)
ORDER BY dbo.SpotDataChange.DateTime
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'TipDressParameters';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'         Width = 1620
         Width = 1200
         Width = 2028
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
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
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'TipDressParameters';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[19] 2[20] 3) )"
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
         Begin Table = "SpotDataChange"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 269
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 254
               Right = 522
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 7
               Left = 570
               Bottom = 198
               Right = 764
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NPT"
            Begin Extent = 
               Top = 7
               Left = 812
               Bottom = 212
               Right = 1006
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName"
            Begin Extent = 
               Top = 154
               Left = 572
               Bottom = 315
               Right = 766
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 199
               Left = 803
               Bottom = 360
               Right = 997
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
         Width = 2496
         Width = 1200
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'TipDressParameters';

