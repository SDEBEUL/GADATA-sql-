









CREATE VIEW [GLUE].[Alarm_layoutRD3]
AS

SELECT 
c.location
,glue.Controller.Name as Robotname
,'GLUE ALARM' as Type
,'ERROR' as Errortype
, H.c_timestamp as Timestamp
, NULL as Logcode
, I.Severity as Severity
, CONCAT(Glue.Signal.SignalName,'      |  c_status:  ',H.c_status)  as Logtekst
, NULL as Downtime
, T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'Day'
, T.shift AS 'Shift'
, 'N/A' as Object, 'N/A' as Subgroup
, H.ID as idx
FROM glue.h_alarm as H

join glue.Controller  on (H.Controller_id  = glue.Controller.ID)

join glue.FaultInfo as F on (H.FaultText_id  = F.ID)

join glue.Foutenpriority_into_integer as I on F.Priority = I.Priority

join glue.Signal on (H.Signal_id  = glue.Signal.ID)

LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
H.c_timestamp BETWEEN T.starttime AND T.endtime
--join 'Rs breakdown' breakdowns where no gatestop was detected

left join glue.c_controller as c on c.controller_name=glue.Controller.Name
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'GLUE', @level1type = N'VIEW', @level1name = N'Alarm_layoutRD3';


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
', @level0type = N'SCHEMA', @level0name = N'GLUE', @level1type = N'VIEW', @level1name = N'Alarm_layoutRD3';


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
           ', @level0type = N'SCHEMA', @level0name = N'GLUE', @level1type = N'VIEW', @level1name = N'Alarm_layoutRD3';

