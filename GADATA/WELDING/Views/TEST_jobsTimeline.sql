CREATE VIEW WELDING.TEST_jobsTimeline
AS
SELECT        TOP (100) PERCENT NGAC.c_controller.controller_name, NGAC.rt_job.jobNo, Volvo.L_timeline.Vyear, Volvo.L_timeline.Vweek, Volvo.L_timeline.Vday, 
                         Volvo.L_timeline.shift, COUNT(NGAC.rt_job.ts_Start) AS jobstarts, Volvo.L_timeline.id
FROM            NGAC.rt_job INNER JOIN
                         NGAC.c_controller ON NGAC.rt_job.c_controller_id = NGAC.c_controller.id AND NGAC.rt_job.c_controller_id = NGAC.c_controller.id RIGHT OUTER JOIN
                         Volvo.L_timeline ON NGAC.rt_job.ts_Start BETWEEN Volvo.L_timeline.starttime AND Volvo.L_timeline.endtime
GROUP BY NGAC.c_controller.controller_name, NGAC.rt_job.jobNo, Volvo.L_timeline.Vyear, Volvo.L_timeline.Vweek, Volvo.L_timeline.Vday, Volvo.L_timeline.shift, 
                         Volvo.L_timeline.id
HAVING        (Volvo.L_timeline.id = 3766) OR
                         (Volvo.L_timeline.id = 3767) OR
                         (Volvo.L_timeline.id = 3765) OR
                         (Volvo.L_timeline.id = 3764)
ORDER BY NGAC.c_controller.controller_name DESC, NGAC.rt_job.jobNo DESC
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'TEST_jobsTimeline';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[24] 2[16] 3) )"
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
         Begin Table = "rt_job (NGAC)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 239
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c_controller (NGAC)"
            Begin Extent = 
               Top = 48
               Left = 286
               Bottom = 266
               Right = 468
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "L_timeline (Volvo)"
            Begin Extent = 
               Top = 24
               Left = 631
               Bottom = 236
               Right = 801
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
      Begin ColumnWidths = 11
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 13
         Column = 1440
         Alias = 1560
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
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'TEST_jobsTimeline';

