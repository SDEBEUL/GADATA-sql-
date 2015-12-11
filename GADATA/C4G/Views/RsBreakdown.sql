





CREATE VIEW [C4G].[RsBreakdown]
AS

SELECT      
 c.location AS 'Location'
,c.controller_name AS 'Robotname'
, 'C4G' AS 'Type'
, 'BREAKDOWN' AS 'errortype'
, H.EndOfBreakdown AS 'Timestamp'
, ISNULL(LR.[error_number],L.[error_number]) AS 'Logcode'
, ISNULL(LR.error_severity,L.error_severity) AS 'Severity'
,CASE 
    WHEN RSB.ID is not null THEN ('|RS|' + ISNULL(('|R: ' + LR.error_text), L.error_text ))
	ELSE ISNULL(('|R: ' + LR.error_text), L.error_text )
	END as 'Logtekst'
, DATEDIFF(MINUTE, H.StartOfBreakdown, H.EndOfBreakdown) AS DOWNTIME
, T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'day'
, T.shift AS 'Shift'
, ISNULL(LRA.APPL, LA.APPL) AS 'Object'
, ISNULL(LRS.Subgroup, LS.Subgroup) AS 'Subgroup'
, RSB.id as 'idx'


FROM   GADATA.C4G.h_breakdown as H 
INNER JOIN c4g.c_controller as c ON H.controller_id =c.id 
--join L_error (normal cause)
LEFT OUTER JOIN GADATA.C4G.L_error  AS L ON 
L.id = H.error_id 
--join L_error (special cause)
LEFT OUTER JOIN GADATA.C4G.L_error AS lR ON
H.RC_error_id = LR.id
AND
H.RC_error_id IS NOT NULL
--appl (normal cause)
LEFT OUTER JOIN
GADATA.C4g.c_Appl as LA ON (LA.id =L.Appl_id) 
--subgroup (normal cause)
 LEFT OUTER JOIN
gadata.c4g.C_subgroup as LRS ON (LRS.id = LR.subgroup_id) 
--appl (special cause)
LEFT OUTER JOIN
GADATA.C4g.c_Appl as LRA ON (LRA.id = LR.Appl_id) 
--subgroup (special cause)
 LEFT OUTER JOIN
gadata.c4g.C_subgroup as LS ON (LS.id = L.subgroup_id) 
--timeline						 --
LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
H.EndOfBreakdown BETWEEN T.starttime AND T.endtime
--join 'Rs breakdown' breakdowns where no gatestop was detected
LEFT OUTER JOIN 
GADATA.C4G.h_NoGateStop as RSB ON RSB.Breakdown_id = H.id
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'C4G', @level1type = N'VIEW', @level1name = N'RsBreakdown';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'         End
         Begin Table = "LS"
            Begin Extent = 
               Top = 138
               Left = 246
               Bottom = 233
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T"
            Begin Extent = 
               Top = 138
               Left = 454
               Bottom = 267
               Right = 624
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
', @level0type = N'SCHEMA', @level0name = N'C4G', @level1type = N'VIEW', @level1name = N'RsBreakdown';


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
         Begin Table = "L"
            Begin Extent = 
               Top = 6
               Left = 487
               Bottom = 135
               Right = 657
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "lR"
            Begin Extent = 
               Top = 6
               Left = 695
               Bottom = 135
               Right = 865
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LA"
            Begin Extent = 
               Top = 6
               Left = 903
               Bottom = 101
               Right = 1073
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRS"
            Begin Extent = 
               Top = 102
               Left = 903
               Bottom = 197
               Right = 1073
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LRA"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 233
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
', @level0type = N'SCHEMA', @level0name = N'C4G', @level1type = N'VIEW', @level1name = N'RsBreakdown';

