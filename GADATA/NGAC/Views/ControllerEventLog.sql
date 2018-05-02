



CREATE VIEW [NGAC].[ControllerEventLog]
AS
--*******************************************************************************************************--
--NGAC error
--*******************************************************************************************************--
SELECT 
  c.controller_name		   AS 'Location' 
, c.CLassificationId     AS 'AssetID'
,'ControllerEvent'	  AS 'Logtype'
, ISNULL(H._timestamp,h.error_timestamp)        AS 'timestamp'
, CAST(Le.Number as varchar(max))     AS 'Logcode'
, CAST(Le.l_type_id as varchar(max))    AS 'Severity'

--SDB 18w04D2 can not drop all titles with '%' because of GB ORG L
,CASE when (Le.[Title] LIKE '%ErrDisplay 1 : %') OR (Le.[Title] LIKE '%External weld fault reported%')
 THEN ISNULL(ld.CleanDescription,'#No Description available')
 ELSE ISNULL(RTRIM(LTRIM(Le.[Title])),'#No Title available')
 END AS 'Logtext'

 ,CASE when (Le.[Title] LIKE '%ErrDisplay 1 : %') OR (Le.[Title] LIKE '%External weld fault reported%')
 THEN ISNULL(ld.CleanDescription,'#No Description available')
 ELSE isnull(RTRIM(LTRIM(Le.[Title])),'#No Title available') + CHAR(13)+CHAR(10) +  
  isnull(ld.CleanDescription ,'#No Description available')
 END AS 'FullLogtext'
, NULL     AS 'Response'
, NULL     AS 'Downtime'
, RTRIM(ISNULL(cc.Classification,'Undefined*'))  AS 'Classification'
, ISNULL(cs.Subgroup,'Undefined*')		 AS 'Subgroup'
, ISNULL(lc.category,'Undefined*') AS 'Category'
, H.id				 AS 'refId'
, c.LocationTree     As 'LocationTree'
, c.ClassificationTree as 'ClassTree'
, c.controller_name		AS 'controller_name'
, 'NGAC'		As 'controller_type'

FROM  NGAC.h_alarm AS H with (NOLOCK) 
LEFT OUTER JOIN NGAC.L_error AS Le with (NOLOCK)  ON Le._id = H.L_error_id 
LEFT OUTER JOIN NGAC.L_description AS ld with (NOLOCK)  ON ld.id = le.l_description_id
LEFT OUTER JOIN NGAC.L_type AS lt with (NOLOCK)  ON lt.id  = le.l_type_id
LEFT OUTER JOIN NGAC.L_category as lc with (NOLOCK)  on lc.id = h.CategoryId

LEFT OUTER JOIN VOLVO.c_Classification as cc with (NOLOCK)  on cc.id = Le.c_ClassificationId
LEFT OUTER JOIN VOLVO.c_Subgroup as cs with (NOLOCK)  on cs.id = Le.c_SubgroupId

LEFT JOIN NGAC.c_controller as c with (NOLOCK) on c.id = h.controller_id
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'ControllerEventLog';


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
               Top = 7
               Left = 48
               Bottom = 168
               Right = 261
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "L"
            Begin Extent = 
               Top = 7
               Left = 309
               Bottom = 168
               Right = 503
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "A"
            Begin Extent = 
               Top = 7
               Left = 551
               Bottom = 168
               Right = 762
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 7
               Left = 810
               Bottom = 168
               Right = 1037
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
', @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'ControllerEventLog';

