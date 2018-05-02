CREATE VIEW LAUNCH.DoubleSpots_4CharactersWithMeasurements
AS
SELECT        TOP (100) PERCENT LAUNCH.spotsV316_4Characters.NPT, LAUNCH.spotsV316_4Characters.Timer, LAUNCH.spotsV316_4Characters.SpotsV316, 
                         LAUNCH.spotsV316_4Characters.SpotName, LAUNCH.GreenFieldLastMeasurements.Date AS LastWeldGreenfield, 
                         LAUNCH.GreenFieldLastMeasurements.AvgEnergy AS EnergyGreenfield, LAUNCH.GreenFieldLastMeasurements.NbrWeld AS nrbWeldsGreenfield, 
                         LAUNCH.BrownfieldLastMeasurements.Date AS LastWeldBrownField, LAUNCH.BrownfieldLastMeasurements.AvgEnergy AS EnergyBrownField, 
                         LAUNCH.BrownfieldLastMeasurements.NbrWeld AS nbrWeldBrownField
FROM            LAUNCH.spotsV316_4Characters LEFT OUTER JOIN
                         LAUNCH.BrownfieldLastMeasurements ON LAUNCH.spotsV316_4Characters.SpotName = LAUNCH.BrownfieldLastMeasurements.Number LEFT OUTER JOIN
                         LAUNCH.GreenFieldLastMeasurements ON LAUNCH.spotsV316_4Characters.SpotName = LAUNCH.GreenFieldLastMeasurements.Number
WHERE        (LAUNCH.spotsV316_4Characters.SpotsV316 IN
                             (SELECT        SpotsV316
                               FROM            LAUNCH.spotsV316_4Characters AS spotsV316_4Characters_1
                               GROUP BY SpotsV316
                               HAVING         (COUNT(SpotsV316) > 1)))
ORDER BY LAUNCH.spotsV316_4Characters.SpotsV316
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[17] 4[33] 2[14] 3) )"
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
         Begin Table = "spotsV316_4Characters (LAUNCH)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 158
               Right = 380
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GreenFieldLastMeasurements (LAUNCH)"
            Begin Extent = 
               Top = 1
               Left = 662
               Bottom = 225
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "BrownfieldLastMeasurements (LAUNCH)"
            Begin Extent = 
               Top = 126
               Left = 468
               Bottom = 283
               Right = 638
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1890
         Width = 2085
         Width = 2040
         Width = 1890
         Width = 1740
         Width = 2055
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1470
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 11100
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'DoubleSpots_4CharactersWithMeasurements';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'DoubleSpots_4CharactersWithMeasurements';

