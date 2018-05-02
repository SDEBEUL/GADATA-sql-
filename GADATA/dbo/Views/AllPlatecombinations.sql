CREATE VIEW dbo.AllPlatecombinations
AS
SELECT        dbo.PlateCombinations.ID, dbo.PlateMaterial.Name AS Plate1Material, dbo.PlateCoating.Name AS Plate1Coating, dbo.PlateType.Thickness AS Plate1thickness, 
                         PlateMaterial_1.Name AS Plate2Material, PlateCoating_1.Name AS Plate2Coating, PlateType_1.Thickness AS Plate2thickness, 
                         PlateMaterial_2.Name AS Plate3Material, PlateCoating_2.Name AS Plate3Coating, PlateType_2.Thickness AS Plate3thickness, 
                         PlateMaterial_3.Name AS Plate4Material, PlateCoating_3.Name AS Plate4Coating, PlateType_3.Thickness AS Plate4thickness, COUNT(dbo.Spot.Number) 
                         AS [#spots]
FROM            dbo.Spot INNER JOIN
                         dbo.PlateCombinations ON dbo.Spot.PlateCombinationtId = dbo.PlateCombinations.ID LEFT OUTER JOIN
                         dbo.PlateType AS PlateType_3 INNER JOIN
                         dbo.PlateMaterial AS PlateMaterial_3 ON PlateType_3.MaterialID = PlateMaterial_3.ID INNER JOIN
                         dbo.PlateCoating AS PlateCoating_3 ON PlateType_3.CoatingID = PlateCoating_3.ID ON dbo.PlateCombinations.Plate4ID = PlateType_3.ID LEFT OUTER JOIN
                         dbo.PlateType AS PlateType_2 INNER JOIN
                         dbo.PlateMaterial AS PlateMaterial_2 ON PlateType_2.MaterialID = PlateMaterial_2.ID INNER JOIN
                         dbo.PlateCoating AS PlateCoating_2 ON PlateType_2.CoatingID = PlateCoating_2.ID ON dbo.PlateCombinations.Plate3ID = PlateType_2.ID LEFT OUTER JOIN
                         dbo.PlateType AS PlateType_1 INNER JOIN
                         dbo.PlateCoating AS PlateCoating_1 ON PlateType_1.CoatingID = PlateCoating_1.ID INNER JOIN
                         dbo.PlateMaterial AS PlateMaterial_1 ON PlateType_1.MaterialID = PlateMaterial_1.ID ON dbo.PlateCombinations.Plate2ID = PlateType_1.ID LEFT OUTER JOIN
                         dbo.PlateMaterial INNER JOIN
                         dbo.PlateType ON dbo.PlateMaterial.ID = dbo.PlateType.MaterialID INNER JOIN
                         dbo.PlateCoating ON dbo.PlateType.CoatingID = dbo.PlateCoating.ID ON dbo.PlateCombinations.Plate1ID = dbo.PlateType.ID
WHERE        (dbo.Spot.Number < 30000) OR
                         (dbo.Spot.Number > 60000)
GROUP BY dbo.PlateCombinations.ID, dbo.PlateMaterial.Name, dbo.PlateCoating.Name, dbo.PlateType.Thickness, PlateMaterial_1.Name, PlateCoating_1.Name, 
                         PlateType_1.Thickness, PlateMaterial_2.Name, PlateCoating_2.Name, PlateType_2.Thickness, PlateMaterial_3.Name, PlateCoating_3.Name, PlateType_3.Thickness
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'AllPlatecombinations';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'       End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateType_2"
            Begin Extent = 
               Top = 333
               Left = 431
               Bottom = 462
               Right = 601
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateMaterial_2"
            Begin Extent = 
               Top = 319
               Left = 638
               Bottom = 431
               Right = 808
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateCoating_2"
            Begin Extent = 
               Top = 314
               Left = 887
               Bottom = 426
               Right = 1057
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateType_3"
            Begin Extent = 
               Top = 484
               Left = 441
               Bottom = 613
               Right = 611
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateMaterial_3"
            Begin Extent = 
               Top = 498
               Left = 661
               Bottom = 610
               Right = 831
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateCoating_3"
            Begin Extent = 
               Top = 502
               Left = 925
               Bottom = 614
               Right = 1095
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 6
               Left = 1089
               Bottom = 254
               Right = 1288
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
      Begin ColumnWidths = 15
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
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 1545
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'AllPlatecombinations';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "PlateCombinations"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 252
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateMaterial"
            Begin Extent = 
               Top = 0
               Left = 665
               Bottom = 112
               Right = 835
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateType"
            Begin Extent = 
               Top = 34
               Left = 414
               Bottom = 163
               Right = 584
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateCoating"
            Begin Extent = 
               Top = 0
               Left = 881
               Bottom = 112
               Right = 1051
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateType_1"
            Begin Extent = 
               Top = 186
               Left = 425
               Bottom = 315
               Right = 595
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateCoating_1"
            Begin Extent = 
               Top = 185
               Left = 881
               Bottom = 297
               Right = 1051
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateMaterial_1"
            Begin Extent = 
               Top = 183
               Left = 641
               Bottom = 295
               Right = 811
     ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'AllPlatecombinations';

