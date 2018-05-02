CREATE VIEW WELDING.WeldFaultProtocol
AS
SELECT        dbo.NPT.Name AS NPT, dbo.Timer.Name AS Timer, dbo.Spot.Number AS Spot, dbo.Spot.Program, dbo.WeldFaultLog.DateTime, 
                         dbo.WeldFaultName.WeldFaultName AS TimerFault, dbo.WeldFaultLog.WeldMasterComment, dbo.Users.CDSID, dbo.Timer.location, dbo.WeldFaultLog.ID, 
                         Volvo.L_timeline.Vyear, Volvo.L_timeline.Vweek, Volvo.L_timeline.Vday
FROM            dbo.NPT INNER JOIN
                         dbo.Timer ON dbo.NPT.ID = dbo.Timer.NptId AND dbo.NPT.ID = dbo.Timer.NptId AND dbo.NPT.ID = dbo.Timer.NptId INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldFaultLog ON dbo.Spot.ID = dbo.WeldFaultLog.SpotID AND dbo.Spot.ID = dbo.WeldFaultLog.SpotID INNER JOIN
                         dbo.WeldFaultName ON dbo.WeldFaultLog.WeldFaultID = dbo.WeldFaultName.ID AND dbo.WeldFaultLog.WeldFaultID = dbo.WeldFaultName.ID INNER JOIN
                         dbo.Users ON dbo.NPT.OwnerId = dbo.Users.ID LEFT OUTER JOIN
                         Volvo.L_timeline ON dbo.WeldFaultLog.DateTime BETWEEN Volvo.L_timeline.starttime AND Volvo.L_timeline.endtime
WHERE        (dbo.WeldFaultLog.DateTime > GETDATE() - 62)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'WeldFaultProtocol';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'gs = 280
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
         Width = 2340
         Width = 1500
         Width = 1170
         Width = 1500
         Width = 2325
         Width = 2010
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2175
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2310
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'WeldFaultProtocol';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[34] 4[27] 2[12] 3) )"
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
               Bottom = 175
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 306
               Right = 653
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldFaultLog"
            Begin Extent = 
               Top = 6
               Left = 691
               Bottom = 283
               Right = 897
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldFaultName"
            Begin Extent = 
               Top = 15
               Left = 980
               Bottom = 110
               Right = 1154
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 173
               Left = 10
               Bottom = 302
               Right = 180
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "L_timeline (Volvo)"
            Begin Extent = 
               Top = 136
               Left = 990
               Bottom = 265
               Right = 1160
            End
            DisplayFla', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'WeldFaultProtocol';

