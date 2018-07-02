





CREATE VIEW [S4C].[Breakdown]
AS
select 
  c.controller_name		   AS 'Location' 
, c.CLassificationId     AS 'AssetID' 
, 'BREAKDOWN'	   AS 'Logtype'
, rt.[Date Time]        AS 'timestamp'
, CAST(rt.[AlarmNo] as varchar(max))    AS 'Logcode'
, [NGAC].[fn_GetSeverity](rt.[Txt 1])   AS 'Severity'
, [Txt 2]  AS 'Logtext'
,       NGAC.[AddifSomething]([Txt 2]) + 
		NGAC.[AddifSomething]([Txt 3]) + 
		NGAC.[AddifSomething]([Txt 4]) + 
		NGAC.[AddifSomething]([Txt 5]) + 
		NGAC.[AddifSomething]([Txt 6]) + 
		NGAC.[AddifSomething]([Txt 7]) + 
		NGAC.[AddifSomething]([Txt 8]) + 
		NGAC.[AddifSomething]([Txt 9]) + 
		NGAC.[AddifSomething]([Txt 10]) + 
		NGAC.[AddifSomething]([Txt 11]) + 
		+'Response: ' + ISNULL([Action],'N/A')   AS 'FullLogtext'
, NULL     AS 'Response(s)'
, DATEDIFF(second,rt.Breaktimestamp,rt.[date time])     AS 'Downtime(s)'
, RTRIM(ISNULL(null,'Undefined*'))  AS 'Classification'
, ISNULL(null,'Undefined*')		 AS 'Subgroup'
, REPLACE(rt.[Txt 1],'-','') AS 'Category'
, rt.id				 AS 'refId'
, c.LocationTree     As 'LocationTree'
, c.ClassificationTree as 'ClassTree'
, c.controller_name		AS 'controller_name'
, 'NGAC'		As 'controller_type'

from GADATA.NGAC.rt_ErrDispLogS4C as rt 
left join GADATA.NGAC.rt_csv_file as rt_csv on rt.rt_csv_file_id = rt_csv.id
LEFT JOIN NGAC.c_controller as c with (NOLOCK) on c.id = rt_csv.c_controller_id
where rt.Breaktimestamp is not null and  rt.Breaktimestamp <> '1900-01-01 00:00:00.000'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'S4C', @level1type = N'VIEW', @level1name = N'Breakdown';


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
         Begin Table = "rt"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rt_csv"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 135
               Right = 420
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 458
               Bottom = 135
               Right = 640
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
', @level0type = N'SCHEMA', @level0name = N'S4C', @level1type = N'VIEW', @level1name = N'Breakdown';

