





CREATE VIEW [C4G].[RespTime]
AS

SELECT      
  c.location AS 'Location'
, c.controller_name AS 'Robotname'
, 'C4G' AS 'Type'
, 'RespT' AS Expr1
, H.EndOfBreakdown-'1900-01-01 00:00:01.00' AS 'Timestamp'
, L.[error_number] AS 'Logcode'
, L.[error_severity] AS 'Severity'
, L.error_text AS 'Logtekst'
--, DATEDIFF(MINUTE, H.StartOfBreakdown, H.EndOfBreakdown) AS DOWNTIME
, DATEDIFF(MINUTE,'1900-01-01 00:00:00.00',H.Rt) as Rtime
, T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'day'
, T.shift AS 'Shift'
, LA.APPL AS 'Object'
, LS.Subgroup
, H.id


FROM   GADATA.C4G.h_breakdown as H 
INNER JOIN c4g.c_controller as c ON H.controller_id = c.id 
--join L_error
LEFT OUTER JOIN GADATA.C4G.L_error  AS L ON L.id = H.error_id 

						 --appl
						 LEFT OUTER JOIN
						 GADATA.C4g.c_Appl as LA ON (LA.id =L.Appl_id)
						 --subgroup
						 LEFT OUTER JOIN
						 gadata.c4g.C_subgroup as LS ON (LS.id = L.subgroup_id)
						 --
						 LEFT OUTER JOIN
                         VOLVO.L_timeline AS T ON 
						 H.EndOfBreakdown BETWEEN T.starttime AND T.endtime
WHERE -- bit 32 Application fault is on
(H.Trig_state  & 64 = 64)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'C4G', @level1type = N'VIEW', @level1name = N'RespTime';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'70
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
', @level0type = N'SCHEMA', @level0name = N'C4G', @level1type = N'VIEW', @level1name = N'RespTime';


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
         Begin Table = "LA"
            Begin Extent = 
               Top = 6
               Left = 695
               Bottom = 101
               Right = 865
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LS"
            Begin Extent = 
               Top = 6
               Left = 903
               Bottom = 101
               Right = 1073
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T"
            Begin Extent = 
               Top = 102
               Left = 695
               Bottom = 231
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
         Table = 11', @level0type = N'SCHEMA', @level0name = N'C4G', @level1type = N'VIEW', @level1name = N'RespTime';

