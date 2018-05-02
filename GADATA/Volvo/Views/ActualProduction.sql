CREATE VIEW Volvo.ActualProduction
AS
SELECT DISTINCT 
                  TOP (100) PERCENT x.Date, x.Shift, _Model1.NbrWeld AS XC60, _Model2.NbrWeld AS S60, _Model3.NbrWeld AS 'V40', _Model3.NbrWeld AS P4, 
                  _Model1.NbrWeld + _Model2.NbrWeld AS P3
FROM     (SELECT Date, Shift
                  FROM      dbo.WeldMeasurements
                  WHERE   (SpotId = 3918) OR
                                    (SpotId = 2940) OR
                                    (SpotId = 9564)) AS x LEFT OUTER JOIN
                      (SELECT SpotId, NbrWeld, Date, Shift
                       FROM      dbo.WeldMeasurements AS WeldMeasurements_3
                       WHERE   (SpotId = 3918)) AS _Model1 ON x.Shift = _Model1.Shift AND x.Date = _Model1.Date LEFT OUTER JOIN
                      (SELECT SpotId, NbrWeld, Date, Shift
                       FROM      dbo.WeldMeasurements AS WeldMeasurements_2
                       WHERE   (SpotId = 2940)) AS _Model2 ON x.Shift = _Model2.Shift AND x.Date = _Model2.Date LEFT OUTER JOIN
                      (SELECT SpotId, NbrWeld, Date, Shift
                       FROM      dbo.WeldMeasurements AS WeldMeasurements_1
                       WHERE   (SpotId = 9564)) AS _Model3 ON x.Shift = _Model3.Shift AND x.Date = _Model3.Date
ORDER BY x.Date
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[28] 4[35] 2[19] 3) )"
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
         Begin Table = "x"
            Begin Extent = 
               Top = 31
               Left = 37
               Bottom = 161
               Right = 231
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "_Model1"
            Begin Extent = 
               Top = 171
               Left = 322
               Bottom = 332
               Right = 516
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "_Model2"
            Begin Extent = 
               Top = 8
               Left = 638
               Bottom = 169
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "_Model3"
            Begin Extent = 
               Top = 114
               Left = 618
               Bottom = 275
               Right = 812
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
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3480
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End', @level0type = N'SCHEMA', @level0name = N'Volvo', @level1type = N'VIEW', @level1name = N'ActualProduction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'Volvo', @level1type = N'VIEW', @level1name = N'ActualProduction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
End
', @level0type = N'SCHEMA', @level0name = N'Volvo', @level1type = N'VIEW', @level1name = N'ActualProduction';

