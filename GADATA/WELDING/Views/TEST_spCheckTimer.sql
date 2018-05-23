CREATE VIEW WELDING.TEST_spCheckTimer
AS
SELECT        dbo.Timer.ID AS timerID, dbo.Timer.Robot, SUM(dbo.WeldMeasurements.NbrWeld - dbo.WeldMeasurements.NbrReweld) AS SUMWelds, Volvo.L_timeline.id
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID AND dbo.Timer.ID = dbo.Spot.TimerID AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldMeasurements ON dbo.Spot.ID = dbo.WeldMeasurements.SpotId AND dbo.Spot.ID = dbo.WeldMeasurements.SpotId AND 
                         dbo.Spot.ID = dbo.WeldMeasurements.SpotId INNER JOIN
                         Volvo.L_timeline ON dbo.WeldMeasurements.L_TimelineID = Volvo.L_timeline.id
WHERE        (dbo.WeldMeasurements.Date >= GETDATE() - 1)
GROUP BY dbo.Timer.ID, dbo.Timer.Robot, Volvo.L_timeline.id
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'TEST_spCheckTimer';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'     End
   End
End
', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'TEST_spCheckTimer';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[35] 2[20] 3) )"
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
               Bottom = 135
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 6
               Left = 262
               Bottom = 135
               Right = 477
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldMeasurements"
            Begin Extent = 
               Top = 6
               Left = 739
               Bottom = 135
               Right = 925
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "L_timeline (Volvo)"
            Begin Extent = 
               Top = 6
               Left = 515
               Bottom = 135
               Right = 701
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
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 5715
         Or = 1350
         Or = 1350
         Or = 1350
 ', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'TEST_spCheckTimer';

