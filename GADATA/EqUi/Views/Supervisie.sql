










CREATE VIEW [EqUi].[Supervisie]
AS

SELECT DISTINCT top 20000
  output.Location       AS 'Location' 
, output.logtext		AS 'logtext'
, output.Response/60		AS 'RT'
, output.Downtime/60		AS 'DT'
, CONVERT(char(19),output.[timestamp], 108) AS 'time' 
, output.Classification	AS 'Classification'
, output.Subgroup		AS 'Subgroup'
, output.Severity		AS 'Severity'
, output.Logcode        AS 'Logcode'
, output.Logtype		AS 'Logtype'
, ISNULL(output.refId,0)  AS 'refId'
, output.timestamp		as 'timestamp'
, output.LocationTree as 'LocationTree'
, output.ClassTree as 'ClassTree'

FROM
(

--*******************************************************************************************************--
--c3g error
--*******************************************************************************************************--
SELECT * from GADATA.c3g.error
where 
error.[timestamp] BETWEEN getdate()-'1900-01-01 08:00:00' AND getdate()
and
8 <= error.Severity
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--c4g error
--*******************************************************************************************************--
select * from GADATA.c4g.error
where 
error.[timestamp] BETWEEN getdate()-'1900-01-01 08:00:00' AND getdate()
and
8 <= error.Severity
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--NGAC error
--*******************************************************************************************************--
SELECT 
       [Location]
      ,[AssetID]
      ,[Logtype]
      ,[timestamp]
      ,[Logcode]
      ,[Severity]
      ,[logtext]
      ,[Response]
      ,[Downtime]
      ,[Classification]
      ,[Subgroup]
      ,[refId]
      ,[LocationTree]
      ,[ClassTree]
      ,[controller_name]
      ,[controller_type]

FROM GADATA.NGAC.ControllerEventLog
where 
ControllerEventLog.[timestamp] BETWEEN getdate()-'1900-01-01 08:00:00' AND getdate()
and
ControllerEventLog.Category in ('Hardware')
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--c3g breakdown
--*******************************************************************************************************--
select * from GADATA.c3g.breakdown as c3g_breakdown
where 
c3g_breakdown.[timestamp] BETWEEN getdate()-'1900-01-01 08:00:00' AND getdate()
and 
1*60 <= c3g_breakdown.[Downtime(s)] 
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--c4g breakdown
--*******************************************************************************************************--
SELECT * from GADATA.c4g.breakdown as c4g_breakdown
where 
c4g_breakdown.[timestamp] BETWEEN getdate()-'1900-01-01 08:00:00' AND getdate()
and 
1*60 <= c4g_breakdown.[Downtime(s)] 
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--NGAC breakdown
--*******************************************************************************************************--
select 
       [Location]
      ,[AssetID]
      ,[Logtype]
      ,[timestamp]
      ,[Logcode]
      ,[Severity]
      ,[logtext]
      ,[Response]
      ,[Downtime]
      ,[Classification]
      ,[Subgroup]
      ,[refId]
      ,[LocationTree]
      ,[ClassTree]
      ,[controller_name]
      ,[controller_type]
FROM GADATA.NGAC.breakdown as breakdown
where 
breakdown.[timestamp] BETWEEN getdate()-'1900-01-01 08:00:00' AND getdate()
and 
1*60 <= breakdown.Downtime
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--NGAC live (active breakdown)
--*******************************************************************************************************--
select 
       [Location]
      ,[AssetID]
      ,[Logtype]
      ,[timestamp]
      ,[Logcode]
      ,[Severity]
      ,[logtext]
      ,[Response]
      ,[Downtime]
      ,[Classification]
      ,[Subgroup]
      ,[refId]
      ,[LocationTree]
      ,[ClassTree]
      ,[controller_name]
      ,[controller_type]
FROM GADATA.NGAC.ActiveState as ActiveState
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--supervisie (c3g c4g)
--*******************************************************************************************************--
SELECT * from gadata.volvo.L_liveView 
where 
--filter out some crap states 
L_liveView.logtext not in (
 'S: Run   |T: Run '
,'S: Alarm (SS) H   |T: Safety gate'
,'S: Alarm (SS) H   |T: HOLD from fieldbus'
,'S: Ready Alarm (SS) H   |T: Safety gate'
,'S: Ready Alarm (SS) H   |T: HOLD from fieldbus'
,'S: Ready H   |T: Ready H '
,'S: Ready   |T: Ready '
,'S: H   |T: HOLD from fieldbus'
,'S:   |T: '
,'S: Run   |T: Fail: Run '
,'S: DriveOff (SS)   |T: Fail: Run '
)
--*******************************************************************************************************--
UNION
--*******************************************************************************************************--
--ACTIVE ALERTS (NGAC)
--*******************************************************************************************************--
select 
       [Location]
      ,[AssetID]
      ,[Logtype]
      ,[timestamp]
      ,[Logcode]
      ,[Severity]
      ,[logtext]
      ,[Response]
      ,[Downtime]
      ,[Classification]
      ,[Subgroup]
      ,[refId]
      ,[LocationTree]
      ,[ClassTree]
      ,[controller_name]
      ,[controller_type]
FROM GADATA.NGAC.ActiveAlerts
--*******************************************************************************************************--
) as output
where 
--Exclude opeation logs 
(ISNULL(output.Subgroup,'') NOT LIKE '%Operational%') 
ORDER BY output.timestamp desc
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'EqUi', @level1type = N'VIEW', @level1name = N'Supervisie';


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
         Begin Table = "output"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 168
               Right = 250
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
', @level0type = N'SCHEMA', @level0name = N'EqUi', @level1type = N'VIEW', @level1name = N'Supervisie';

