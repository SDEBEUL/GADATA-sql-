CREATE VIEW WELDING.ExtraUltralogUitadaptief1
AS
SELECT        TOP (100) PERCENT WELDING.ExtraUltralogUitadaptief3.Timer, WELDING.ExtraUltralogUitadaptief3.spot, dbo.Inspectionplan.Name AS Ultralogplan, 
                         dbo.Spot.Number, dbo.UltralogInspections.IndexOfTestSeq AS plannummer, MAX(dbo.UltralogInspections.InspectionTime) 
                         AS ULInspectionTimeforEachPlannummer
FROM            dbo.Spot INNER JOIN
                         dbo.UltralogInspections ON dbo.Spot.ID = dbo.UltralogInspections.SpotID INNER JOIN
                         dbo.Inspectionplan ON dbo.UltralogInspections.InspectionPlanID = dbo.Inspectionplan.ID INNER JOIN
                         WELDING.ExtraUltralogUitadaptief3 ON dbo.Spot.Number = WELDING.ExtraUltralogUitadaptief3.spot
WHERE        (dbo.Inspectionplan.PlanActive = 1) AND (WELDING.ExtraUltralogUitadaptief3.uitAdaptief = 1)
GROUP BY WELDING.ExtraUltralogUitadaptief3.Timer, WELDING.ExtraUltralogUitadaptief3.spot, WELDING.ExtraUltralogUitadaptief3.NPT, 
                         WELDING.ExtraUltralogUitadaptief3.CDSID, dbo.Inspectionplan.Name, dbo.Spot.Number, dbo.UltralogInspections.IndexOfTestSeq
ORDER BY dbo.Spot.Number
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'ExtraUltralogUitadaptief1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'ExtraUltralogUitadaptief1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[37] 4[25] 2[20] 3) )"
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
         Begin Table = "UltralogInspections"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 270
               Right = 231
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Inspectionplan"
            Begin Extent = 
               Top = 7
               Left = 294
               Bottom = 162
               Right = 464
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 6
               Left = 502
               Bottom = 135
               Right = 717
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ExtraUltralogUitadaptief3 (WELDING)"
            Begin Extent = 
               Top = 6
               Left = 755
               Bottom = 135
               Right = 941
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
         Width = 2670
         Width = 4980
         Width = 4680
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 2325
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'ExtraUltralogUitadaptief1';

