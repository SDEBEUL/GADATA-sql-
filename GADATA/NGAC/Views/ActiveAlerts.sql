




/*only robots that are not at 100% speed */
CREATE VIEW [NGAC].[ActiveAlerts]
AS
  SELECT 
  c.controller_name		   AS 'Location' 
, c.CLassificationId     AS 'AssetID' 
, 'SLOWSpeed'	   AS 'Logtype'
, GETDATE()      AS 'timestamp'
, ''    AS 'Logcode'
, ''   AS 'Severity'
, 'Warning robot speed not 100%! Value: ' + CAST(rt.[value] as varchar(max)) + ' since @'+CONVERT(char(19),rt._timestamp, 120)  AS 'Logtext'
, 'Warning robot speed not 100%! Value: ' + CAST(rt.[value] as varchar(max)) + ' since @'+CONVERT(char(19),rt._timestamp, 120)  AS 'FullLogtext'
, NULL     AS 'Response'
, NULL     AS 'Downtime'
, 'URA'  AS 'Classification'
, 'speedcheck' AS 'Subgroup'
, 'ALERT' AS 'Category'
, rt.id				 AS 'refId'
, c.LocationTree     As 'LocationTree'
, c.ClassificationTree as 'ClassTree'
, c.controller_name		AS 'controller_name'
, 'NGAC'		As 'controller_type'


from GADATA.NGAC.[rtu_SpeedOvr] as rt 
LEFT JOIN NGAC.c_controller as c  on c.id = rt.c_controller_id
WHERE rt.[value] <> 100 --only robots that are not at 100% speed 

/*Dispense systems with low level barel warning.*/
 UNION
 SELECT 
  c.controller_name		   AS 'Location' 
, c.CLassificationId     AS 'AssetID' 
, 'BarrelLOW'	   AS 'Logtype'
, GETDATE()      AS 'timestamp'
, ''    AS 'Logcode'
, ''   AS 'Severity'
, 'Warning Dispense system Barrel is LOW since @'+CONVERT(char(19),x._timestamp, 120)  AS 'Logtext'
, 'Warning Dispense system Barrel is LOW since @'+CONVERT(char(19),x._timestamp, 120)  AS 'FullLogtext'
, NULL     AS 'Response'
, NULL     AS 'Downtime'
, 'UT'  AS 'Classification'
, 'BarrelLOW' AS 'Subgroup'
, 'ALERT' AS 'Category'
, x.id				 AS 'refId'
, c.LocationTree     As 'LocationTree'
, c.ClassificationTree as 'ClassTree'
, c.controller_name		AS 'controller_name'
, 'NGAC'		As 'controller_type'


from (--nested to optimize return result for next join
select 
 rt.*
,ROW_NUMBER() OVER (PARTITION BY rt.c_controller_id, rt.c_variable_id ORDER BY rt._timestamp DESC) AS 'rnDesc'
from GADATA.NGAC.rt_Disp_BarrelLow as rt 
) as x
left join GADATA.NGAC.c_controller as c on c.id = x.c_controller_id
where x.[value] = 1 AND x.rnDesc = 1
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'ActiveAlerts';


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
         Begin Table = "rt"
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
               Right = 421
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 459
               Bottom = 135
               Right = 641
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
', @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'ActiveAlerts';

