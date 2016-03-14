




CREATE VIEW [Volvo].[VCSCinfo]
AS
--check the heartbeat of VCSC systems
SELECT      
'SystemInfo' AS 'Location'
, x.Vcsc_name AS 'Robotname'
, 'SERVER' AS 'Type'
, 'LIVE' AS 'Errortype'
, getdate() AS 'Timestamp'
, NULL AS 'Logcode'
, Null AS 'Severity'
, 'Timeout of VCSC instance NO heartBeat PLEASE CHECK'AS 'Logtekst'
, DATEDIFF(minute,x._timestamp,getdate()) AS 'DOWNTIME'
, NULL AS 'Year'
, NULL AS 'Week'
, NULL AS 'day'
, NULL AS 'Shift'
, 'SystemInfo' AS 'Object'
, 'SystemInfo' as 'Subgroup'
, Null as 'id'
FROM
(
select * from GADATA.C3G.L_operation where code = 6
UNION
select * from GADATA.C4G.L_operation where code = 6
) as x
where x._timestamp < getdate()-'1900-01-01 00:02:00'

--check if sbcu data is comming in the system 
UNION
SELECT * FROM
(
SELECT      
'SystemInfo' AS 'Location'
, 'it18839vm4_c3gVCSC' AS 'Robotname'
, 'SERVER' AS 'Type'
, 'LIVE' AS 'Errortype'
, getdate() AS 'Timestamp'
, NULL AS 'Logcode'
, Null AS 'Severity'
, 'Timeout of c3gVCSC instance NO SBCU DATA PLEASE CHECK'AS 'Logtekst'
, DATEDIFF(minute,
(select top 1  t.tool_timestamp from GADATA.c3g.rt_toollog as t where t.tool_timestamp < getdate() order by t.tool_timestamp desc)
,getdate()) AS 'DOWNTIME'
, NULL AS 'Year'
, NULL AS 'Week'
, NULL AS 'day'
, NULL AS 'Shift'
, 'SystemInfo' AS 'Object'
, 'SystemInfo' as 'Subgroup'
, Null as 'id'
) as x where x.DOWNTIME > (60*4)

--check if Tsync is working 
UNION 
SELECT * FROM
(
SELECT      
'SystemInfo' AS 'Location'
, 'it18839vm4_c3gTimeSync' AS 'Robotname'
, 'SERVER' AS 'Type'
, 'LIVE' AS 'Errortype'
, getdate() AS 'Timestamp'
, NULL AS 'Logcode'
, Null AS 'Severity'
, 'Timeout of c3gTsync instance NO timesyncs PLEASE CHECK'AS 'Logtekst'
, DATEDIFF(minute,
(select top 1  t._timestamp from GADATA.RobotGA.L_timesync as t where t._timestamp < getdate() order by t._timestamp desc)
,getdate()) AS 'DOWNTIME'
, NULL AS 'Year'
, NULL AS 'Week'
, NULL AS 'day'
, NULL AS 'Shift'
, 'SystemInfo' AS 'Object'
, 'SystemInfo' as 'Subgroup'
, Null as 'id'
) as x where x.DOWNTIME > (60*8)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'Volvo', @level1type = N'VIEW', @level1name = N'VCSCinfo';


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
         Begin Table = "x"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
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
', @level0type = N'SCHEMA', @level0name = N'Volvo', @level1type = N'VIEW', @level1name = N'VCSCinfo';

