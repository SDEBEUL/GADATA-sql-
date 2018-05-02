





CREATE VIEW [EqUi].[stw040]
AS
SELECT DISTINCT
  isnull(assets.location,RTRIM(stw040.machines)+'#')		   AS 'Location' 
, assets.CLassificationId   AS 'AssetID'
,'STW040'		   AS 'Logtype'
, stw040.[Begin storing]     AS 'timestamp'
, stw040.Eig#	      AS 'Logcode'
, null			AS 'Severity'
, '[Aktie]: '+ isnull(stw040.[Omschrijving aktie], isnull(stw040.[Objectcode + omschrijving],'N/A')) + 
char(10)+char(13)+'|[#]:' + isnull(cast(stw040.[#] as varchar(5)),'N/A') + 
' |[Verl# T (min)]:' + isnull(cast(stw040.[Verl# T (min)] as varchar(5)),'N/A')  AS 'logtext'
, null	AS 'Response(s)' 
, cast(stw040.[#] as int) AS 'Downtime(s)'
, isnull(stw040.[Objectcode + omschrijving],'Undefined*')  AS 'Classification'
, isnull(stw040.[omschrijving oorzaak],'Undefined*') AS 'Subgroup'
, cast(stw040.id as varchar(max))  AS 'refId'
, assets.LocationTree     As 'LocationTree'
, assets.ClassificationTree as 'ClassTree'
, stw040.Machines+'#'		AS 'controller_name'
, 'stw040'		As 'controller_type'
FROM [GADATA].[EqUi].['Zone - Lijst - Laatste werkdag$'] as stw040
left join gadata.equi.assets on 

UPPER(LTRIM(RTRIM(assets.location)))
like
UPPER(LTRIM(RTRIM(
REPLACE(
REPLACE(stw040.Machines,'GH','G%')
,'WT','WT%')
)))
+'%'

--the replace GH is because every gripper in STW040 is GH and in reality can be GH GP GD
--the replace WT is because every tucker in stw040 is WT and in reality should be WTA WTP .... (we put everything on WTA) 
--the +'%' is because almost nobody in stw040 defines the specific tool. 
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'EqUi', @level1type = N'VIEW', @level1name = N'stw040';


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
         Begin Table = "stw040"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 168
               Right = 322
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ASSETS (EqUi)"
            Begin Extent = 
               Top = 7
               Left = 370
               Bottom = 168
               Right = 581
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
', @level0type = N'SCHEMA', @level0name = N'EqUi', @level1type = N'VIEW', @level1name = N'stw040';

