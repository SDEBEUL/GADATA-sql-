

CREATE VIEW [C4G].[BreakdownStart]
AS
SELECT        dbo.c_controller.location AS 'Location', dbo.c_controller.controller_name AS 'Robotname', 'C4G' AS 'Type', 'BEGIN' AS Expr1, CONVERT(char(19), 
                         dbo.L_breakdown.StartOfBreakdown, 120) AS 'Timestamp', dbo.L_breakdown.error_number AS 'Logcode', NULL AS 'Severity', ISNULL(dbo.L_breakdown.error_text, 
                         '-----------Breakdown Tag-----------') AS 'Logtekst', NULL AS 'DOWNTIME', T.Vyear AS 'Year', T.Vweek AS 'Week', T.Vday AS 'day', T.shift AS 'Shift', 
                         la.APPL AS 'Object', LS.Subgroup, dbo.L_breakdown.idx
FROM            dbo.L_breakdown INNER JOIN
                         dbo.c_controller ON dbo.L_breakdown.controller_id = dbo.c_controller.id 
						 --join appl groups
						 LEFT OUTER JOIN
                         GADATA.C4G.c_LogClassRules AS LR ON 
						 dbo.L_breakdown.error_number BETWEEN LR.Err_start AND LR.Err_end 
						 OR
                         dbo.L_breakdown.error_text LIKE RTRIM(LR.err_text) 
						 --appl
						 LEFT OUTER JOIN
						 GADATA.C4g.c_Appl as LA ON (LA.id =LR.Appl_id)
						 --subgroup
						 LEFT OUTER JOIN
						 gadata.c4g.C_subgroup as LS ON (LS.id = LR.subgroup_id)
						 --
						 LEFT OUTER JOIN
                         VOLVO.L_timeline AS T ON dbo.L_breakdown.StartOfBreakdown BETWEEN T.starttime AND T.endtime
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'C4G', @level1type = N'VIEW', @level1name = N'BreakdownStart';


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
         Begin Table = "L_breakdown"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c_controller"
            Begin Extent = 
               Top = 6
               Left = 261
               Bottom = 135
               Right = 449
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c_logclass1"
            Begin Extent = 
               Top = 6
               Left = 487
               Bottom = 135
               Right = 657
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T"
            Begin Extent = 
               Top = 6
               Left = 695
               Bottom = 135
               Right = 865
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
', @level0type = N'SCHEMA', @level0name = N'C4G', @level1type = N'VIEW', @level1name = N'BreakdownStart';

