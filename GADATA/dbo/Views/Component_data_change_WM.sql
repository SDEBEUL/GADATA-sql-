CREATE VIEW dbo.Component_data_change_WM
AS
SELECT        TOP (100) PERCENT dbo.NPT.Name AS NPT, dbo.Timer.Name AS Timer, dbo.Spot.Number, dbo.Spot.Program, dbo.SpotDataChange.DateTime, 
                         dbo.SpotDataChange.OldValue AS [Old parameter], dbo.SpotDataChange.NewValue AS [New parameter], dbo.TimerParameterName.Name AS parameter, 
                         dbo.TimerParameterName.Description, dbo.Users.CDSID, dbo.Users.Voornaam, dbo.Users.Achternaam
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.NPT ON dbo.Timer.NptId = dbo.NPT.ID INNER JOIN
                         dbo.SpotDataChange ON dbo.Spot.ID = dbo.SpotDataChange.SpotID INNER JOIN
                         dbo.Users ON dbo.SpotDataChange.UserID = dbo.Users.ID INNER JOIN
                         dbo.TimerParameterName ON dbo.SpotDataChange.ParameterID = dbo.TimerParameterName.ID
WHERE        (dbo.SpotDataChange.DateTime >= GETDATE() - 1)
ORDER BY NPT, Timer, dbo.SpotDataChange.DateTime
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Component_data_change_WM';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'      Width = 1710
         Width = 1275
         Width = 2160
         Width = 1050
         Width = 1575
         Width = 2100
         Width = 3660
         Width = 1500
         Width = 1500
         Width = 2175
         Width = 900
         Width = 1110
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
         Column = 2940
         Alias = 2040
         Table = 2265
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2655
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Component_data_change_WM';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[43] 4[15] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
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
         Begin Table = "Timer"
            Begin Extent = 
               Top = 6
               Left = 450
               Bottom = 135
               Right = 620
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 21
               Left = 213
               Bottom = 144
               Right = 412
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NPT"
            Begin Extent = 
               Top = 6
               Left = 658
               Bottom = 274
               Right = 828
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SpotDataChange"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 291
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 154
               Left = 264
               Bottom = 299
               Right = 434
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName"
            Begin Extent = 
               Top = 6
               Left = 866
               Bottom = 220
               Right = 1036
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
      Begin ColumnWidths = 21
         Width = 284
         Width = 2880
         Width = 1545
   ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Component_data_change_WM';

