CREATE VIEW UL.AutomaticWorkFlowULPlans
AS
SELECT        TOP (100) PERCENT UL.InspectionPlanLastComplete.LastInspectionTime, Inspectionplan_1.Name AS [UL plan], ISNULL(tbl.[BuildBody's], 0) AS [BuildBody's], 
                         Inspectionplan_1.WorkTime, Inspectionplan_1.WorkGroup, Inspectionplan_1.WorkLocation, Inspectionplan_1.SpotIdent, Inspectionplan_1.ID
FROM            dbo.Inspectionplan AS Inspectionplan_1 LEFT OUTER JOIN
                         UL.InspectionPlanLastComplete ON Inspectionplan_1.ID = UL.InspectionPlanLastComplete.ID LEFT OUTER JOIN
                             (SELECT        InspectionPlanLastComplete_1.LastInspectionTime, InspectionPlanLastComplete_1.Name AS [UL plan], COUNT(UL.SpotIdentMeasurements.SpotID) 
                                                         AS [BuildBody's], Inspectionplan_2.PlanActive, Inspectionplan_2.WorkGroup, Inspectionplan_2.WorkLocation, Inspectionplan_2.SpotIdent
                               FROM            UL.InspectionPlanLastComplete AS InspectionPlanLastComplete_1 INNER JOIN
                                                         dbo.Inspectionplan AS Inspectionplan_2 ON InspectionPlanLastComplete_1.Name = Inspectionplan_2.Name INNER JOIN
                                                         UL.SpotIdentMeasurements INNER JOIN
                                                         dbo.Spot AS Spot_1 ON UL.SpotIdentMeasurements.SpotID = Spot_1.ID ON Inspectionplan_2.SpotIdent = Spot_1.Number AND 
                                                         InspectionPlanLastComplete_1.LastInspectionTime < UL.SpotIdentMeasurements.timestamp
                               WHERE        (UL.SpotIdentMeasurements.timestamp < GETDATE())
                               GROUP BY InspectionPlanLastComplete_1.LastInspectionTime, InspectionPlanLastComplete_1.Name, Inspectionplan_2.PlanActive, Inspectionplan_2.WorkGroup, 
                                                         Inspectionplan_2.WorkLocation, Inspectionplan_2.SpotIdent
                               HAVING         (Inspectionplan_2.PlanActive = '1')) AS tbl ON Inspectionplan_1.Name = tbl.[UL plan]
WHERE        (Inspectionplan_1.PlanActive = 1)
GROUP BY Inspectionplan_1.Name, ISNULL(tbl.[BuildBody's], 0), Inspectionplan_1.WorkTime, Inspectionplan_1.WorkGroup, Inspectionplan_1.WorkLocation, 
                         Inspectionplan_1.SpotIdent, Inspectionplan_1.ID, UL.InspectionPlanLastComplete.LastInspectionTime
HAVING        (NOT (Inspectionplan_1.Name LIKE N'%Bolt%'))
ORDER BY [BuildBody's] DESC
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'UL', @level1type = N'VIEW', @level1name = N'AutomaticWorkFlowULPlans';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[19] 4[27] 2[27] 3) )"
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
         Begin Table = "Inspectionplan_1"
            Begin Extent = 
               Top = 12
               Left = 442
               Bottom = 247
               Right = 706
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "InspectionPlanLastComplete (UL)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl"
            Begin Extent = 
               Top = 8
               Left = 844
               Bottom = 137
               Right = 1052
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
      Begin ColumnWidths = 12
         Width = 284
         Width = 2370
         Width = 4560
         Width = 1320
         Width = 1500
         Width = 1485
         Width = 1500
         Width = 1845
         Width = 4620
         Width = 1500
         Width = 1500
         Width = 4635
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 2820
         Alias = 1965
         Table = 4455
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2880
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'UL', @level1type = N'VIEW', @level1name = N'AutomaticWorkFlowULPlans';

