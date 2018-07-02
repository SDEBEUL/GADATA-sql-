CREATE VIEW UL.AutomaticWorkFlowULPlans
AS
SELECT Query1.LastInspectionTime, Query1.[UL plan], Query1.[BuildBody's], Query1.WorkTime, Query1.WorkGroup, Query1.WorkLocation, Query2.[Body'slast_30Min_start], 
                  Query2.[Body'slast_30Min_end], CASE WHEN Query2.[body'slast_30min_start] IS NULL AND Query2.[body'slast_30min_end] IS NULL 
                  THEN 'no production' WHEN Query2.[body'slast_30min_start] BETWEEN 1 AND 8 AND Query2.[body'slast_30min_end] BETWEEN 1 AND 
                  6 THEN 'LOW production' WHEN Query2.[body'slast_30min_start] >= 10 AND 
                  Query2.[body'slast_30min_end] > 10 THEN 'production running' WHEN Query2.[body'slast_30min_start] >= 12 AND 
                  Query2.[body'slast_30min_end] <= 8 THEN 'Waiting Output possible' WHEN Query2.[body'slast_30min_start] <= 8 AND 
                  Query2.[body'slast_30min_end] >= 12 THEN 'Waiting Input possible' ELSE 'production running' END AS Last30min_productionStatus, 
                  'onderhoudswerken' AS onderhoudswerken
FROM     (SELECT TOP (100) PERCENT UL.InspectionPlanLastComplete.LastInspectionTime, Inspectionplan_1.Name AS [UL plan], ISNULL(tbl.[BuildBody's], 0) AS [BuildBody's], 
                                    Inspectionplan_1.WorkTime, Inspectionplan_1.WorkGroup, Inspectionplan_1.WorkLocation, Inspectionplan_1.SpotIdent, Inspectionplan_1.ID
                  FROM      dbo.Inspectionplan AS Inspectionplan_1 LEFT OUTER JOIN
                                    UL.InspectionPlanLastComplete ON Inspectionplan_1.ID = UL.InspectionPlanLastComplete.ID LEFT OUTER JOIN
                                        (SELECT InspectionPlanLastComplete_1.LastInspectionTime, InspectionPlanLastComplete_1.Name AS [UL plan], COUNT(UL.SpotIdentMeasurements.SpotID) 
                                                           AS [BuildBody's], Inspectionplan_2.PlanActive, Inspectionplan_2.WorkGroup, Inspectionplan_2.WorkLocation, Inspectionplan_2.SpotIdent
                                         FROM      UL.SpotIdentMeasurements INNER JOIN
                                                           UL.InspectionPlanLastComplete AS InspectionPlanLastComplete_1 INNER JOIN
                                                           dbo.Inspectionplan AS Inspectionplan_2 ON InspectionPlanLastComplete_1.Name = Inspectionplan_2.Name ON 
                                                           UL.SpotIdentMeasurements.timestamp > InspectionPlanLastComplete_1.LastInspectionTime AND 
                                                           UL.SpotIdentMeasurements.SpotID = Inspectionplan_2.SpotIdent
                                         WHERE   (UL.SpotIdentMeasurements.timestamp < GETDATE())
                                         GROUP BY InspectionPlanLastComplete_1.LastInspectionTime, InspectionPlanLastComplete_1.Name, Inspectionplan_2.PlanActive, Inspectionplan_2.WorkGroup, 
                                                           Inspectionplan_2.WorkLocation, Inspectionplan_2.SpotIdent
                                         HAVING  (Inspectionplan_2.PlanActive = '1')) AS tbl ON Inspectionplan_1.Name = tbl.[UL plan]
                  WHERE   (Inspectionplan_1.PlanActive = 1)
                  GROUP BY Inspectionplan_1.Name, ISNULL(tbl.[BuildBody's], 0), Inspectionplan_1.WorkTime, Inspectionplan_1.WorkGroup, Inspectionplan_1.WorkLocation, 
                                    Inspectionplan_1.SpotIdent, Inspectionplan_1.ID, UL.InspectionPlanLastComplete.LastInspectionTime
                  HAVING  (NOT (Inspectionplan_1.Name LIKE N'%Bolt%'))) AS Query1 LEFT OUTER JOIN
                      (SELECT t1.Name, t1.Expr1 AS [Body'slast_30Min_start], t2.Expr1 AS [Body'slast_30Min_end]
                       FROM      (SELECT dbo.Inspectionplan.Name, COUNT(SpotIdentMeasurements_2.timestamp) AS Expr1, dbo.Inspectionplan.SpotBefore
                                          FROM      UL.SpotIdentMeasurements AS SpotIdentMeasurements_2 INNER JOIN
                                                            dbo.Inspectionplan ON SpotIdentMeasurements_2.SpotID = dbo.Inspectionplan.SpotBefore
                                          WHERE   (SpotIdentMeasurements_2.timestamp >= DATEADD(MINUTE, - 40, GETDATE()))
                                          GROUP BY dbo.Inspectionplan.SpotBefore, dbo.Inspectionplan.Name) AS t1 INNER JOIN
                                             (SELECT Inspectionplan_3.Name, COUNT(SpotIdentMeasurements_1.timestamp) AS Expr1, Inspectionplan_3.SpotAfter
                                              FROM      UL.SpotIdentMeasurements AS SpotIdentMeasurements_1 INNER JOIN
                                                                dbo.Inspectionplan AS Inspectionplan_3 ON SpotIdentMeasurements_1.SpotID = Inspectionplan_3.SpotAfter
                                              WHERE   (SpotIdentMeasurements_1.timestamp >= DATEADD(minute, - 40, GETDATE()))
                                              GROUP BY Inspectionplan_3.SpotAfter, Inspectionplan_3.Name) AS t2 ON t1.Name = t2.Name) AS Query2 ON Query1.[UL plan] = Query2.Name
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
         Top = -360
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Query1"
            Begin Extent = 
               Top = 367
               Left = 48
               Bottom = 528
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Query2"
            Begin Extent = 
               Top = 367
               Left = 318
               Bottom = 506
               Right = 561
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
         Width = 2376
         Width = 4560
         Width = 1320
         Width = 1500
         Width = 1488
         Width = 1500
         Width = 1848
         Width = 2100
         Width = 1500
         Width = 1500
         Width = 4632
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2820
         Alias = 1968
         Table = 4452
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 2880
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'UL', @level1type = N'VIEW', @level1name = N'AutomaticWorkFlowULPlans';



