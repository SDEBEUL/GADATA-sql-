
/********************************************************************************************************--
c4g breakdown
*******************************************************************************************************--
*******************************************************************************************************--*/
CREATE VIEW [C4G].[Breakdown]
AS
--*******************************************************************************************************--
--c4g breakdown
--*******************************************************************************************************--
SELECT 
  isnull(a.LOCATION,c.controller_name+'#')		   AS 'Location' 
, a.CLassificationId   AS 'AssetID'
,'BREAKDOWN'		   AS 'Logtype'
, H.EndOfBreakdown     AS 'timestamp'
, ISNULL(LR.[error_number],L.[error_number])	      AS 'Logcode'
, ISNULL(LR.[error_severity],L.[error_severity])			AS 'Severity'
, ISNULL(('|R: ' + LR.error_text), L.error_text )		AS 'logtext'
, DATEDIFF(second,'1900-01-01 00:00:00', H.Rt) 	AS 'Response(s)' 
, DATEDIFF(second, H.StartOfBreakdown, H.EndOfBreakdown)AS 'Downtime(s)'
, RTRIM(ISNULL(ISNULL(Rcc.Classification, cc.Classification),'Undefined*'))  AS 'Classification'
, ISNULL(ISNULL(Rcs.Subgroup,cs.Subgroup),'Undefined*')					   AS 'Subgroup'
, H.id				 AS 'refId'
, a.LocationTree     As 'LocationTree'
, a.ClassificationTree as 'ClassTree'
, c.controller_name		AS 'controller_name'
, 'c4g'		As 'controller_type'

FROM  C4G.h_breakdown AS H 
LEFT OUTER JOIN C4G.L_error AS L ON L.id = H.error_id 
LEFT OUTER JOIN C4G.L_error as LR ON LR.ID = H.RC_error_id
LEFT OUTER JOIN VOLVO.c_Classification as cc on cc.id = L.c_ClassificationId
LEFT OUTER JOIN VOLVO.c_Subgroup as cs on cs.id = L.c_SubgroupId
LEFT OUTER JOIN VOLVO.c_Classification as Rcc on Rcc.id = LR.c_ClassificationId
LEFT OUTER JOIN VOLVO.c_Subgroup as Rcs on Rcs.id = LR.c_SubgroupId
--joining of the RIGHT ASSET
LEFT OUTER JOIN equi.ASSETS as A on 
A.controller_type = 'c4g' --join the right 'data controller type'
AND
A.controller_id = h.controller_id --join the right 'data controller id'
AND 
A.CLassificationId LIKE '%' + RTRIM(ISNULL(ISNULL(Rcc.Classification, cc.Classification),'UR')) + '%' --join only the asset with the right classification. (if not classified data goes to robot)
AND
A.controller_ToolID = 1 --temp until we find a multi tool support sollution
--
LEFT JOIN c4g.c_controller as c on c.id = h.controller_id
--*******************************************************************************************************--
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'C4G', @level1type = N'VIEW', @level1name = N'Breakdown';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'    End
         Begin Table = "A"
            Begin Extent = 
               Top = 168
               Left = 48
               Bottom = 329
               Right = 259
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 168
               Left = 307
               Bottom = 329
               Right = 534
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
', @level0type = N'SCHEMA', @level0name = N'C4G', @level1type = N'VIEW', @level1name = N'Breakdown';


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
               Right = 264
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "L"
            Begin Extent = 
               Top = 7
               Left = 312
               Bottom = 168
               Right = 520
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LR"
            Begin Extent = 
               Top = 7
               Left = 568
               Bottom = 168
               Right = 776
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cc"
            Begin Extent = 
               Top = 7
               Left = 824
               Bottom = 146
               Right = 1018
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cs"
            Begin Extent = 
               Top = 7
               Left = 1066
               Bottom = 146
               Right = 1260
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Rcc"
            Begin Extent = 
               Top = 147
               Left = 824
               Bottom = 286
               Right = 1018
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Rcs"
            Begin Extent = 
               Top = 147
               Left = 1066
               Bottom = 286
               Right = 1260
            End
            DisplayFlags = 280
            TopColumn = 0
     ', @level0type = N'SCHEMA', @level0name = N'C4G', @level1type = N'VIEW', @level1name = N'Breakdown';

