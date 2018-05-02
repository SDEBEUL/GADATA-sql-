CREATE VIEW dbo.BatteryLow
AS
SELECT        TOP (100) PERCENT dbo.NPT.Name AS NPT, dbo.Timer.Name AS timer, dbo.TimerErrorText.ErrorText
FROM            dbo.Timer INNER JOIN
                         dbo.TimerErrorLog ON dbo.Timer.ID = dbo.TimerErrorLog.TimerID INNER JOIN
                         dbo.TimerErrorText ON dbo.TimerErrorLog.ErrorID = dbo.TimerErrorText.ID INNER JOIN
                         dbo.NPT ON dbo.Timer.NptId = dbo.NPT.ID
WHERE        (dbo.TimerErrorLog.DateTime >= GETDATE() - 7)
GROUP BY dbo.Timer.Name, dbo.NPT.Name, dbo.TimerErrorText.ErrorText, dbo.Timer.NptId
HAVING        (dbo.TimerErrorText.ErrorText = N'Battery Low')
ORDER BY NPT
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'BatteryLow';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'BatteryLow';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[20] 2[18] 3) )"
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
         Begin Table = "Timer"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 189
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerErrorLog"
            Begin Extent = 
               Top = 1
               Left = 867
               Bottom = 255
               Right = 1037
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerErrorText"
            Begin Extent = 
               Top = 91
               Left = 305
               Bottom = 333
               Right = 475
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NPT"
            Begin Extent = 
               Top = 161
               Left = 654
               Bottom = 365
               Right = 824
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
         Width = 2205
         Width = 2205
         Width = 2835
         Width = 1965
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1800
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1980
         Or = 1350
         Or = 1350
         Or = 1350
     ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'BatteryLow';

