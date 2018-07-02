
CREATE VIEW [NGAC].[Events]
AS
  SELECT 
  c.controller_name		   AS 'Location' 
, c.CLassificationId     AS 'AssetID'
, 'EVENT'	  AS 'Logtype'
, e._timestamp        AS 'timestamp'
/*
,CASE 
 when e.event_enum = 10  THEN 'PP' 
 when e.event_enum = 11  THEN 'MP' 
 ELSE  CAST(e.event_enum as varchar(10))
 END   AS 'Logcode'*/
, CAST(e.event_enum as varchar(10)) AS 'Logcode'
, ''   AS 'Severity'
,'E:' + CAST(e.event_enum as varchar(max)) + ' desc:' + CAST(e.description as varchar(max)) + ' val:' + ISNULL(CAST(e.event_value as varchar(max)),'N/A') AS 'Logtext'
,'E:' + CAST(e.event_enum as varchar(max)) + ' desc:' + CAST(e.description as varchar(max)) + ' val:' + ISNULL(CAST(e.event_value as varchar(max)),'N/A')  AS 'FullLogtext'
,null as 'Response'
,null as 'Downtime'
, 'Undefined*'  AS 'Classification'
, 'Undefined*'		 AS 'Subgroup'
, 'Undefined*' AS 'Category'
, e.id				 AS 'refId'
, c.LocationTree     As 'LocationTree'
, c.ClassificationTree as 'ClassTree'
, c.controller_name		AS 'controller_name'
, 'NGAC'		As 'controller_type'

FROM  NGAC.rt_event AS e 
LEFT JOIN NGAC.c_controller as c with (NOLOCK) on c.id = e.c_controller_id
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'Events';


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
         Left = -1468
      End
      Begin Tables = 
         Begin Table = "e"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 135
               Right = 487
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
', @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'Events';

