CREATE VIEW dbo.ErrorLog
AS
SELECT        TOP (100) PERCENT dbo.Timer.Robot, dbo.TimerErrorLog.DateTime, dbo.TimerErrorText.ErrorText
FROM            dbo.TimerErrorLog INNER JOIN
                         dbo.TimerErrorText ON dbo.TimerErrorLog.ErrorID = dbo.TimerErrorText.ID INNER JOIN
                         dbo.Timer ON dbo.TimerErrorLog.TimerID = dbo.Timer.ID
WHERE        (dbo.TimerErrorLog.DateTime >= GETDATE() - 365) AND (dbo.TimerErrorText.ID = 2 OR
                         dbo.TimerErrorText.ID = 3 OR
                         dbo.TimerErrorText.ID = 7 OR
                         dbo.TimerErrorText.ID = 10 OR
                         dbo.TimerErrorText.ID = 11 OR
                         dbo.TimerErrorText.ID = 17 OR
                         dbo.TimerErrorText.ID = 20 OR
                         dbo.TimerErrorText.ID = 21 OR
                         dbo.TimerErrorText.ID = 22 OR
                         dbo.TimerErrorText.ID = 24 OR
                         dbo.TimerErrorText.ID = 28 OR
                         dbo.TimerErrorText.ID = 29 OR
                         dbo.TimerErrorText.ID = 30 OR
                         dbo.TimerErrorText.ID = 36 OR
                         dbo.TimerErrorText.ID = 37 OR
                         dbo.TimerErrorText.ID = 38 OR
                         dbo.TimerErrorText.ID = 39 OR
                         dbo.TimerErrorText.ID = 40 OR
                         dbo.TimerErrorText.ID = 60)
ORDER BY dbo.TimerErrorLog.DateTime DESC
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'ErrorLog';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[30] 4[21] 2[22] 3) )"
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
         Begin Table = "TimerErrorLog"
            Begin Extent = 
               Top = 0
               Left = 781
               Bottom = 216
               Right = 951
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerErrorText"
            Begin Extent = 
               Top = 0
               Left = 987
               Bottom = 193
               Right = 1157
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 0
               Left = 467
               Bottom = 207
               Right = 637
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
         Width = 2430
         Width = 4500
         Width = 2940
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
         Filter = 10020
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'ErrorLog';

