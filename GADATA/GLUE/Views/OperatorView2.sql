


CREATE VIEW [GLUE].[OperatorView2]
AS
SELECT       c.location, GLUE.h_operator.c_timestamp, GLUE.Controller.Name, GLUE.Signal.SignalName, GLUE.OperatorActionInfo.Description AS OperatorActionInfo, 
                         CASE WHEN CONCAT(GLUE.h_operator.OldValue,'=>', GLUE.h_operator.NewValue) = '=>' THEN NULL ELSE CONCAT(GLUE.h_operator.OldValue,'=>', GLUE.h_operator.NewValue) END AS toestandsverandering, GLUE.Users.Name AS Users
						 , T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'Day'
, T.shift AS 'Shift'
FROM            GLUE.h_operator INNER JOIN
                         GLUE.Controller ON GLUE.h_operator.Controller_id = GLUE.Controller.ID INNER JOIN
                         GLUE.OperatorActionInfo ON GLUE.h_operator.OperatorActionInfo_id = GLUE.OperatorActionInfo.ID INNER JOIN
                         GLUE.Signal ON GLUE.h_operator.Signal_id = GLUE.Signal.ID INNER JOIN
                         GLUE.Users ON GLUE.h_operator.User_id = GLUE.Users.ID
						 LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
c_timestamp BETWEEN T.starttime AND T.endtime
--join 'Rs breakdown' breakdowns where no gatestop was detected
left join glue.c_controller as c on c.controller_name=glue.Controller.Name
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'GLUE', @level1type = N'VIEW', @level1name = N'OperatorView2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'    Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'GLUE', @level1type = N'VIEW', @level1name = N'OperatorView2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[64] 4[15] 2[13] 3) )"
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
         Begin Table = "h_operator (GLUE)"
            Begin Extent = 
               Top = 28
               Left = 0
               Bottom = 292
               Right = 207
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "Controller (GLUE)"
            Begin Extent = 
               Top = 16
               Left = 331
               Bottom = 111
               Right = 501
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OperatorActionInfo (GLUE)"
            Begin Extent = 
               Top = 250
               Left = 378
               Bottom = 345
               Right = 548
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Signal (GLUE)"
            Begin Extent = 
               Top = 357
               Left = 301
               Bottom = 452
               Right = 471
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users (GLUE)"
            Begin Extent = 
               Top = 126
               Left = 366
               Bottom = 221
               Right = 536
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
         Alias = 1800
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
     ', @level0type = N'SCHEMA', @level0name = N'GLUE', @level1type = N'VIEW', @level1name = N'OperatorView2';

