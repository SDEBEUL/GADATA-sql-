CREATE VIEW WELDING.TEST_AllJobsOnspot
AS
SELECT        TOP (100) PERCENT WELDING.TEST_RobotSpotorderNbr.Number AS Spot, WELDING.TEST_jobsTimeline.controller_name, 
                         SUM(WELDING.TEST_jobsTimeline.jobstarts) AS [Nmbr jobs], WELDING.TEST_jobsTimeline.Vyear, WELDING.TEST_jobsTimeline.Vweek, 
                         WELDING.TEST_jobsTimeline.Vday, WELDING.TEST_jobsTimeline.shift, WELDING.TEST_jobsTimeline.id AS ID_Timeline
FROM            WELDING.TEST_jobsTimeline INNER JOIN
                         WELDING.TEST_RobotSpotorderNbr ON WELDING.TEST_jobsTimeline.controller_name = WELDING.TEST_RobotSpotorderNbr.Robot AND 
                         WELDING.TEST_jobsTimeline.jobNo = WELDING.TEST_RobotSpotorderNbr.[order]
GROUP BY WELDING.TEST_RobotSpotorderNbr.Number, WELDING.TEST_jobsTimeline.controller_name, WELDING.TEST_jobsTimeline.Vyear, 
                         WELDING.TEST_jobsTimeline.Vweek, WELDING.TEST_jobsTimeline.Vday, WELDING.TEST_jobsTimeline.shift, WELDING.TEST_jobsTimeline.id
ORDER BY Spot DESC, WELDING.TEST_jobsTimeline.controller_name DESC
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'TEST_AllJobsOnspot';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[27] 2[3] 3) )"
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
         Begin Table = "TEST_jobsTimeline (WELDING)"
            Begin Extent = 
               Top = 89
               Left = 208
               Bottom = 360
               Right = 383
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TEST_RobotSpotorderNbr (WELDING)"
            Begin Extent = 
               Top = 54
               Left = 637
               Bottom = 357
               Right = 807
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
         Column = 4935
         Alias = 2100
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
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'TEST_AllJobsOnspot';

