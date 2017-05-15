CREATE VIEW dbo.Weldfault_WM_change
AS
SELECT        TOP (100) PERCENT dbo.Spot.Number, dbo.NPT.Name, dbo.Users.CDSID, dbo.Spot.Program, dbo.TimerParameterName.Description, dbo.SpotDataChange.OldValue, 
                         dbo.SpotDataChange.NewValue, dbo.SpotDataChange.DateTime, dbo.Timer.Robot
FROM            dbo.Spot INNER JOIN
                         dbo.Timer ON dbo.Spot.TimerID = dbo.Timer.ID AND dbo.Spot.TimerID = dbo.Timer.ID INNER JOIN
                         dbo.NPT ON dbo.Timer.NptId = dbo.NPT.ID INNER JOIN
                         dbo.SpotDataChange ON dbo.Spot.ID = dbo.SpotDataChange.SpotID AND dbo.Spot.ID = dbo.SpotDataChange.SpotID INNER JOIN
                         dbo.TimerParameterName ON dbo.SpotDataChange.ParameterID = dbo.TimerParameterName.ID AND 
                         dbo.SpotDataChange.ParameterID = dbo.TimerParameterName.ID INNER JOIN
                         dbo.Users ON dbo.SpotDataChange.UserID = dbo.Users.ID AND dbo.SpotDataChange.UserID = dbo.Users.ID
WHERE        (dbo.SpotDataChange.DateTime >= GETDATE() - 365)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Weldfault_WM_change';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'        Width = 1140
         Width = 780
         Width = 4920
         Width = 735
         Width = 990
         Width = 2505
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
         Table = 2970
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 11880
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Weldfault_WM_change';






GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[26] 2[17] 3) )"
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
               Top = 6
               Left = 38
               Bottom = 135
               Right = 237
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 6
               Left = 275
               Bottom = 135
               Right = 445
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NPT"
            Begin Extent = 
               Top = 6
               Left = 483
               Bottom = 135
               Right = 653
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SpotDataChange"
            Begin Extent = 
               Top = 6
               Left = 691
               Bottom = 135
               Right = 861
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName"
            Begin Extent = 
               Top = 6
               Left = 899
               Bottom = 135
               Right = 1069
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 6
               Left = 1107
               Bottom = 135
               Right = 1277
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
      Begin ColumnWidths = 15
         Width = 284
         Width = 1500
         Width = 1500
 ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Weldfault_WM_change';



