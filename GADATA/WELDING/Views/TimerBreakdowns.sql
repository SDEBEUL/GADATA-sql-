CREATE VIEW WELDING.TimerBreakdowns
AS
SELECT        dbo.NPT.Name AS NPT, dbo.Timer.Name AS Timer, WELDING.breakdown.TimerFault, WELDING.breakdown.Starttime AS Errorstarttime, 
                         CAST(WELDING.breakdown.Breakdowntime AS datetime) AS converttime, WELDING.breakdown.Starttime + CAST(WELDING.breakdown.Breakdowntime AS Datetime) 
                         AS Errorendtime, WELDING.breakdown.Breakdowntime, dbo.Users.CDSID, Volvo.L_timeline.Vyear, Volvo.L_timeline.Vweek, Volvo.L_timeline.Vday, 
                         Volvo.L_timeline.shift, WELDING.breakdown.WMComment, WELDING.breakdown.ID
FROM            dbo.NPT INNER JOIN
                         dbo.Timer ON dbo.NPT.ID = dbo.Timer.NptId INNER JOIN
                         WELDING.breakdown ON dbo.Timer.ID = WELDING.breakdown.TimerID INNER JOIN
                         dbo.Users ON dbo.NPT.OwnerId = dbo.Users.ID LEFT OUTER JOIN
                         Volvo.L_timeline ON WELDING.breakdown.Starttime BETWEEN Volvo.L_timeline.starttime AND Volvo.L_timeline.endtime
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'n CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 5070
         Alias = 2400
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
', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'TimerBreakdowns';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'TimerBreakdowns';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[25] 2[15] 3) )"
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
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 135
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "breakdown (WELDING)"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 197
               Right = 626
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 175
               Left = 63
               Bottom = 304
               Right = 233
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "L_timeline (Volvo)"
            Begin Extent = 
               Top = 0
               Left = 705
               Bottom = 254
               Right = 840
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
      Begin ColumnWidths = 13
         Width = 284
         Width = 1500
         Width = 1500
         Width = 2550
         Width = 2145
         Width = 2340
         Width = 2775
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1260
      End
   End
   Begi', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'TimerBreakdowns';

