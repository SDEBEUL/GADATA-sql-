





CREATE VIEW [Volvo].[Shiftbook]
AS
SELECT        
  ISNULL(r.location,'UserDeff') as 'Location'
, isnull(r.controller_name,sb.IndependantLocation) AS Robotname
, UPPER(sb.controller_type) AS Type
, 'SHIFTBOOK' AS Errortype
, sb.updateTimestamp AS timestamp
, NULL AS Logcode
, NULL AS Severity
, ISNULL(sb.acceptuser+'<= ' ,ISNULL(sb.ReportUser+'=> ','N/A'))  + sb.userDescription AS Logtekst
, NULL AS Downtime
, T.Vyear AS Year
, T.Vweek AS Week
, T.Vday AS day
, T.shift
, 'Status =>' AS 'Object'
, ISNULL(sb.State,'N/A') as 'Subgroup' 
, sb.id AS idx
FROM  gadata.volvo.hShiftbook as sb
left join GADATA.volvo.L_timeline as T on sb.updateTimestamp between t.starttime and t.endtime
left join GADATA.volvo.Robots as r on r.id = sb.controller_id and r.controller_type = sb.controller_type
where sb.State not like 'WASSIGN'

UNION
SELECT        
  ISNULL(r.location,'UserDeff') as 'Location'
, isnull(r.controller_name,sb.IndependantLocation) AS Robotname
, UPPER(sb.controller_type) AS Type
, 'SHIFTBOOK' AS Errortype
, getdate()-'1900-01-01 00:00:10' AS timestamp
, NULL AS Logcode
, NULL AS Severity
, 'WASSIGN | ( •_•)  |' + sb.ReportUser+'=>'  + sb.userDescription AS Logtekst
, NULL AS Downtime
, T.Vyear AS Year
, T.Vweek AS Week
, T.Vday AS day
, T.shift
, 'Status =>' AS 'Object'
, ISNULL(sb.State,'N/A') as 'Subgroup' 
, sb.id AS idx
FROM  gadata.volvo.hShiftbook as sb
left join GADATA.volvo.L_timeline as T on sb.updateTimestamp between t.starttime and t.endtime
left join GADATA.volvo.Robots as r on r.id = sb.controller_id and r.controller_type = sb.controller_type
where sb.State  like 'WASSIGN'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'Volvo', @level1type = N'VIEW', @level1name = N'Shiftbook';


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
', @level0type = N'SCHEMA', @level0name = N'Volvo', @level1type = N'VIEW', @level1name = N'Shiftbook';

