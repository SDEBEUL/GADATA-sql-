

CREATE VIEW [NGAC].[variableLog]
AS
select 
  isnull(a.LOCATION,c.controller_name+'#')		   AS 'Location' 
, a.CLassificationId     AS 'AssetID' 
, 'Varmonitor'	   AS 'Logtype'
, rt._timestamp        AS 'timestamp'
, NULL    AS 'Logcode'
, NULL   AS 'Severity'
, 'Var: <' +  c_v.variable +  '> Value: ' 
+ ISNULL(CAST((lag(rt.value) OVER (PARTITION BY rt.c_controller_id, rt.c_variable_id ORDER BY rt._timestamp desc)) as varchar(max)),'N/A')
+ ' -> ' + CAST(rt.value as varchar(max))  AS 'Logtext'
, '' AS 'FullLogtext'
, NULL     AS 'Response'
, NULL     AS 'Downtime'
, ''  AS 'Classification'
, ''	 AS 'Subgroup'
, '' AS 'Category'
, rt.id				 AS 'refId'
, a.LocationTree     As 'LocationTree'
, a.ClassificationTree as 'ClassTree'
, c.controller_name		AS 'controller_name'
, 'NGAC'		As 'controller_type'

from GADATA.NGAC.rt_value as rt 
left join GADATA.NGAC.c_variable as c_v on c_v.id = rt.c_variable_id

/*
LEFT OUTER JOIN VOLVO.c_Classification as cc on cc.id = L.c_ClassificationId
LEFT OUTER JOIN VOLVO.c_Subgroup as cs on cs.id = L.c_SubgroupId
*/
--joining of the RIGHT ASSET
LEFT OUTER JOIN equi.ASSETS as A on 
A.controller_type = 'NGAC' --join the right 'data controller type'
AND
A.controller_id = rt.c_controller_id --join the right 'data controller id'
AND 
A.CLassificationId LIKE '%' + ISNULL(RTRIM(null),'UR') + '%' --join only the asset with the right classification. (if not classified data goes to robot)
AND
A.controller_ToolID = 1 --temp until we find a multi tool support sollution
--
left join GADATA.NGAC.c_controller as c on c.id = rt.c_controller_id
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'variableLog';


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
', @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'variableLog';

