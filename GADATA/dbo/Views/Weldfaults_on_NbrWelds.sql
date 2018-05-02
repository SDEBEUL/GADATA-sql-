CREATE VIEW dbo.Weldfaults_on_NbrWelds
AS
SELECT        TOP (100) PERCENT dbo.Timer.Name, dbo.Spot.Number, COUNT(dbo.WeldFaultName.WeldFaultName) AS [count of TimerFaults]
FROM            dbo.Spot INNER JOIN
                         dbo.WeldMeasurements ON dbo.Spot.ID = dbo.WeldMeasurements.SpotId INNER JOIN
                         dbo.WeldFaultName INNER JOIN
                         dbo.WeldFaultLog ON dbo.WeldFaultName.ID = dbo.WeldFaultLog.WeldFaultID ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID INNER JOIN
                         dbo.Timer ON dbo.Spot.TimerID = dbo.Timer.ID AND dbo.Spot.TimerID = dbo.Timer.ID AND dbo.Spot.TimerID = dbo.Timer.ID LEFT OUTER JOIN
                         Volvo.L_timeline ON dbo.WeldFaultLog.DateTime BETWEEN Volvo.L_timeline.starttime AND Volvo.L_timeline.endtime AND dbo.WeldMeasurements.Date BETWEEN 
                         Volvo.L_timeline.starttime AND Volvo.L_timeline.endtime
WHERE        (dbo.WeldMeasurements.Date >= GETDATE() - 14) AND (Volvo.L_timeline.starttime IS NOT NULL) AND (Volvo.L_timeline.endtime IS NOT NULL) AND 
                         (dbo.WeldFaultLog.DateTime >= GETDATE() - 14)
GROUP BY dbo.Spot.Number, dbo.Timer.Name
ORDER BY COUNT(dbo.WeldFaultName.WeldFaultName) DESC
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[37] 4[26] 2[21] 3) )"
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
               Top = 4
               Left = 588
               Bottom = 142
               Right = 787
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldMeasurements"
            Begin Extent = 
               Top = 55
               Left = 800
               Bottom = 266
               Right = 970
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "WeldFaultName"
            Begin Extent = 
               Top = 201
               Left = 187
               Bottom = 336
               Right = 361
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldFaultLog"
            Begin Extent = 
               Top = 6
               Left = 17
               Bottom = 250
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 188
               Left = 411
               Bottom = 308
               Right = 581
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "L_timeline (Volvo)"
            Begin Extent = 
               Top = 13
               Left = 1002
               Bottom = 265
               Right = 1172
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
      Begin ColumnWidths = 10
         Width = 284
         Width = 2820
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Weldfaults_on_NbrWelds';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Weldfaults_on_NbrWelds';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'         Width = 1260
         Width = 2205
         Width = 2505
         Width = 1305
         Width = 1095
         Width = 2400
         Width = 2460
         Width = 4140
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 5055
         Alias = 2490
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2880
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Weldfaults_on_NbrWelds';

