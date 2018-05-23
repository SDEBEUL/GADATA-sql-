CREATE VIEW WELDING.TEST_AllJobMeasurements
AS
SELECT        TOP (100) PERCENT WELDING.TEST_AllJobsOnspot.controller_name, WELDING.TEST_AllJobsOnspot.Spot, WELDING.TEST_AllJobsOnspot.[Nmbr jobs], 
                         WELDING.TEST_AllJobsOnspot.Vyear, WELDING.TEST_AllJobsOnspot.Vweek, WELDING.TEST_AllJobsOnspot.Vday, WELDING.TEST_AllJobsOnspot.shift, 
                         dbo.WeldMeasurements.NbrWeld - dbo.WeldMeasurements.NbrReweld - WELDING.TEST_AllJobsOnspot.[Nmbr jobs] AS diffbetween_timer_and_job
FROM            dbo.WeldMeasurements INNER JOIN
                         WELDING.TEST_AllJobsOnspot ON dbo.WeldMeasurements.L_TimelineID = WELDING.TEST_AllJobsOnspot.ID_Timeline INNER JOIN
                         dbo.Spot ON dbo.WeldMeasurements.SpotId = dbo.Spot.ID AND dbo.WeldMeasurements.SpotId = dbo.Spot.ID AND dbo.WeldMeasurements.SpotId = dbo.Spot.ID AND
                          dbo.WeldMeasurements.SpotId = dbo.Spot.ID AND WELDING.TEST_AllJobsOnspot.Spot = dbo.Spot.Number
ORDER BY dbo.WeldMeasurements.NbrWeld - dbo.WeldMeasurements.NbrReweld - WELDING.TEST_AllJobsOnspot.[Nmbr jobs] DESC
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'TEST_AllJobMeasurements';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[30] 4[23] 2[14] 3) )"
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
         Begin Table = "WeldMeasurements"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 157
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 13
         End
         Begin Table = "TEST_AllJobsOnspot (WELDING)"
            Begin Extent = 
               Top = 87
               Left = 261
               Bottom = 254
               Right = 436
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 14
               Left = 489
               Bottom = 286
               Right = 688
            End
            DisplayFlags = 280
            TopColumn = 5
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1260
         Width = 2580
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2745
         Alias = 1800
         Table = 2055
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2205
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'TEST_AllJobMeasurements';

