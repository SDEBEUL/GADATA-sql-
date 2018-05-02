CREATE VIEW dbo.[ALARM__AND OPERATORVIEW]
AS
SELECT        GLUE.h_alarm.c_status, GLUE.h_alarm.c_timestamp, GLUE.Controller.Name, GLUE.FaultInfo.El_Ident, GLUE.FaultInfo.Priority, GLUE.FaultInfo.Description, 
                         GLUE.OperatorActionInfo.Description AS Expr1, GLUE.Signal.SignalName, GLUE.h_operator.NewValue, GLUE.h_operator.OldValue
FROM            GLUE.Controller INNER JOIN
                         GLUE.FaultInfo ON GLUE.Controller.ID = GLUE.FaultInfo.ID INNER JOIN
                         GLUE.h_alarm ON GLUE.Controller.ID = GLUE.h_alarm.Controller_id AND GLUE.FaultInfo.ID = GLUE.h_alarm.FaultText_id INNER JOIN
                         GLUE.h_operator ON GLUE.Controller.ID = GLUE.h_operator.Controller_id INNER JOIN
                         GLUE.OperatorActionInfo ON GLUE.h_operator.OperatorActionInfo_id = GLUE.OperatorActionInfo.ID INNER JOIN
                         GLUE.Signal ON GLUE.h_alarm.Signal_id = GLUE.Signal.ID AND GLUE.h_operator.Signal_id = GLUE.Signal.ID INNER JOIN
                         GLUE.Users ON GLUE.h_operator.User_id = GLUE.Users.ID
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'ALARM__AND OPERATORVIEW';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'    Right = 449
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'ALARM__AND OPERATORVIEW';


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
         Begin Table = "Controller (GLUE)"
            Begin Extent = 
               Top = 0
               Left = 294
               Bottom = 95
               Right = 464
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FaultInfo (GLUE)"
            Begin Extent = 
               Top = 46
               Left = 537
               Bottom = 175
               Right = 707
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "h_alarm (GLUE)"
            Begin Extent = 
               Top = 12
               Left = 59
               Bottom = 141
               Right = 229
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "h_operator (GLUE)"
            Begin Extent = 
               Top = 177
               Left = 27
               Bottom = 306
               Right = 234
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "OperatorActionInfo (GLUE)"
            Begin Extent = 
               Top = 182
               Left = 539
               Bottom = 277
               Right = 709
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Signal (GLUE)"
            Begin Extent = 
               Top = 230
               Left = 269
               Bottom = 325
               Right = 439
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users (GLUE)"
            Begin Extent = 
               Top = 132
               Left = 279
               Bottom = 227
           ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'ALARM__AND OPERATORVIEW';

