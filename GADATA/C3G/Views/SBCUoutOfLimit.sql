
CREATE VIEW [C3G].[SBCUoutOfLimit]
AS
SELECT 
*
FROM
(
SELECT 
  r.location AS 'Location'
, r.controller_name AS 'Robotname'
, r.id AS 'Controller_ID'
,'C3G' AS 'Controller_Type'
, rt.Tool_id as 'Tool_id'
, 'SBCUalert' AS 'Alert_type'
, rt.tool_timestamp AS 'Timestamp'
, 'longSBCU |gun:' + CAST(rt.tool_id as varchar(2)) + ' Dsetup:' + CAST(ROUND(rt.Dsetup,1) as varchar(6)) + '  [ UCL:' + CAST(ROUND(ref.UCL,1)  as varchar(6)) + '| LCL:'  + CAST(ROUND(ref.lcl,1)  as varchar(6)) + ' ]'  AS 'Logtekst'
, rt.ID as 'Reference_ID'
, ROW_NUMBER() OVER (PARTITION BY rt.controller_id,rt.tool_id,rt.Longcheck ORDER BY rt.tool_timestamp desc) AS 'rnDESC'
FROM GADATA.c3g.rt_toollog as rt 
left join GADATA.c3g.c_controller as r on r.id = rt.controller_id
join GADATA.c3g.SBCUrefernce as ref on
ref.Controller_id = r.id
AND 
ref.Stdev is not null
AND
(rt.tool_id = ref.tool_id)
AND
(rt.Longcheck = ref.Longcheck) --sbcu must be of same type 
AND
(rt.Longcheck = 1) --only do the test for long sbcu. 
AND
(
rt.Dsetup > ref.UCL+1
or 
rt.Dsetup < ref.LCL-1
)
) as x 
where x.rnDESC = 1
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'C3G', @level1type = N'VIEW', @level1name = N'SBCUoutOfLimit';


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
         Begin Table = "c_category (ABB)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 101
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
', @level0type = N'SCHEMA', @level0name = N'C3G', @level1type = N'VIEW', @level1name = N'SBCUoutOfLimit';

