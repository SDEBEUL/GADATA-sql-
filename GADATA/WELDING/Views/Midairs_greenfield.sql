CREATE VIEW WELDING.Midairs_greenfield
AS
SELECT        *
FROM            OPENQUERY([10.249.240.10\BOS_SQLSERV_2005], 
                         '
SELECT        dateTime, timerName, progNo, wear, regulation2_txt, tipDressCounter, electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue, 
                         resistanceRefValue, uirMeasuringActive, uirMonitoringActive
FROM            dbo.ExtWeldMeasureProtDDW_V
WHERE        (progNo = ''253'') OR
                         (progNo = ''248'')
')
UNION
SELECT        *
FROM            OPENQUERY([10.249.240.11\BOS_SQLSERV_2005], 
                         '
SELECT        dateTime, timerName, progNo, wear, regulation2_txt, tipDressCounter, electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue, 
                         resistanceRefValue, uirMeasuringActive, uirMonitoringActive
FROM            dbo.ExtWeldMeasureProtDDW_V
WHERE        (progNo = ''253'') OR
                         (progNo = ''248'')
')
UNION
SELECT        *
FROM            OPENQUERY([10.249.240.13\BOS_SQLSERV_2005], 
                         '
SELECT        dateTime, timerName, progNo, wear, regulation2_txt, tipDressCounter, electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue, 
                         resistanceRefValue, uirMeasuringActive, uirMonitoringActive
FROM            dbo.ExtWeldMeasureProtDDW_V
WHERE        (progNo = ''253'') OR
                         (progNo = ''248'')
')
UNION
SELECT        *
FROM            OPENQUERY([10.249.240.14\BOS_SQLSERV_2005], 
                         '
SELECT        dateTime, timerName, progNo, wear, regulation2_txt, tipDressCounter, electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue, 
                         resistanceRefValue, uirMeasuringActive, uirMonitoringActive
FROM            dbo.ExtWeldMeasureProtDDW_V
WHERE        (progNo = ''253'') OR
                         (progNo = ''248'')
')
UNION
SELECT        *
FROM            OPENQUERY([10.249.225.199\BOS_SQLSERV_2005], 
                         '
SELECT        dateTime, timerName, progNo, wear, regulation2_txt, tipDressCounter, electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue, 
                         resistanceRefValue, uirMeasuringActive, uirMonitoringActive
FROM            dbo.ExtWeldMeasureProtDDW_V
WHERE        (progNo = ''253'') OR
                         (progNo = ''248'')
')
UNION
SELECT        *
FROM            OPENQUERY([10.249.225.197\BOS_SQLSERV_2005], 
                         '
SELECT        dateTime, timerName, progNo, wear, regulation2_txt, tipDressCounter, electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue, 
                         resistanceRefValue, uirMeasuringActive, uirMonitoringActive
FROM            dbo.ExtWeldMeasureProtDDW_V
WHERE        (progNo = ''253'') OR
                         (progNo = ''248'')
')
UNION
SELECT        *
FROM            OPENQUERY([10.249.225.198\BOS_SQLSERV_2005], 
                         '
SELECT        dateTime, timerName, progNo, wear, regulation2_txt, tipDressCounter, electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue, 
                         resistanceRefValue, uirMeasuringActive, uirMonitoringActive
FROM            dbo.ExtWeldMeasureProtDDW_V
WHERE        (progNo = ''253'') OR
                         (progNo = ''248'')
')
UNION
SELECT        *
FROM            OPENQUERY([10.249.225.200\BOS_SQLSERV_2005], 
                         '
SELECT        dateTime, timerName, progNo, wear, regulation2_txt, tipDressCounter, electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue, 
                         resistanceRefValue, uirMeasuringActive, uirMonitoringActive
FROM            dbo.ExtWeldMeasureProtDDW_V
WHERE        (progNo = ''253'') OR
                         (progNo = ''248'')
')
UNION
SELECT        *
FROM            OPENQUERY([10.249.226.5\BOS_SQLSERV_2005], 
                         '
SELECT        dateTime, timerName, progNo, wear, regulation2_txt, tipDressCounter, electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue, 
                         resistanceRefValue, uirMeasuringActive, uirMonitoringActive
FROM            dbo.ExtWeldMeasureProtDDW_V
WHERE        (progNo = ''253'') OR
                         (progNo = ''248'')
')
UNION
SELECT        *
FROM            OPENQUERY([10.249.225.133\BOS_SQLSERV_2005], 
                         '
SELECT        dateTime, timerName, progNo, wear, regulation2_txt, tipDressCounter, electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue, 
                         resistanceRefValue, uirMeasuringActive, uirMonitoringActive
FROM            dbo.ExtWeldMeasureProtDDW_V
WHERE        (progNo = ''253'') OR
                         (progNo = ''248'')
')
UNION
SELECT        *
FROM            OPENQUERY([10.249.226.7\BOS_SQLSERV_2005], 
                         '
SELECT        dateTime, timerName, progNo, wear, regulation2_txt, tipDressCounter, electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue, 
                         resistanceRefValue, uirMeasuringActive, uirMonitoringActive
FROM            dbo.ExtWeldMeasureProtDDW_V
WHERE        (progNo = ''253'') OR
                         (progNo = ''248'')
')
UNION
SELECT        *
FROM            OPENQUERY([10.249.226.8\BOS_SQLSERV_2005], 
                         '
SELECT        dateTime, timerName, progNo, wear, regulation2_txt, tipDressCounter, electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue, 
                         resistanceRefValue, uirMeasuringActive, uirMonitoringActive
FROM            dbo.ExtWeldMeasureProtDDW_V
WHERE        (progNo = ''253'') OR
                         (progNo = ''248'')
')
UNION
SELECT        *
FROM            OPENQUERY([10.249.227.69\BOS_SQLSERV_2005], 
                         '
SELECT        dateTime, timerName, progNo, wear, regulation2_txt, tipDressCounter, electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue, 
                         resistanceRefValue, uirMeasuringActive, uirMonitoringActive
FROM            dbo.ExtWeldMeasureProtDDW_V
WHERE        (progNo = ''253'') OR
                         (progNo = ''248'')
')
UNION
SELECT        *
FROM            OPENQUERY([10.249.222.197\BOS_SQLSERV_2005], 
                         '
SELECT        dateTime, timerName, progNo, wear, regulation2_txt, tipDressCounter, electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue, 
                         resistanceRefValue, uirMeasuringActive, uirMonitoringActive
FROM            dbo.ExtWeldMeasureProtDDW_V
WHERE        (progNo = ''253'') OR
                         (progNo = ''248'')
')
UNION
SELECT        *
FROM            OPENQUERY([10.249.222.198\BOS_SQLSERV_2005], 
                         '
SELECT        dateTime, timerName, progNo, wear, regulation2_txt, tipDressCounter, electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue, 
                         resistanceRefValue, uirMeasuringActive, uirMonitoringActive
FROM            dbo.ExtWeldMeasureProtDDW_V
WHERE        (progNo = ''253'') OR
                         (progNo = ''248'')
')
UNION
SELECT        *
FROM            OPENQUERY([10.249.225.135\BOS_SQLSERV_2005], 
                         '
SELECT        dateTime, timerName, progNo, wear, regulation2_txt, tipDressCounter, electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue, 
                         resistanceRefValue, uirMeasuringActive, uirMonitoringActive
FROM            dbo.ExtWeldMeasureProtDDW_V
WHERE        (progNo = ''253'') OR
                         (progNo = ''248'')
')
UNION
SELECT        *
FROM            OPENQUERY([10.249.203.138\BOS_SQLSERV_2005], 
                         '
SELECT        dateTime, timerName, progNo, wear, regulation2_txt, tipDressCounter, electrodeNo, weldTimeActualValue, energyActualValue, resistanceActualValue, 
                         resistanceRefValue, uirMeasuringActive, uirMonitoringActive
FROM            dbo.ExtWeldMeasureProtDDW_V
WHERE        (progNo = ''253'') OR
                         (progNo = ''248'')
')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'Midairs_greenfield';


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
', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'Midairs_greenfield';

