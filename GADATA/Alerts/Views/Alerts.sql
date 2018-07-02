



/*only show alert when this is set*/
CREATE VIEW [Alerts].[Alerts]
AS
 SELECT 
  h_alert.[location] 	   AS 'Location' 
, ''     AS 'AssetID' 
,CASE
WHEN h_alert.[state] = 1 THEN c_triggers.alertType
ELSE 'ALERT'
END  AS 'Logtype' 
,CASE 
WHEN h_alert.[state] = 1 THEN GETDATE()
ELSE h_alert.lastTriggerd
END   AS 'timestamp'
, ''    AS 'Logcode'
, CAST(h_alert.[state] as varchar(max)) AS 'Severity'
, h_alert.info AS 'Logtext'
, h_alert.info  AS 'FullLogtext'
, NULL     AS 'Response'
,CASE 
 WHEN c_triggers.isDowntime = 1 THEN DATEDIFF(second,h_alert._timestamp,h_alert.lastTriggerd)
 ELSE NULL 
 END as 'Downtime'
, h_alert.[Classification]  AS 'Classification'
, c_triggers.alertType AS 'Subgroup'
, c_state.[state] AS 'Category'
, h_alert.id				 AS 'refId'
, h_alert.locationTree     As 'LocationTree'
, NULL as 'ClassTree'
, 'Alertengine'	AS 'controller_name'
, 'EQUI'		As 'controller_type'


from GADATA.Alerts.h_alert
left join GADATA.Alerts.c_triggers on c_triggers.id = h_alert.c_tirgger_id
left join GADATA.Alerts.c_state  on h_alert.[state] = c_state.id

where c_triggers.isInReport = 1 --only show alert when this is set
and c_triggers.[enabled] = 1 --only show alert when enabled
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'Alerts', @level1type = N'VIEW', @level1name = N'Alerts';


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
         Begin Table = "h_alert (Alerts)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 253
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c_triggers (Alerts)"
            Begin Extent = 
               Top = 6
               Left = 291
               Bottom = 135
               Right = 507
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c_state (Alerts)"
            Begin Extent = 
               Top = 6
               Left = 545
               Bottom = 118
               Right = 715
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
', @level0type = N'SCHEMA', @level0name = N'Alerts', @level1type = N'VIEW', @level1name = N'Alerts';

