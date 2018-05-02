



CREATE VIEW [GLUE].[ALARMVIEW_AND_OPERATORVIEW]
AS

SELECT  doubletable.c_timestamp,GLUE.Controller.Name, doubletable.c_status, GLUE.FaultInfo.El_Ident,GLUE.FaultInfo.Priority, GLUE.FaultInfo.Description,GLUE.Signal.SignalName as Signal_Name_Alarm,CASE WHEN CONCAT(doubletable.OldValue,'=>', doubletable.NewValue) = '=>' THEN NULL ELSE CONCAT(doubletable.OldValue,'=>', doubletable.NewValue) END AS toestandsverandering, jki.SignalName as Signal_Name_Operator , GLUE.OperatorActionInfo.Description AS OperatorActionInfo,GLUE.Users.Name AS Users
FROM
(SELECT combinedtable.c_timestamp,GLUE.h_alarm.c_status,combinedtable.Controller_id, GLUE.h_alarm.FaultText_id,GLUE.h_alarm.Signal_id as signal_name_alarm_id, GLUE.h_operator.NewValue, GLUE.h_operator.OldValue, GLUE.h_operator.User_id , GLUE.h_operator.OperatorActionInfo_id, GLUE.h_operator.Signal_id as signal_name_operator_id
FROM
(Select GLUE.h_alarm.c_timestamp, GLUE.h_alarm.Controller_id
FROM          GLUE.h_alarm
UNION
Select GLUE.h_operator.c_timestamp, GLUE.h_operator.Controller_id
FROM          GLUE.h_operator) as combinedtable
LEFT JOIN 
GLUE.h_alarm ON combinedtable.c_timestamp = h_alarm.c_timestamp
LEFT JOIN 
GLUE.h_operator ON combinedtable.c_timestamp = h_operator.c_timestamp) as doubletable
LEFT JOIN
GLUE.Controller ON GLUE.Controller.ID = doubletable.Controller_id
LEFT JOIN
GLUE.FaultInfo ON doubletable.FaultText_id = GLUE.FaultInfo.ID
LEFT JOIN
GLUE.Signal ON doubletable.signal_name_alarm_id = GLUE.Signal.ID 
LEFT JOIN
GLUE.Signal as jki ON doubletable.signal_name_operator_id= jki.ID
LEFT JOIN
GLUE.OperatorActionInfo ON doubletable.OperatorActionInfo_id = GLUE.OperatorActionInfo.ID 
LEFT JOIN
GLUE.Users ON doubletable.User_id = GLUE.Users.ID
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'GLUE', @level1type = N'VIEW', @level1name = N'ALARMVIEW_AND_OPERATORVIEW';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'    Right = 516
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
         Alias = 2265
         Table = 2850
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
', @level0type = N'SCHEMA', @level0name = N'GLUE', @level1type = N'VIEW', @level1name = N'ALARMVIEW_AND_OPERATORVIEW';


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
         Begin Table = "Controller (GLUE)"
            Begin Extent = 
               Top = 0
               Left = 557
               Bottom = 95
               Right = 727
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FaultInfo (GLUE)"
            Begin Extent = 
               Top = 119
               Left = 556
               Bottom = 248
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "h_alarm (GLUE)"
            Begin Extent = 
               Top = 20
               Left = 21
               Bottom = 149
               Right = 191
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "h_operator (GLUE)"
            Begin Extent = 
               Top = 201
               Left = 0
               Bottom = 465
               Right = 207
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "OperatorActionInfo (GLUE)"
            Begin Extent = 
               Top = 346
               Left = 353
               Bottom = 441
               Right = 523
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users (GLUE)"
            Begin Extent = 
               Top = 243
               Left = 353
               Bottom = 338
               Right = 523
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Signal (GLUE)"
            Begin Extent = 
               Top = 443
               Left = 346
               Bottom = 538
           ', @level0type = N'SCHEMA', @level0name = N'GLUE', @level1type = N'VIEW', @level1name = N'ALARMVIEW_AND_OPERATORVIEW';

