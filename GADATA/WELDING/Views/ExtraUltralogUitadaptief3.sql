CREATE VIEW WELDING.ExtraUltralogUitadaptief3
AS
SELECT        dbo.Timer.Name AS Timer, dbo.Spot.Number AS spot, WELDING.Qcontrol.[uit adaptief] AS uitAdaptief, dbo.NPT.Name AS NPT, dbo.Users.CDSID, 
                         MAX(dbo.WeldMeasurements.Date) AS Expr1
FROM            WELDING.Qcontrol INNER JOIN
                         dbo.Spot ON WELDING.Qcontrol.SpotID = dbo.Spot.ID INNER JOIN
                         dbo.Timer ON dbo.Spot.TimerID = dbo.Timer.ID AND dbo.Spot.TimerID = dbo.Timer.ID INNER JOIN
                         dbo.WeldMeasurements ON dbo.Spot.ID = dbo.WeldMeasurements.SpotId INNER JOIN
                         dbo.NPT ON dbo.Timer.NptId = dbo.NPT.ID AND dbo.Timer.NptId = dbo.NPT.ID INNER JOIN
                         dbo.Users ON dbo.NPT.OwnerId = dbo.Users.ID
GROUP BY dbo.Spot.Number, dbo.Timer.Name, WELDING.Qcontrol.[uit adaptief], dbo.NPT.Name, dbo.Users.CDSID
HAVING        (MAX(dbo.WeldMeasurements.Date) >= GETDATE() - 7) AND (WELDING.Qcontrol.[uit adaptief] = 1) AND (dbo.Spot.Number BETWEEN 20000 AND 49999) OR
                         (MAX(dbo.WeldMeasurements.Date) >= GETDATE() - 7) AND (WELDING.Qcontrol.[uit adaptief] = 1) AND (dbo.Spot.Number BETWEEN 4400000 AND 4419999)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'ExtraUltralogUitadaptief3';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3630
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
         Filter = 3000
         Or = 3495
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'ExtraUltralogUitadaptief3';






GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[22] 2[22] 3) )"
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
         Begin Table = "Qcontrol (WELDING)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 168
               Right = 260
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 7
               Left = 773
               Bottom = 136
               Right = 972
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 0
               Left = 1167
               Bottom = 197
               Right = 1337
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldMeasurements"
            Begin Extent = 
               Top = 176
               Left = 82
               Bottom = 305
               Right = 252
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NPT"
            Begin Extent = 
               Top = 151
               Left = 574
               Bottom = 280
               Right = 760
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 164
               Left = 856
               Bottom = 293
               Right = 1042
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
         Width = 1', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'ExtraUltralogUitadaptief3';





