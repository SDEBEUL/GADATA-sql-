CREATE VIEW LAUNCH.GreenFieldLastMeasurements
AS
SELECT        TOP (100) PERCENT dbo.NPT.Name AS NPT, dbo.Timer.Name, dbo.Spot.Number, dbo.Spot.Program, dbo.WeldMeasurements.Date, dbo.WeldMeasurements.Shift, 
                         dbo.WeldMeasurements.NbrSplash, dbo.WeldMeasurements.NbrWeld, dbo.WeldMeasurements.NbrReweld, dbo.WeldMeasurements.AvgEnergy, 
                         dbo.WeldMeasurements.AvgPSF, dbo.WeldMeasurements.AvgOhm, dbo.WeldMeasurements.AvgUIP, dbo.WeldMeasurements.AvgWeldTIme
FROM            dbo.WeldMeasurements INNER JOIN
                         dbo.Spot ON dbo.WeldMeasurements.SpotId = dbo.Spot.ID INNER JOIN
                         dbo.Timer ON dbo.Spot.TimerID = dbo.Timer.ID INNER JOIN
                         dbo.NPT ON dbo.Timer.NptId = dbo.NPT.ID
WHERE        (dbo.WeldMeasurements.ID IN
                             (SELECT        TOP (100) PERCENT MAX(DISTINCT WeldMeasurements_1.ID) AS ID
                               FROM            dbo.WeldMeasurements AS WeldMeasurements_1 INNER JOIN
                                                         dbo.Spot AS Spot_1 ON WeldMeasurements_1.SpotId = Spot_1.ID
                               GROUP BY Spot_1.Number
                               HAVING         (Spot_1.Number > 4400000) AND (Spot_1.Number < 4419999)))
ORDER BY dbo.WeldMeasurements.Date, dbo.WeldMeasurements.Shift
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'GreenFieldLastMeasurements';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'   GroupBy = 1350
         Filter = 18825
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'GreenFieldLastMeasurements';




GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[20] 4[23] 2[31] 3) )"
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
               Top = 5
               Left = 185
               Bottom = 134
               Right = 355
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 6
               Left = 419
               Bottom = 144
               Right = 618
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 0
               Left = 715
               Bottom = 129
               Right = 885
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NPT"
            Begin Extent = 
               Top = 3
               Left = 1044
               Bottom = 132
               Right = 1214
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
      Begin ColumnWidths = 14
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
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
      ', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'GreenFieldLastMeasurements';



