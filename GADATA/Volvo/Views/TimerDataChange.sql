

CREATE VIEW [Volvo].[TimerDataChange]
AS
SELECT   
  RWG.location AS 'Location'
, RWG.controller_name AS 'Robotname'
, 'Timer' AS 'Type'
, 'DataChange' AS 'Errortype'
, CONVERT(char(19),TDC.DateTime, 120) AS 'Timestamp'
, NULL AS 'Logcode'
, NULL AS 'Severity'
, 'Par: ' + CAST(TP.[Description] as varchar(35)) + '  Changed: ' + CAST(TDC.oldvalue as varchar(10)) +' -> ' + CAST(TDC.newvalue as varchar(10)) + ' User: ' + TU.CDSID  AS 'Logtekst'
, NULL AS DOWNTIME
, T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'day'
, T.shift AS 'Shift'
, 'Spot' AS 'Object'
, 'Timer' AS 'Subgroup'
, TDC.id

From GADATA.dbo.TimerDataChange as TDC
LEFT JOIN GADATA.Volvo.RobotWeldGunRelation as RWG on RWG.TimerID = TDC.TimerID
LEFT JOIN GADATA.dbo.TimerParameterName as TP on TP.ID = TDC.ParameterID
LEFT JOIN GADATA.dbo.users as TU on TDC.UserID = TU.ID
--timeline						 --
LEFT JOIN
VOLVO.L_timeline AS T ON TDC.[DateTime] BETWEEN T.starttime AND T.endtime
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'Volvo', @level1type = N'VIEW', @level1name = N'TimerDataChange';


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
         Begin Table = "TDC"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RWG"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 135
               Right = 421
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TP"
            Begin Extent = 
               Top = 6
               Left = 459
               Bottom = 135
               Right = 629
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TU"
            Begin Extent = 
               Top = 6
               Left = 667
               Bottom = 135
               Right = 837
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T"
            Begin Extent = 
               Top = 6
               Left = 875
               Bottom = 135
               Right = 1045
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
', @level0type = N'SCHEMA', @level0name = N'Volvo', @level1type = N'VIEW', @level1name = N'TimerDataChange';

