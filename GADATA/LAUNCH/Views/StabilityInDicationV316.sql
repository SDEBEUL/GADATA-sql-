CREATE VIEW LAUNCH.StabilityInDicationV316
AS
SELECT DISTINCT 
                         TOP (100) PERCENT dbo.NPT.Name AS NPT, dbo.Timer.Name AS Timer, dbo.Spot.Program, dbo.Spot.Number, MAX(dbo.WeldMeasurements.NbrWeld) AS nbrWelds, 
                         dbo.WeldMeasurements.AvgPSF - 4 * dbo.WeldMeasurements.StdPSF AS StabiliteitsIni, dbo.ResponsibilityWM.responsibilityWM
FROM            dbo.Spot INNER JOIN
                         dbo.WeldMeasurements ON dbo.Spot.ID = dbo.WeldMeasurements.SpotId INNER JOIN
                         dbo.Timer ON dbo.Spot.TimerID = dbo.Timer.ID INNER JOIN
                         dbo.NPT ON dbo.Timer.NptId = dbo.NPT.ID INNER JOIN
                         dbo.ResponsibilityWM ON dbo.NPT.ID = dbo.ResponsibilityWM.NPTID
WHERE        (dbo.Spot.Number BETWEEN 4400000 AND 4419999) AND (dbo.WeldMeasurements.Date >= GETDATE() - 1) OR
                         (dbo.Spot.Number BETWEEN 30000 AND 49999) AND (dbo.WeldMeasurements.Date >= GETDATE() - 1)
GROUP BY dbo.WeldMeasurements.AvgPSF - 4 * dbo.WeldMeasurements.StdPSF, dbo.Timer.Name, dbo.NPT.Name, dbo.Spot.Program, dbo.Spot.Number, 
                         dbo.ResponsibilityWM.responsibilityWM
ORDER BY StabiliteitsIni DESC
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'StabilityInDicationV316';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'        Column = 2565
         Alias = 2085
         Table = 1965
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1410
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2880
         Or = 2520
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'StabilityInDicationV316';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[28] 4[28] 2[23] 3) )"
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
         Begin Table = "Spot"
            Begin Extent = 
               Top = 31
               Left = 298
               Bottom = 349
               Right = 497
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldMeasurements"
            Begin Extent = 
               Top = 7
               Left = 17
               Bottom = 384
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 6
               Left = 602
               Bottom = 135
               Right = 772
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NPT"
            Begin Extent = 
               Top = 6
               Left = 810
               Bottom = 223
               Right = 980
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ResponsibilityWM"
            Begin Extent = 
               Top = 6
               Left = 1018
               Bottom = 118
               Right = 1215
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
         Width = 960
         Width = 1320
         Width = 1500
         Width = 1650
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
 ', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'StabilityInDicationV316';

