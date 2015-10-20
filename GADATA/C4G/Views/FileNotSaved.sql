


CREATE VIEW [C4G].[FileNotSaved]
AS

WITH rt_not_saved_rndesc AS 
(
	SELECT 
		   [id]
		  ,[controller_id]
		  ,[_timestamp]
		  ,[program]
		  ,[modified],
		  ROW_NUMBER() OVER (PARTITION BY controller_id, program ORDER BY _timestamp DESC) AS rnDESC
	  FROM [GADATA].[c4g].[rt_not_saved]
)


SELECT
	rt_not_saved_rndesc._timestamp As 'last change',
    c_controller.controller_name,
	rt_not_saved_rndesc.program,
	rt_not_saved_rndesc.modified,
	Lrt_not_saved_rndesc._timestamp as 'last ok time',
	datediff(hour,Lrt_not_saved_rndesc._timestamp,getdate()) as 'hours not saved'
FROM rt_not_saved_rndesc 

left join c4g.c_controller on controller_id = c_controller.id

left join rt_not_saved_rndesc AS Lrt_not_saved_rndesc ON
(
(rt_not_saved_rndesc.controller_id = Lrt_not_saved_rndesc.controller_id)
AND
(rt_not_saved_rndesc.program = Lrt_not_saved_rndesc.program)

AND
(rt_not_saved_rndesc.rnDESC = 1) -- current file state
AND
(rt_not_saved_rndesc.modified = 1) --state change from not saved to saved 

AND
(Lrt_not_saved_rndesc.modified = 0)

)

WHERE

(rt_not_saved_rndesc.modified = 1)
AND
(rt_not_saved_rndesc.rnDESC = 1)
--AND
--((rt_not_saved_rndesc.program NOT LIKE '%Rsssssrr%') AND (rt_not_saved_rndesc.program NOT LIKE '%Lsssssrr%'))
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'C4G', @level1type = N'VIEW', @level1name = N'FileNotSaved';


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
         Top = -192
         Left = 0
      End
      Begin Tables = 
         Begin Table = "c_controller"
            Begin Extent = 
               Top = 198
               Left = 38
               Bottom = 327
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
', @level0type = N'SCHEMA', @level0name = N'C4G', @level1type = N'VIEW', @level1name = N'FileNotSaved';

