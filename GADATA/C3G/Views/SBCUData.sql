
CREATE VIEW [C3G].[SBCUData]
AS
SELECT
       [tool_timestamp]
	  ,R.controller_name as 'RobotName'
      ,'Tool: ' + CAST(tl.[tool_id] as varchar(15)) as 'tool_id'
      ,ROUND([Dmeas],2) as 'Dmeas'
      ,ROUND([Dsetup],2) as 'Dsetup'
      ,ROUND([ToolX],2) as 'ToolX'
      ,ROUND([Tooly],2) as 'ToolY'
      ,ROUND([ToolZ],2) as 'ToolZ'
      ,ROUND([ToolA],2) as 'Toola'
      ,ROUND([ToolE],2) as 'Toole'
      ,ROUND([ToolR],2) as 'Toolr'
      ,Tl.[Longcheck]
      ,[TcpUpdate]
	  ,T.Vyear
	  ,T.Vweek
	  ,T.Vday
	  ,ROUND(ref.avg,2) as 'RefAVG'
	  ,ROUND(ref.Stdev,2) as 'RefSTDEC'
	  ,ROUND(ref.LCL,2) as 'LCL'
	  ,ROUND(ref.UCL,2) as 'UCL'
	  ,ref.nDataPoints as 'RefDp'
	  ,ref.SampleStart as 'RefSS'
	  ,tl.ID as 'ID'
  FROM [GADATA].c3g.[rt_toollog] AS TL
  left join GADATA.c3g.c_controller AS R on R.ID = TL.controller_id
  left join GADATA.Volvo.L_timeline as T on TL.tool_timestamp BETWEEN T.starttime AND T.endtime
  --join the SPC data if available.
  left join GADATA.c3g.SBCUrefernce as ref 
  on 
  (
  (ref.Controller_id = tl.controller_id)
  AND
  (ref.tool_id = Tl.tool_id)
  AND
  (tl.Longcheck = ref.Longcheck)
  )
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'C3G', @level1type = N'VIEW', @level1name = N'SBCUData';


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
         Begin Table = "c_Appl (ABB)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 101
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c_Appl_1"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 101
               Right = 416
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
', @level0type = N'SCHEMA', @level0name = N'C3G', @level1type = N'VIEW', @level1name = N'SBCUData';

