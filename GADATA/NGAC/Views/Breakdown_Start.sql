



CREATE VIEW [NGAC].[Breakdown_Start]
AS
SELECT 
  c.controller_name		   AS 'Location' 
, c.CLassificationId     AS 'AssetID'
, 'BREAKDOWN_start'	  AS 'Logtype'
, rtj.ts_breakDownStart        AS 'timestamp'
, CAST('' as varchar(max))     AS 'Logcode'
, CAST('' as varchar(max))    AS 'Severity'
, ' rtJBRef:'  + CAST(rtjb.id as varchar(max)) + ' h_alarmRef:' + CAST(rtjb.h_alarm_id as varchar(max)) + ' count:' + CAST(rtj.breakDownCount as varchar(max)) +
  ' rtjJob: ' + CAST(rtj.jobNo as varchar(max)) as 'Logtext'
, ' rtJBRef:'  + CAST(rtjb.id as varchar(max)) + ' h_alarmRef:' + CAST(rtjb.h_alarm_id as varchar(max)) + ' count:' + CAST(rtj.breakDownCount as varchar(max)) +
  ' rtjJob: ' + CAST(rtj.jobNo as varchar(max)) AS 'FullLogtext' 
,null as 'Response'
,null as 'Downtime'
, RTRIM(ISNULL(cc.Classification,'Undefined*'))  AS 'Classification'
, ISNULL(cs.Subgroup,'Undefined*')		 AS 'Subgroup'
, ISNULL(lc.category,'Undefined*') AS 'Category'
, rtj.id				 AS 'refId'
, c.LocationTree     As 'LocationTree'
, c.ClassificationTree as 'ClassTree'
, c.controller_name		AS 'controller_name'
, 'NGAC'		As 'controller_type'

FROM  NGAC.rt_job AS rtj 
LEFT JOIN GADATA.NGAC.rt_job_breakdown as rtjb on rtjb.rt_job_active_id = rtj.id AND rtjb.[index] = 1
LEFT JOIN GADATA.NGAC.h_alarm as h on h.id = rtjb.h_alarm_id
LEFT JOIN GADATA.NGAC.L_error as Le on Le._id = h.L_error_id
LEFT OUTER JOIN NGAC.L_description AS ld  ON ld.id = le.l_description_id

LEFT OUTER JOIN NGAC.L_type AS lt with (NOLOCK)  ON lt.id  = le.l_type_id
LEFT OUTER JOIN NGAC.L_category as lc with (NOLOCK)  on lc.id = h.CategoryId

LEFT OUTER JOIN VOLVO.c_Classification as cc with (NOLOCK)  on cc.id = Le.c_ClassificationId
LEFT OUTER JOIN VOLVO.c_Subgroup as cs with (NOLOCK)  on cs.id = Le.c_SubgroupId

LEFT JOIN NGAC.c_controller as c with (NOLOCK) on c.id = h.controller_id

WHERE rtj.ts_breakDownStart is not null 
AND rtj.ts_breakDownEnd is not null
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'Breakdown_Start';


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
         Begin Table = "H"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 263
               Bottom = 135
               Right = 445
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 483
               Bottom = 135
               Right = 658
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
', @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'Breakdown_Start';

