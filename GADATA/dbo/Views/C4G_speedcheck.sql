CREATE VIEW dbo.C4G_speedcheck
AS
---------------------------------------------------------------------------------------
--create temp table for C4G speedcheck
---------------------------------------------------------------------------------------
WITH C4GSpeedchecktemp AS
(
SELECT 
_timestamp,
controller_id,
value,
ROW_NUMBER() OVER (PARTITION BY controller_id, variable_id ORDER BY _timestamp DESC) AS rnDESC
FROM GADATA.dbo.rt_value
WHERE 
(rt_value.variable_id = 1) --$GEN_OVER
AND 
(GADATA.dbo.rt_value._timestamp  BETWEEN GETDATE()-30 AND GETDATE() ) 

)

SELECT
controller_name,
C4GSpeedchecktemp.controller_id,
C4GSpeedchecktemp._timestamp AS 'TimestampNOK',
lrt_value_rn_desc._timestamp AS 'TimestampOK',
DATEDIFF(HOUR, ISNULL(Lrt_value_rn_desc._timestamp,getdate()), C4GSpeedchecktemp._timestamp) AS 'hours',
C4GSpeedchecktemp.value AS 'ActiveSpeed',
Lrt_value_rn_desc.value AS 'OldSpeedValue'

FROM C4GSpeedchecktemp

LEFT JOIN gadata.dbo.c_controller on c_controller.id = C4GSpeedchecktemp .controller_id

LEFT JOIN C4GSpeedchecktemp AS Lrt_value_rn_desc ON
(
(C4GSpeedchecktemp.controller_id = Lrt_value_rn_desc.controller_id )
AND
(Lrt_value_rn_desc.value <> 100) 
AND 
(C4GSpeedchecktemp.rnDESC = Lrt_value_rn_desc.rnDESC - 1)
AND
(C4GSpeedchecktemp.value IN ( 100, null))
)

WHERE 
--robots that are not 100% now
(
(C4GSpeedchecktemp.rnDESC = 1)
AND
(C4GSpeedchecktemp.value <> 100)
)
OR --robots that where less than 100% for more than 1 hour 
(
(DATEDIFF(hour, Lrt_value_rn_desc._timestamp, C4GSpeedchecktemp._timestamp) > 1)
AND
(C4GSpeedchecktemp.value = 100)
)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'C4G_speedcheck';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[14] 4[25] 2[30] 3) )"
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1875
         Width = 1950
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'C4G_speedcheck';

