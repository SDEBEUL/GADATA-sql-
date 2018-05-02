CREATE VIEW WELDING.AllNutDataWithRobot
AS
SELECT        TOP (100) PERCENT AllNutDataJens.Location, AllNutDataJens.AssetID, AllNutDataJens.spotnr, AllNutDataJens.program, AllNutDataJens.machineNumber, 
                         AllNutDataJens.NutID_BoltID_PII, AllNutDataJens.ElectrodeNr, AllNutDataJens.Logtype, AllNutDataJens.timestamp, AllNutDataJens.Logcode, 
                         AllNutDataJens.Severity, AllNutDataJens.Logtext, AllNutDataJens.FullLogtext, AllNutDataJens.Response, AllNutDataJens.Downtime, AllNutDataJens.Classification, 
                         AllNutDataJens.Subgroup, AllNutDataJens.Category, AllNutDataJens.refId, AllNutDataJens.LocationTree, AllNutDataJens.ClassTree, AllNutDataJens.controller_name, 
                         AllNutDataJens.controller_type, Volvo.L_timeline.Vyear, Volvo.L_timeline.Vweek, Volvo.L_timeline.Vday, Volvo.L_timeline.PLOEG
FROM            (SELECT        Location, AssetID, NULL AS spotnr, NULL AS program, NULL AS machineNumber, NULL AS NutID_BoltID_PII, NULL AS ElectrodeNr, Logtype, timestamp, 
                                                    Logcode, Severity, Logtext, FullLogtext, Response, Downtime, Classification, Subgroup, Category, refId, LocationTree, ClassTree, controller_name, 
                                                    controller_type
                          FROM            NGAC.ControllerEventLog
                          WHERE        (Location LIKE '325%') AND (Classification = 'Undefined*')
                          UNION
                          SELECT        Location, AssetID, NULL AS spotnr, NULL AS program, NULL AS machineNumber, NULL AS NutID_BoltID_PII, NULL AS ElectrodeNr, Logtype, timestamp, 
                                                   Logcode, Severity, Logtext, FullLogtext, Response, Downtime, Classification, Subgroup, Category, refId, LocationTree, ClassTree, controller_name, 
                                                   controller_type
                          FROM            NGAC.Breakdown
                          WHERE        (Location LIKE '325%') AND (Classification = 'Undefined*')
                          UNION
                          SELECT        Robot, NULL AS empthy, Spotnr, Program, MachineNumber, NutID_BoltID_PII, ElectrodeNr, NULL AS logtype, Timestamp, NULL AS wear, NULL 
                                                   AS I_demand, NULL AS I_Actual, NULL AS regulation, NULL AS BodyNr, NULL AS Weldtime, NULL AS EnergyActual, NULL AS EnergyRef, NULL 
                                                   AS ResistanceActual, NULL AS ResistanceRef, NULL AS Expr1, NULL AS Expr2, NULL AS Expr3, NULL AS Expr4
                          FROM            WELDING.nutCellsWeldData
                          WHERE        (Robot LIKE '325%')) AS AllNutDataJens LEFT OUTER JOIN
                         Volvo.L_timeline ON AllNutDataJens.timestamp BETWEEN Volvo.L_timeline.starttime AND Volvo.L_timeline.endtime
ORDER BY AllNutDataJens.timestamp DESC
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'AllNutDataWithRobot';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[20] 4[25] 2[37] 3) )"
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
         Begin Table = "AllNutDataJens"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 192
               Right = 217
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "L_timeline (Volvo)"
            Begin Extent = 
               Top = 7
               Left = 309
               Bottom = 120
               Right = 479
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
', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'AllNutDataWithRobot';

