

CREATE VIEW [C4G].[mod]
AS
WITH modtemp as
( 
SELECT 
      [file_timestamp]
      ,[controller_id]
      ,[Owner]
      ,[Pos]
      ,[X]
      ,[Y]
      ,[Z]
      ,[a]
      ,[e]
      ,[r]
      ,[ax7]
      ,[ax8]
      ,[Cnfg]
	  ,ROW_NUMBER() OVER (PARTITION BY [L_robotpositions].controller_id, [L_robotpositions].Owner, [L_robotpositions].pos  ORDER BY L_robotpositions._timestamp ASC) AS 'ModCount'
  FROM [GADATA].[C4G].[L_robotpositions]
) 


select 
       c.location  AS 'Location'
	   ,c.controller_name  AS 'Robotname'
	   ,'C4G' as 'Type'
	   ,'MOD' AS 'Errortype'
	   ,modtemp.[file_timestamp] AS 'timestamp'
	   ,NULL as 'Logcode'
	   ,Null as 'Severity'
      ,'Prog: ' + modtemp.[Owner] + '  Pos: ' + modtemp.[Pos] + 
	   '  DeltaP: ' + CAST(ROUND(SQRT(
	  POWER((modtemp.[X]-Lmodtemp.[X]),2)
	  +
	  POWER((modtemp.[Y]-Lmodtemp.[Y]),2)
	  +
	  POWER((modtemp.[Z]-Lmodtemp.[Z]),2)
	  ),2) as varchar)
	  + '  DeltaO: ' + CAST(ROUND(SQRT(
	  POWER((modtemp.[a]-Lmodtemp.[a]),2)
	  +
	  POWER((modtemp.[e]-Lmodtemp.[e]),2)
	  +
	  POWER((modtemp.[r]-Lmodtemp.[r]),2)
	  ),2) as varchar) as 'Logtekst'
	  ,NULL as 'Downtime'
	  ,LT.Vyear AS 'Year'
	  ,LT.Vweek  AS 'Week'
	  ,LT.Vday AS 'day'
	  ,LT.shift AS 'Shift'
	  ,'mod' as 'Object'
	  ,'mod' as 'Subgroup'
	  ,modtemp.ModCount as 'idx'


from modtemp
LEFT join modtemp Lmodtemp on 
(modtemp.controller_id = Lmodtemp.controller_id)
AND
(modtemp.Owner = Lmodtemp.Owner)
AND
(modtemp.Pos = Lmodtemp.pos)
AND
((modtemp.ModCount - 1) = Lmodtemp.ModCount)
LEFT JOIN GADATA.dbo.c_controller as c on c.id = modtemp.controller_id
LEFT JOIN GADATA.volvo.L_timeline as LT on modtemp.file_timestamp BETWEEN lt.starttime AND LT.endtime
where modtemp.modcount <> 1
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'C4G', @level1type = N'VIEW', @level1name = N'mod';


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
         Begin Table = "c_controller"
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
', @level0type = N'SCHEMA', @level0name = N'C4G', @level1type = N'VIEW', @level1name = N'mod';

