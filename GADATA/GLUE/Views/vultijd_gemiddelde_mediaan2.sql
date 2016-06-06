








CREATE VIEW [GLUE].[vultijd_gemiddelde_mediaan2]
AS
 
select DISTINCT D.location
, Name as 'Controller'
,  cast(c_timestamp as date) as time
, T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'Day'
, CAST(ROUND(avg(vultijd_ms) OVER (PARTITION BY  cast(c_timestamp as date), Name)/1000.0,5) AS DECIMAL(6,3)) as gemiddelde_vultijd_s
 from  GLUE.vultijden
  join glue.Controller as C ON GLUE.vultijden.Controller_id = C.ID
    LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
cast(T.starttime as date) = cast(GLUE.vultijden.c_timestamp as date)
left join glue.c_controller as D on D.controller_name=C.Name
where/* T.Vday <> 'NULL' AND*/ T.Vday <> '6'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'GLUE', @level1type = N'VIEW', @level1name = N'vultijd_gemiddelde_mediaan2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'        Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'GLUE', @level1type = N'VIEW', @level1name = N'vultijd_gemiddelde_mediaan2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[27] 2[14] 3) )"
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
         Begin Table = "h_alarm (GLUE)"
            Begin Extent = 
               Top = 33
               Left = 71
               Bottom = 216
               Right = 241
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Signal (GLUE)"
            Begin Extent = 
               Top = 189
               Left = 355
               Bottom = 317
               Right = 525
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Controller (GLUE)"
            Begin Extent = 
               Top = 0
               Left = 380
               Bottom = 95
               Right = 550
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FaultInfo (GLUE)"
            Begin Extent = 
               Top = 66
               Left = 567
               Bottom = 195
               Right = 737
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 2388
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3120
         Width = 2880
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
 ', @level0type = N'SCHEMA', @level0name = N'GLUE', @level1type = N'VIEW', @level1name = N'vultijd_gemiddelde_mediaan2';

