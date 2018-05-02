CREATE VIEW LAUNCH.UltralogInspectionsRAW
AS
SELECT        TOP (100) PERCENT dbo.UltralogInspections.InspectionTime, dbo.Inspectionplan.Name AS InspectionPlanName, dbo.UltralogInspections.IndexOfTestSeq, 
                         dbo.Users.CDSID AS Operator, dbo.UltralogStations.Name AS Station, dbo.UltralogInspections.BodyNbr,
LEAD(dbo.UltralogInspections.IndexOfTestSeq,1,0) OVER (ORDER BY dbo.Inspectionplan.Name,dbo.UltralogInspections.InspectionTime ) as prevResult
FROM            dbo.UltralogInspections INNER JOIN
                         dbo.UltralogStations ON dbo.UltralogInspections.StationID = dbo.UltralogStations.ID INNER JOIN
                         dbo.Users ON dbo.UltralogInspections.InspectorID = dbo.Users.ID INNER JOIN
                         dbo.Inspectionplan ON dbo.UltralogInspections.InspectionPlanID = dbo.Inspectionplan.ID
ORDER BY InspectionPlanName, dbo.UltralogInspections.InspectionTime
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'UltralogInspectionsRAW';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'  Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'UltralogInspectionsRAW';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[21] 2[18] 3) )"
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
         Begin Table = "UltralogStations"
            Begin Extent = 
               Top = 212
               Left = 678
               Bottom = 307
               Right = 848
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 6
               Left = 581
               Bottom = 135
               Right = 751
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Inspectionplan"
            Begin Extent = 
               Top = 0
               Left = 284
               Bottom = 179
               Right = 454
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UltralogInspections"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 336
               Right = 231
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
         Width = 2265
         Width = 5025
         Width = 1500
         Width = 1500
         Width = 2130
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 3090
         Table = 2400
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
       ', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'UltralogInspectionsRAW';

