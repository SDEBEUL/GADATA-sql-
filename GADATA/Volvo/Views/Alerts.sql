




CREATE VIEW [Volvo].[Alerts]
AS

SELECT 
 x.Location
,x.Robotname
,x.Type
,x.Errortype
,x.Timestamp
,x.Logcode
,x.Severity
,x.Logtekst
,x.Dowtime
,t.vyear as 'Year'
,t.vweek as 'Week'
,t.vday as 'day'
,t.shift 'Shift'
,x.Object
,x.Subgroup
,x.idx
FROM 
(
SELECT        
'noloc' AS 'Location'
, controller_name AS 'Robotname'
, 'C3G' AS 'Type'
, 'ALERT' AS 'Errortype'
, getdate() + '1900-01-01 00:01:00' AS 'Timestamp'
, NULL AS 'Logcode'
, NULL AS 'Severity'
, a.description + '(ts:' + CONVERT(char(19),a._timestamp , 120) + ')' AS 'Logtekst'
 , NULL AS 'Dowtime'
 , NULL AS 'Year'
 , NULL AS 'Week'
 , NULL AS 'day'
 , NULL AS 'Shift'
 , 'Alert' AS 'Object'
 , 'WGK' AS 'Subgroup'
 , id as 'idx'
FROM   Volvo.ia_Alert AS a
where a.AlertStatus = 0

UNION
SELECT        
'noloc' AS 'Location'
, controller_name AS 'Robotname'
, 'C3G' AS 'Type'
, 'ALERT' AS 'Errortype'
, _timestamp AS 'Timestamp'
, NULL AS 'Logcode'
, NULL AS 'Severity'
,  description AS 'Logtekst'
 , NULL AS 'Dowtime'
 , NULL AS 'Year'
 , NULL AS 'Week'
 , NULL AS 'day'
 , NULL AS 'Shift'
 , 'Alert' AS 'Object'
 , 'OKREQ' AS 'Subgroup'
 , id as 'idx'
FROM   Volvo.ia_Alert AS a
where a.AlertStatus =  1

UNION
SELECT        
'noloc' AS 'Location'
, controller_name AS 'Robotname'
, 'C3G' AS 'Type'
, 'ALERT' AS 'Errortype'
, _timestamp AS 'Timestamp'
, NULL AS 'Logcode'
, NULL AS 'Severity'
,  description AS 'Logtekst'
 , NULL AS 'Dowtime'
 , NULL AS 'Year'
 , NULL AS 'Week'
 , NULL AS 'day'
 , NULL AS 'Shift'
 , 'Alert' AS 'Object'
 , 'SLUITEN' AS 'Subgroup'
 , id as 'idx'
FROM   Volvo.ia_Alert AS a
where  a.AlertStatus = 3

UNION
SELECT        
'noloc' AS 'Location'
, controller_name AS 'Robotname'
, 'C3G' AS 'Type'
, 'ALERT' AS 'Errortype'
, _timestamp AS 'Timestamp'
, NULL AS 'Logcode'
, NULL AS 'Severity'
,  description AS 'Logtekst'
 , NULL AS 'Dowtime'
 , NULL AS 'Year'
 , NULL AS 'Week'
 , NULL AS 'day'
 , NULL AS 'Shift'
 , 'Alert' AS 'Object'
 , 'VOLTOOID' AS 'Subgroup'
 , id as 'idx'
FROM   Volvo.ia_Alert AS a
where  a.AlertStatus = 2
) as x 
LEFT OUTER JOIN VOLVO.L_timeline AS T ON x.timestamp BETWEEN T.starttime AND T.endtime
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'Volvo', @level1type = N'VIEW', @level1name = N'Alerts';


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
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 226
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
', @level0type = N'SCHEMA', @level0name = N'Volvo', @level1type = N'VIEW', @level1name = N'Alerts';

