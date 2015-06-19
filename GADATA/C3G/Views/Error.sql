
CREATE VIEW [C3G].[Error]
AS
SELECT        RobotGA.Robot.location AS 'Location', RobotGA.Robot.RobotName AS 'Robotname', 'C3G' AS 'Type', 'ERROR' AS 'Errortype', 
                         RobotGA.rt_alarm.error_timestamp AS 'timestamp', RobotGA.rt_alarm.error_number AS 'Logcode', RobotGA.rt_alarm.error_severity AS 'Severity', 
                         ISNULL(RobotGA.rt_alarm.error_text, RobotGA.RobotLogText.LogText) AS 'Logtekst', NULL AS 'Downtime', T.Vyear AS 'Year', T.Vweek AS 'Week', T.Vday AS 'day', 
                         T.shift AS 'Shift', c_logclass1.APPL AS 'Object', c_logclass1.Subgroup, CAST(RobotGA.rt_alarm.id AS int) AS 'idx'
FROM            RobotGA.rt_alarm INNER JOIN
                         RobotGA.Robot ON RobotGA.rt_alarm.controller_id = RobotGA.Robot.ID LEFT OUTER JOIN
                         RobotGA.RobotLogText ON RobotGA.rt_alarm.error_text_id = RobotGA.RobotLogText.ID LEFT OUTER JOIN
                         dbo.c_logclass1 AS c_logclass1 ON RobotGA.rt_alarm.error_number BETWEEN c_logclass1.error_codeStart AND c_logclass1.error_codeEnd OR
                         ISNULL(RobotGA.rt_alarm.error_text, RobotGA.RobotLogText.LogText) LIKE RTRIM(c_logclass1.error_tekst) LEFT OUTER JOIN
                         VOLVO.L_timeline AS T ON RobotGA.rt_alarm.error_timestamp BETWEEN T.starttime AND T.endtime
WHERE        (RobotGA.Robot.Type = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'C3G', @level1type = N'VIEW', @level1name = N'Error';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'C3G', @level1type = N'VIEW', @level1name = N'Error';


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
         Begin Table = "rt_alarm (RobotGA)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Robot (RobotGA)"
            Begin Extent = 
               Top = 6
               Left = 252
               Bottom = 135
               Right = 422
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RobotLogText (RobotGA)"
            Begin Extent = 
               Top = 6
               Left = 460
               Bottom = 101
               Right = 630
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c_logclass1"
            Begin Extent = 
               Top = 6
               Left = 668
               Bottom = 135
               Right = 838
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T"
            Begin Extent = 
               Top = 6
               Left = 876
               Bottom = 135
               Right = 1046
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
         ', @level0type = N'SCHEMA', @level0name = N'C3G', @level1type = N'VIEW', @level1name = N'Error';

