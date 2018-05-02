CREATE VIEW WELDING.TimerBreakdowns_WMActions
AS
SELECT        TimerBreakdowns_2.NPT, TimerBreakdowns_2.Timer, TimerBreakdowns_2.TimerFault, TimerBreakdowns_2.Errorstarttime, TimerBreakdowns_2.Errorendtime, 
                         TimerBreakdowns_2.Breakdowntime, TimerBreakdowns_2.Vyear, TimerBreakdowns_2.Vweek, TimerBreakdowns_2.Vday, TimerBreakdowns_2.shift, tbl99.DateTime, 
                         tbl99.Description, tbl99.OldValue, tbl99.NewValue, tbl99.CDSID, TimerBreakdowns_2.WMComment
FROM            (SELECT        TOP (100) PERCENT WELDING.TimerBreakdowns.NPT, WELDING.TimerBreakdowns.Timer, WELDING.TimerBreakdowns.TimerFault, 
                                                    WELDING.TimerBreakdowns.Errorstarttime AS starttime, WELDING.TimerBreakdowns.Errorendtime AS endtime, 
                                                    WELDING.TimerBreakdowns.Breakdowntime, dbo.TimerDataChange.DateTime, dbo.TimerParameterName.Description, dbo.TimerDataChange.OldValue, 
                                                    dbo.TimerDataChange.NewValue, dbo.Users.CDSID
                          FROM            dbo.TimerDataChange INNER JOIN
                                                    dbo.Timer ON dbo.TimerDataChange.TimerID = dbo.Timer.ID INNER JOIN
                                                    WELDING.TimerBreakdowns ON dbo.Timer.Name = WELDING.TimerBreakdowns.Timer AND dbo.TimerDataChange.DateTime BETWEEN 
                                                    WELDING.TimerBreakdowns.Errorstarttime AND WELDING.TimerBreakdowns.Errorendtime INNER JOIN
                                                    dbo.TimerParameterName ON dbo.TimerDataChange.ParameterID = dbo.TimerParameterName.ID INNER JOIN
                                                    dbo.Users ON dbo.TimerDataChange.UserID = dbo.Users.ID
                          WHERE        (dbo.TimerParameterName.Description = N'monitoring (S)')
                          UNION
                          SELECT        TOP (100) PERCENT TimerBreakdowns_1.NPT, TimerBreakdowns_1.Timer, TimerBreakdowns_1.TimerFault, 
                                                   TimerBreakdowns_1.Errorstarttime AS starttime, TimerBreakdowns_1.Errorendtime AS endtime, TimerBreakdowns_1.Breakdowntime, 
                                                   dbo.SpotDataChange.DateTime AS datachangetime, TimerParameterName_1.Description, dbo.SpotDataChange.OldValue, 
                                                   dbo.SpotDataChange.NewValue, Users_1.CDSID
                          FROM            dbo.SpotDataChange INNER JOIN
                                                   dbo.Spot ON dbo.SpotDataChange.SpotID = dbo.Spot.ID INNER JOIN
                                                   dbo.TimerParameterName AS TimerParameterName_1 ON dbo.SpotDataChange.ParameterID = TimerParameterName_1.ID INNER JOIN
                                                   dbo.Timer AS Timer_1 ON dbo.Spot.TimerID = Timer_1.ID INNER JOIN
                                                   dbo.Users AS Users_1 ON dbo.SpotDataChange.UserID = Users_1.ID RIGHT OUTER JOIN
                                                   WELDING.TimerBreakdowns AS TimerBreakdowns_1 ON Timer_1.Name = TimerBreakdowns_1.Timer AND dbo.SpotDataChange.DateTime BETWEEN 
                                                   TimerBreakdowns_1.Errorstarttime AND TimerBreakdowns_1.Errorendtime
                          WHERE        (TimerParameterName_1.Description = N'monitoring (P)')) AS tbl99 RIGHT OUTER JOIN
                         WELDING.TimerBreakdowns AS TimerBreakdowns_2 ON tbl99.DateTime BETWEEN TimerBreakdowns_2.Errorstarttime AND 
                         TimerBreakdowns_2.Errorendtime
WHERE        (CASE WHEN tbl99.Timer = TimerBreakdowns_2.Timer OR
                         tbl99.Timer IS NULL THEN 1 ELSE '0' END = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'TimerBreakdowns_WMActions';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[35] 4[24] 2[22] 3) )"
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
         Begin Table = "tbl99"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 273
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerBreakdowns_2"
            Begin Extent = 
               Top = 0
               Left = 440
               Bottom = 289
               Right = 612
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 19
         Width = 284
         Width = 2640
         Width = 1575
         Width = 2625
         Width = 2490
         Width = 2325
         Width = 2760
         Width = 2190
         Width = 1995
         Width = 2475
         Width = 1200
         Width = 2130
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
      Begin ColumnWidths = 11
         Column = 2040
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2580
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'TimerBreakdowns_WMActions';

