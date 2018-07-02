
CREATE VIEW [NGAC].[DispenseBarrelChange]
AS
--this groups the jobs while alert was active to get an average result
select 
 x.controller_name
,MAX(x._timestamp) as 'lastAlert'
,COUNT(x._timestamp) as 'AlertsInCalc'
,AVG(x.jobcountWhileAlertActive) as 'AVGjobcountWhileAlertActive'
,MAX(x.jobcountWhileAlertActive) as 'MAXjobcountWhileAlertActive'
,MIN(x.jobcountWhileAlertActive) as 'MINjobcountWhileAlertActive'
,MAX(x.refid) as 'refid'
from (
--this statement calc the jobs done while the BarrelLow alert was active (this should be until they changed the barrel)
select 
 h._timestamp
,h.lastTriggerd
,c.controller_name
,h.info
,COUNT(rt.id) as 'jobcountWhileAlertActive'
,h.id as 'refid'
from GADATA.Alerts.h_alert as h
left join GADATA.Alerts.c_triggers as ct on ct.id = h.c_tirgger_id 
left join GADATA.NGAC.c_controller as c on c.controller_name = h.[location]
left join GADATA.NGAC.rt_job as rt on rt.c_controller_id = c.id and rt.ts_Start between h._timestamp and h.lastTriggerd
where ct.alertType = 'BarrelLow' and h.[state] = 5 --techcomp
group by 
 h._timestamp
,h.lastTriggerd
,c.controller_name
,h.info
,h.id
HAVING COUNT(rt.id) > 50 --must have had minimal 50 jobs else might be bullshit
) as x 
GROUP by
x.controller_name
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'DispenseBarrelChange';


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
', @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'DispenseBarrelChange';

