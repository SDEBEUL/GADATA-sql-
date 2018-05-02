CREATE VIEW dbo.data@WeldingTeam
AS
SELECT        C3G.Breakdown.Location, C3G.Breakdown.Logtype, C3G.Breakdown.timestamp, C3G.Breakdown.logtext, C3G.Breakdown.[Downtime(s)], 
                         C3G.Breakdown.Classification, C3G.Breakdown.Subgroup, C3G.Breakdown.controller_type, Volvo.L_timeline.Vyear, Volvo.L_timeline.Vweek, 
                         Volvo.L_timeline.Vday
FROM            C3G.Breakdown LEFT OUTER JOIN
                         Volvo.L_timeline ON C3G.Breakdown.timestamp BETWEEN Volvo.L_timeline.starttime AND Volvo.L_timeline.endtime
WHERE        (C3G.Breakdown.timestamp >= GETDATE() - 10) AND (C3G.Breakdown.Subgroup = 'ProcessFault') AND (C3G.Breakdown.Classification = 'UAWS')
UNION
SELECT        C4G.Breakdown.Location, C4G.Breakdown.Logtype, C4G.Breakdown.timestamp, C4G.Breakdown.logtext, C4G.Breakdown.[Downtime(s)], 
                         C4G.Breakdown.Classification, C4G.Breakdown.Subgroup, C4G.Breakdown.controller_type, Volvo.L_timeline.Vyear, Volvo.L_timeline.Vweek, 
                         Volvo.L_timeline.Vday
FROM            C4G.Breakdown LEFT OUTER JOIN
                         Volvo.L_timeline ON C4G.Breakdown.timestamp BETWEEN Volvo.L_timeline.starttime AND Volvo.L_timeline.endtime
WHERE        (C4G.Breakdown.timestamp >= GETDATE() - 10) AND (C4G.Breakdown.Subgroup = 'ProcessFault') AND (C4G.Breakdown.Classification = 'UAWS')
UNION
SELECT        C3G.Error.Location, C3G.Error.Logtype, C3G.Error.timestamp, C3G.Error.logtext, C3G.Error.Downtime, C3G.Error.Classification, C3G.Error.Subgroup, 
                         C3G.Error.controller_type, Volvo.L_timeline.Vyear, Volvo.L_timeline.Vweek, Volvo.L_timeline.Vday
FROM            C3G.Error LEFT OUTER JOIN
                         Volvo.L_timeline ON C3G.Error.timestamp BETWEEN Volvo.L_timeline.starttime AND Volvo.L_timeline.endtime
WHERE        (C3G.Error.timestamp >= GETDATE() - 10) AND (C3G.Error.Subgroup = 'ProcessFault') AND (C3G.Error.Classification = 'UAWS')
UNION
SELECT        C4G.Error.Location, C4G.Error.Logtype, C4G.Error.timestamp, C4G.Error.logtext, C4G.Error.Downtime, C4G.Error.Classification, C4G.Error.Subgroup, 
                         C4G.Error.controller_type, Volvo.L_timeline.Vyear, Volvo.L_timeline.Vweek, Volvo.L_timeline.Vday
FROM            C4G.Error LEFT OUTER JOIN
                         Volvo.L_timeline ON C4G.Error.timestamp BETWEEN Volvo.L_timeline.starttime AND Volvo.L_timeline.endtime
WHERE        (C4G.Error.timestamp >= GETDATE() - 10) AND (C4G.Error.Subgroup = 'ProcessFault') AND (C4G.Error.Classification = 'UAWS')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'data@WeldingTeam';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[28] 4[16] 2[44] 3) )"
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
      Begin ColumnWidths = 14
         Width = 284
         Width = 1500
         Width = 1500
         Width = 7290
         Width = 2055
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'data@WeldingTeam';

