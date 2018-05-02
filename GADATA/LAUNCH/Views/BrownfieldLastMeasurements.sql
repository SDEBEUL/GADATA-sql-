﻿CREATE VIEW LAUNCH.BrownfieldLastMeasurements
AS
SELECT TOP (100) PERCENT dbo.Timer.Name, dbo.Spot.Number, dbo.WeldMeasurements.Date, dbo.WeldMeasurements.Shift, dbo.WeldMeasurements.NbrSplash, 
                  dbo.WeldMeasurements.NbrWeld, dbo.WeldMeasurements.NbrReweld, dbo.WeldMeasurements.AvgEnergy, dbo.WeldMeasurements.AvgPSF, 
                  dbo.WeldMeasurements.AvgOhm, dbo.WeldMeasurements.AvgUIP, dbo.WeldMeasurements.AvgWeldTIme, dbo.Spot.Program
FROM     dbo.WeldMeasurements INNER JOIN
                  dbo.Spot ON dbo.WeldMeasurements.SpotId = dbo.Spot.ID INNER JOIN
                  dbo.Timer ON dbo.Spot.TimerID = dbo.Timer.ID
WHERE  (dbo.WeldMeasurements.ID IN
                      (SELECT TOP (100) PERCENT MAX(DISTINCT WeldMeasurements_1.ID) AS ID
                       FROM      dbo.WeldMeasurements AS WeldMeasurements_1 INNER JOIN
                                         dbo.Spot AS Spot_1 ON WeldMeasurements_1.SpotId = Spot_1.ID
                       GROUP BY Spot_1.Number
                       HAVING  (Spot_1.Number > 29999) AND (Spot_1.Number < 50000)))
ORDER BY dbo.WeldMeasurements.Date, dbo.WeldMeasurements.Shift
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'BrownfieldLastMeasurements';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[27] 4[38] 2[16] 3) )"
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
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 197
               Right = 445
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 7
               Left = 561
               Bottom = 136
               Right = 731
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
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 12960
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'BrownfieldLastMeasurements';



