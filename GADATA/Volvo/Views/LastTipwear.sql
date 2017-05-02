/* 
SELECT        TOP (100) PERCENT dbo.WeldingGun.Name, dbo.Timer.Robot, Volvo.Robots.controller_type, Volvo.Robots.location, dbo.TipWear.Date_Time, 
                         dbo.TipWear.BodysPerElectrode, dbo.TipWear.BodyRemaining
FROM            dbo.TipWear FULL OUTER JOIN
                         dbo.WeldingGun ON dbo.TipWear.WeldingGunId = dbo.WeldingGun.ID FULL OUTER JOIN
                         dbo.Timer ON dbo.Timer.ID = dbo.WeldingGun.TimerID FULL OUTER JOIN
                         Volvo.Robots ON dbo.Timer.Robot = Volvo.Robots.controller_name
WHERE        (dbo.TipWear.ID IN
                             (SELECT        MAX(ID) AS Expr1
                               FROM            dbo.TipWear AS TipWear_1
                               GROUP BY WeldingGunId))
ORDER BY dbo.Timer.Robot
*/
CREATE VIEW Volvo.LastTipwear
AS
SELECT        TOP (100) PERCENT dbo.WeldingGun.Name, dbo.Timer.Robot, Volvo.Robots.controller_type, Volvo.Robots.location, dbo.TipWear.Date_Time, 
                         dbo.TipWear.BodysPerElectrode, dbo.TipWear.BodyRemaining
FROM            dbo.TipWear INNER JOIN
                         dbo.WeldingGun ON dbo.TipWear.WeldingGunId = dbo.WeldingGun.ID FULL OUTER JOIN
                         dbo.Timer ON dbo.Timer.ID = dbo.WeldingGun.TimerID FULL OUTER JOIN
                         Volvo.Robots ON dbo.Timer.Robot = Volvo.Robots.controller_name
WHERE        (dbo.TipWear.ID IN
                             (SELECT        MAX(ID) AS Expr1
                               FROM            dbo.TipWear AS TipWear_1
                               GROUP BY WeldingGunId))
ORDER BY dbo.Timer.Robot
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'Volvo', @level1type = N'VIEW', @level1name = N'LastTipwear';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'nd
   End
End
', @level0type = N'SCHEMA', @level0name = N'Volvo', @level1type = N'VIEW', @level1name = N'LastTipwear';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[14] 2[48] 3) )"
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
         Begin Table = "TipWear"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 168
               Right = 267
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldingGun"
            Begin Extent = 
               Top = 7
               Left = 315
               Bottom = 168
               Right = 509
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 7
               Left = 557
               Bottom = 168
               Right = 751
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Robots (Volvo)"
            Begin Extent = 
               Top = 7
               Left = 799
               Bottom = 168
               Right = 1001
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
         Width = 1650
         Width = 1485
         Width = 1680
         Width = 2070
         Width = 1950
         Width = 1755
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2370
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
      E', @level0type = N'SCHEMA', @level0name = N'Volvo', @level1type = N'VIEW', @level1name = N'LastTipwear';



