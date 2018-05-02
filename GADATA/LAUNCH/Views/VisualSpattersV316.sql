CREATE VIEW LAUNCH.VisualSpattersV316
AS
SELECT        WeldMeasurements.Date, WeldMeasurements.Shift, WeldMeasurements.NbrSplash, WeldMeasurements.NbrWeld, Spot.Zone, Spot.Comment1, Spot.Comment2, 
                         Spot.Comment3, NPT.Name AS NPT, Timer.Name AS timer, Spot.Number, Volvo.L_timeline.Vday, Volvo.L_timeline.Vweek, Volvo.L_timeline.Vyear, 
                         CONVERT(DECIMAL(5, 1), 100 - 100 * CAST(WeldMeasurements.NbrSplash AS decimal(10, 5)) / CAST(WeldMeasurements.NbrWeld AS decimal(10, 5))) 
                         AS 'SpatterFree%'
FROM            dbo.NPT AS NPT INNER JOIN
                         dbo.Timer AS Timer ON NPT.ID = Timer.NptId INNER JOIN
                         dbo.WeldMeasurements AS WeldMeasurements INNER JOIN
                         dbo.Spot AS Spot ON WeldMeasurements.SpotId = Spot.ID ON Timer.ID = Spot.TimerID INNER JOIN
                         Volvo.L_timeline ON WeldMeasurements.L_TimelineID = Volvo.L_timeline.id
WHERE        (WeldMeasurements.Date > '2017-01-15') AND (Spot.Zone > 60) AND (Spot.Zone < 70)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[44] 4[17] 2[20] 3) )"
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
         Begin Table = "NPT"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 209
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 197
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldMeasurements"
            Begin Extent = 
               Top = 0
               Left = 451
               Bottom = 361
               Right = 621
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 6
               Left = 662
               Bottom = 334
               Right = 861
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "L_timeline (Volvo)"
            Begin Extent = 
               Top = 210
               Left = 173
               Bottom = 339
               Right = 343
            End
            DisplayFlags = 280
            TopColumn = 4
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 16
         Width = 284
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
      ', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'VisualSpattersV316';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'VisualSpattersV316';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'   Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 13
         Column = 14430
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
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'VisualSpattersV316';

