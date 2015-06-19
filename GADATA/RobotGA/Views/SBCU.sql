

CREATE VIEW [RobotGA].[SBCU]
AS
SELECT        
  RobotGA.Robot.location AS 'Location'
, RobotGA.Robot.RobotName AS 'Robotname'
, 'C3G' AS 'Type'
, 'SBCU' AS 'Errortype'
, L.tool_timestamp AS 'timestamp'
, NULL AS 'Logcode'
, NULL AS 'Severity'
, 'Long: ' + isnull(CAST(L.Longcheck as varchar(3)), '/') + '  Update: ' + isnull(CAST(L.TcpUpdate as varchar(3)),'/') + '  Dsetup: ' + LTRIM(Str(L.dsetup, 5, 2)) + '  Dmeas: ' + LTRIM(Str(L.Dmeas, 5, 2)) AS 'Logtekst'
, NULL AS 'Downtime'
, T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'day'
, T.shift AS 'Shift'
, 'SBCU' AS 'Object'
, 'SBCU' As 'Subgroup'
, CAST(L.id AS int) AS 'idx'
FROM    RobotGA.rt_toollog as L 
LEFT JOIN RobotGA.Robot ON L.controller_id = RobotGA.Robot.ID 

LEFT  JOIN VOLVO.L_timeline AS T ON L.tool_timestamp BETWEEN T.starttime AND T.endtime
WHERE        (RobotGA.Robot.Type = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'RobotGA', @level1type = N'VIEW', @level1name = N'SBCU';


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
         Begin Table = "L"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Robot (RobotGA)"
            Begin Extent = 
               Top = 6
               Left = 248
               Bottom = 135
               Right = 418
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T"
            Begin Extent = 
               Top = 6
               Left = 456
               Bottom = 135
               Right = 626
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
', @level0type = N'SCHEMA', @level0name = N'RobotGA', @level1type = N'VIEW', @level1name = N'SBCU';

