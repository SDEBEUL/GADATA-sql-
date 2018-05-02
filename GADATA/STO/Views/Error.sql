








/*use tag where breakdown started*/
CREATE VIEW [STO].[Error]
AS
SELECT 
 isnull(A.location,c.ALARMOBJECT +'#') as 'location'
,A.CLassificationId as 'AssetID'
,'STOerror'  as 'Logtype'
,CAST(h.ALARMTIMESTAMP as datetime) as 'timestamp'
,L.SUBOBJECT as 'Logcode'
,L.ALARMSEVERITY as 'Severity'
,isnull(l.ALARMCOMMENT,'NA')	as 'logtext'
,isnull(l.ALARMCOMMENT,'NA') as 'Fulllogtext'
,null  as 'Response'
,null  as 'Downtime'
, RTRIM(ISNULL(A.CLassificationId,'Undefined*'))  AS 'Classification' --for STO classification comes from ASSETID
, ISNULL(cs.Subgroup,'Undefined*')		 AS 'Subgroup'
, 'Undefined*' AS 'Category' --only for abb
, h.id	 AS 'refId'
, a.LocationTree     As 'LocationTree'
, a.ClassificationTree as 'ClassTree'
, c.ALAMRSOURCE 		AS 'controller_name'
, 'STO'		As 'controller_type'

FROM GADATA.STO.h_breakdown as h with (NOLOCK)
--join controller
LEFT JOIN GADATA.STO.c_controller as c with (NOLOCK) on c.id = h.c_controller_id
--join alarm text 
LEFT JOIN GADATA.STO.l_error as L with (NOLOCK) on L.id = h.l_error_id
--join subgroup 
LEFT JOIN GADATA.Volvo.c_Subgroup as cs with (NOLOCK) on cs.id = L.c_SubgroupId
--joining of the RIGHT ASSET
LEFT OUTER JOIN equi.ASSETS as A with (NOLOCK) on 
A.controller_type = 'STO' --join the right 'data controller type'
AND A.controller_id = h.c_controller_id --join the right 'data controller id'
AND c.ALARMOBJECT LIKE A.LOCATION +'%'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'STO', @level1type = N'VIEW', @level1name = N'Error';


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
               Top = 7
               Left = 48
               Bottom = 168
               Right = 272
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "A"
            Begin Extent = 
               Top = 7
               Left = 320
               Bottom = 168
               Right = 531
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
', @level0type = N'SCHEMA', @level0name = N'STO', @level1type = N'VIEW', @level1name = N'Error';

