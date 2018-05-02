











CREATE VIEW [Volvo].[Robots]
AS
SELECT distinct * FROM
(
select
 'c4g' as controller_type
,'GADATA.c4g.c_controller' as 'table'
,c4g.id
,c4g.controller_name
,c4g.location
,c4g.ownership
,c4g.Plant
,c4g.Area
,C4g.SubArea
,lop.Vcsc_name as 'server'
,c4g.locationtree as 'locationtree'
from GADATA.c4g.c_controller as c4g
left join GADATA.C4G.L_operation as lop on lop.controller_id = c4g.id and lop.code = 3
WHERE controller_name not like '%REC' --added this because elsde CBM controllers clones show in front end

UNION
select
 'c3g' as controller_type
,'GADATA.c3g.c_controller' as 'table'
,c3g.id
,c3g.controller_name
,c3g.location
,c3g.ownership as 'ownership' 
,c3g.Plant
,c3g.Area
,c3g.SubArea
,lop.Vcsc_name as 'server'
,c3g.locationtree as 'locationtree'
from GADATA.c3g.c_controller as c3g
left join GADATA.C3G.L_operation as lop on lop.controller_id = c3g.id and lop.code = 3

UNION
select
 'NGAC' as controller_type
,'GADATA.NGAC.c_controller' as 'table'
,NGAC.id
,NGAC.controller_name
,null as 'location'
,null as'ownership'
,NULL as 'Plant'
,NULL as 'Area'
,NULL as 'SubArea'
,Null as 'server'
,NGAC.locationtree as 'locationtree'
from GADATA.NGAC.c_controller as NGAC
where class_id <> 8 -- exclude S4C class

UNION
select
 'S4C' as controller_type
,'GADATA.NGAC.c_controller' as 'table'
,NGAC.id
,NGAC.controller_name
,null as 'location'
,null as'ownership'
,NULL as 'Plant'
,NULL as 'Area'
,NULL as 'SubArea'
,Null as 'server'
,NGAC.locationtree as 'locationtree'
from GADATA.NGAC.c_controller as NGAC
where class_id = 8 -- s4C only

) as x
GO
GRANT SELECT
    ON OBJECT::[Volvo].[Robots] TO [db_frontendUser]
    AS [GADATA];


GO
GRANT CONTROL
    ON OBJECT::[Volvo].[Robots] TO [db_frontendUser]
    AS [GADATA];


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'Volvo', @level1type = N'VIEW', @level1name = N'Robots';


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
', @level0type = N'SCHEMA', @level0name = N'Volvo', @level1type = N'VIEW', @level1name = N'Robots';

