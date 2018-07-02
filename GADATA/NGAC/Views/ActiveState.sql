








CREATE VIEW [NGAC].[ActiveState]
AS
SELECT 
  c.controller_name		   AS 'Location' 
, c.CLassificationId     AS 'AssetID'
, 'LIVE'	  AS 'Logtype'
, GETDATE()        AS 'timestamp'
, CAST(Le.Number as varchar(max))     AS 'Logcode'
, CAST(Le.l_type_id as varchar(max))    AS 'Severity'

,CASE 
 WHEN (rtai.vasc_state <> 1) THEN 'VASC ERROR: ' + CAST(rtai.vasc_state as varchar(max)) + '  Session: '+ISNULL(rtai.vasc_session,'unknown')
 WHEN (Le.[Title] LIKE '%:%') OR (Le.[Title] LIKE '%External weld fault reported%')
 THEN ISNULL(ld.CleanDescription,'#No Description available')
 ELSE ISNULL(RTRIM(LTRIM(Le.[Title])),'#No Title available')
 END AS 'Logtext'

,CASE when (Le.[Title] LIKE '%:%') OR (Le.[Title] LIKE '%External weld fault reported%')
 THEN ISNULL(ld.CleanDescription,'#No Description available')
 ELSE isnull(RTRIM(LTRIM(Le.[Title])),'#No Title available') + CHAR(13)+CHAR(10) +  
  isnull(ld.CleanDescription ,'#No Description available')
 END AS 'FullLogtext'

,DATEDIFF(SECOND,rtai.ts_breakDownAck,GETDATE()) as 'Response' 
,DATEDIFF(SECOND,rtai.ts_breakDownStart,GETDATE() ) as 'Downtime'

, RTRIM(ISNULL(cc.Classification,'Undefined*'))  AS 'Classification'
, ISNULL(cs.Subgroup,'Undefined*')		 AS 'Subgroup'
, ISNULL(lc.category,'Undefined*') AS 'Category'
,CASE 
 WHEN rtai.h_alarm_id <> 0 THEN rtai.h_alarm_id --used this ID because of _loginfo
 ELSE rtai.id * -1 --to make a random number that will not match any halarm record (entetyframework shit)
 END AS 'refid'
, c.LocationTree     As 'LocationTree'
, c.ClassificationTree as 'ClassTree'
, c.controller_name		AS 'controller_name'
, 'NGAC'		As 'controller_type'


FROM [GADATA].[NGAC].[rt_active_info] as rtai
LEFT JOIN GADATA.NGAC.c_controller as c on c.id = rtai.c_controller_id
LEFT JOIN GADATA.NGAC.h_alarm as h on h.id = rtai.h_alarm_id
LEFT JOIN GADATA.NGAC.L_error as Le on Le._id = h.L_error_id
LEFT OUTER JOIN GADATA.NGAC.L_description AS ld  ON ld.id = le.l_description_id

LEFT OUTER JOIN NGAC.L_type AS lt with (NOLOCK)  ON lt.id  = le.l_type_id
LEFT OUTER JOIN NGAC.L_category as lc with (NOLOCK)  on lc.id = h.CategoryId

LEFT OUTER JOIN VOLVO.c_Classification as cc with (NOLOCK)  on cc.id = Le.c_ClassificationId
LEFT OUTER JOIN VOLVO.c_Subgroup as cs with (NOLOCK)  on cs.id = Le.c_SubgroupId



--WHERE rtai.application_error = 0 AND rtai.program_number <> 0-- OR rtai.task_execution_status = 
WHERE 
-- c.class_id in(2,6) --NGAC or ORG line with VASC  
--and 
(
(rtai.application_error = 0 and rtai.ts_breakDownStart is not null) --in appl fault and ts_breakdown not null. 
--SDEBEUL 18w15d2 this ts_breakdownstart is only needed until we fix the application auto reset after pp moved.
or
rtai.vasc_state <> 1 --1 vasc fully connected
)
and c.enable_bit <> -1 --robot must be in use 
--and rtai.program_number <> 0 --must be running a job

--temp for mute testing 
and rtai.vasc_session not like '%8%'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'ActiveState';


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
         Begin Table = "rtai"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "h"
            Begin Extent = 
               Top = 6
               Left = 278
               Bottom = 135
               Right = 462
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Le"
            Begin Extent = 
               Top = 6
               Left = 500
               Bottom = 135
               Right = 687
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ld"
            Begin Extent = 
               Top = 6
               Left = 725
               Bottom = 135
               Right = 904
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 942
               Bottom = 135
               Right = 1117
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
', @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'ActiveState';

