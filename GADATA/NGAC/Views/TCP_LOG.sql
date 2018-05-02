




CREATE VIEW [NGAC].[TCP_LOG]
AS
select 
 c.controller_name
,SUBSTRING( c.controller_name,0,CHARINDEX('R',  c.controller_name) )
 +REPLACE(REPLACE(REPLACE(REPLACE(rt.[tool name],'Doser',''),'Stud',''),'Gun',''),'TCP','') as 'Toolname'
,rt.* 
,setup.[Meas TCP X] as 'SetupTCP_X'
,setup.[Meas TCP Y] as 'SetupTCP_Y'
,setup.[Meas TCP Z] as 'SetupTCP_Z'

--when we have a bad measurement the 'new tcp values' are 0 but we whant to show this in the log we do have the offset so calc like that 
,[NGAC].[DistanceBetweenPoints](
	 rt.[Old TCP X]+rt.[Tool Diff X]
	,rt.[Old TCP Y]+rt.[Tool Diff Y]
	,rt.[Old TCP Z]+rt.[Tool Diff Z]
	,setup.[Meas TCP X]
	,setup.[Meas TCP Y]
	,setup.[Meas TCP Z])   as 'DeltaRef'
--only give a result for valid TCP updates ! 
/*
,CASE rt.[Action] 
  WHEN 'UPDATE'  THEN [NGAC].[DistanceBetweenPoints](rt.[New TCP X],rt.[New TCP Y],rt.[New TCP Z],setup.[Meas TCP X],setup.[Meas TCP Y],setup.[Meas TCP Z])   
  ELSE null 
 END  as 'DeltaRef'
 */
from GADATA.NGAC.rt_TCP_LOG as rt 
left join GADATA.NGAC.rt_csv_file as rt_csv on rt.rt_csv_file_id = rt_csv.id
left join GADATA.NGAC.c_controller as c on c.id = rt_csv.c_controller_id

--join the setup record to get the initial tcp value 
left join (
select 
 c.controller_name
,rt.*
,ROW_NUMBER() OVER (PARTITION BY c.controller_name, rt.[SetupNo] ORDER BY rt.[Date Time] DESC) AS 'rnDesc'
from GADATA.NGAC.rt_BeamSetUpLog as rt 
left join GADATA.NGAC.rt_csv_file as rt_csv on rt.rt_csv_file_id = rt_csv.id
left join GADATA.NGAC.c_controller as c on c.id = rt_csv.c_controller_id
) as setup on 
setup.controller_name = c.controller_name 
AND
setup.SetupNo = rt.[SetUp No]
AND 
setup.rnDesc = 1 --only the most recent setup ! 
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'TCP_LOG';


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
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 135
               Right = 629
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
', @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'TCP_LOG';

