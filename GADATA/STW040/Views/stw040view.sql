

/*the replace GH is because every gripper in STW040 is GH and in reality can be GH GP GD
the replace WT is because every tucker in stw040 is WT and in reality should be WTA WTP .... (we put everything on WTA) 
the +'%' is because almost nobody in stw040 defines the specific tool. */
CREATE VIEW [STW040].[stw040view]
AS
SELECT  
						 ISNULL(EqUi.ASSETS.LOCATION, RTRIM(STW040.STW040.IMACHINE) + '#') AS 'Location'
						 , EqUi.ASSETS.CLassificationId AS 'AssetID'
						 , 'STW040' AS 'Logtype'
						 , STW040.STW040.DBSTASTO AS 'timestamp'
						 , STW040.STW040.KEIG AS 'Logcode'
						 , NULL AS 'Severity', '[Aktie]: ' + RTRIM(ISNULL(STW040.STW040.OAKTIE, 
                         ISNULL(STW040.STW040.OOORZAAK, 'N/A')) )
						 + CHAR(10) + CHAR(13) + '|[#]:' + ISNULL(CAST(STW040.STW040.HAMSTOR AS varchar(5)), 'N/A') 
			             + CHAR(10) + CHAR(13) + '|[USER]:' + ISNULL(CAST(STW040.STW040.SurName AS varchar(5)), '') + ' ' + ISNULL(CAST(STW040.STW040.LastName AS varchar(5)), 'N/A')  AS 'logtext'
						 , NULL AS 'Response(s)'
					     , DATEDIFF(second, STW040.DBSTASTO, STW040.DBSTOSTIL)AS 'Downtime(s)'
						 , STW040.STW040.HAMSTOR  AS 'Count'
						 , ISNULL(STW040.STW040.KMTBF, 'Undefined*') AS 'Classification'
						 ,  ISNULL(STW040.STW040.OOORZAAK, 'Undefined*') AS 'Subgroup'
						 , CAST(STW040.STW040.id AS varchar(MAX)) AS 'refId'
						 , EqUi.ASSETS.LocationTree
						 , EqUi.ASSETS.ClassificationTree AS 'ClassTree'
						 , LTRIM(STW040.STW040.IMACHINE) + '#' AS 'controller_name'
						 , 'STW040' AS 'controller_type'
FROM  STW040.STW040 
LEFT OUTER JOIN EqUi.ASSETS ON UPPER(LTRIM(RTRIM(EqUi.ASSETS.LOCATION))) LIKE UPPER(LTRIM(RTRIM(REPLACE(REPLACE(STW040.STW040.IMACHINE, 'GH', 'G%'), 'WT', 'WT%')))) + '%'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'STW040', @level1type = N'VIEW', @level1name = N'stw040view';


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
         Begin Table = "STW040_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ASSETS (EqUi)"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 135
               Right = 428
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
', @level0type = N'SCHEMA', @level0name = N'STW040', @level1type = N'VIEW', @level1name = N'stw040view';

