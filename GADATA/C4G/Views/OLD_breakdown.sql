CREATE VIEW C4G.OLD_breakdown
AS
SELECT c.location AS 'Location', c.controller_name AS 'Robotname', 'C4G' AS 'Type', 'BREAKDOWN' AS 'errortype', H.EndOfBreakdown AS 'Timestamp', ISNULL(lR.error_number, 
                  L.error_number) AS 'Logcode', ISNULL(lR.error_severity, L.error_severity) AS 'Severity', CASE WHEN RSB.ID IS NOT NULL THEN ('|RS|' + ISNULL(('|R: ' + LR.error_text), 
                  L.error_text)) ELSE ISNULL(('|R: ' + LR.error_text), L.error_text) END AS 'Logtekst', DATEDIFF(MINUTE, H.StartOfBreakdown, H.EndOfBreakdown) AS DOWNTIME, 
                  T.Vyear AS 'Year', T.Vweek AS 'Week', T.Vday AS 'day', T.shift AS 'Shift', ISNULL(LRA.APPL, LA.APPL) AS 'Object', ISNULL(LRS.Subgroup, LS.Subgroup) AS 'Subgroup', 
                  H.id AS 'idx'
FROM     C4G.h_breakdown AS H INNER JOIN
                  C4G.c_controller AS c ON H.controller_id = c.id LEFT OUTER JOIN
                  C4G.L_error AS L ON L.id = H.error_id LEFT OUTER JOIN
                  C4G.L_error AS lR ON H.RC_error_id = lR.id AND H.RC_error_id IS NOT NULL LEFT OUTER JOIN
                  C4G.c_Appl AS LA ON LA.id = L.Appl_id LEFT OUTER JOIN
                  C4G.c_Subgroup AS LRS ON LRS.id = lR.Subgroup_id LEFT OUTER JOIN
                  C4G.c_Appl AS LRA ON LRA.id = lR.Appl_id LEFT OUTER JOIN
                  C4G.c_Subgroup AS LS ON LS.id = L.Subgroup_id LEFT OUTER JOIN
                  Volvo.L_timeline AS T ON H.EndOfBreakdown BETWEEN T.starttime AND T.endtime LEFT OUTER JOIN
                  C4G.h_NoGateStop AS RSB ON RSB.Breakdown_id = H.id
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'C4G', @level1type = N'VIEW', @level1name = N'OLD_breakdown';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' End
         Begin Table = "LS"
            Begin Extent = 
               Top = 168
               Left = 290
               Bottom = 285
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T"
            Begin Extent = 
               Top = 168
               Left = 532
               Bottom = 329
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RSB"
            Begin Extent = 
               Top = 168
               Left = 774
               Bottom = 285
               Right = 968
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
', @level0type = N'SCHEMA', @level0name = N'C4G', @level1type = N'VIEW', @level1name = N'OLD_breakdown';


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
         Begin Table = "H"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 168
               Right = 264
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 7
               Left = 312
               Bottom = 168
               Right = 539
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "L"
            Begin Extent = 
               Top = 7
               Left = 587
               Bottom = 168
               Right = 795
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "lR"
            Begin Extent = 
               Top = 7
               Left = 843
               Bottom = 168
               Right = 1051
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LA"
            Begin Extent = 
               Top = 7
               Left = 1099
               Bottom = 124
               Right = 1293
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRS"
            Begin Extent = 
               Top = 126
               Left = 1099
               Bottom = 243
               Right = 1293
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRA"
            Begin Extent = 
               Top = 168
               Left = 48
               Bottom = 285
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
        ', @level0type = N'SCHEMA', @level0name = N'C4G', @level1type = N'VIEW', @level1name = N'OLD_breakdown';

