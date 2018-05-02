
CREATE VIEW [NGAC].[TipDressAvgWear]
AS
select 
 x.controller_name
,x.LocationTree
,MAX(x.TipchangeTimestamp) as 'LastTipchangeTimestamp'
,MIN(x.TipchangeTimestamp) as 'FirstTipchangeTimestamp'
,ROUND(AVG(x.FixedWearBeforeChange/x.DressBeforeChange),2) as 'FixedWear/dress'
,ROUND(AVG(x.MoveWearBeforeChange/x.DressBeforeChange),2) as 'MovWear/dress'
,ROUND(AVG(x.WearBeforeChange/x.DressBeforeChange),2) as 'Wear/dress'
from (
select 
 l.controller_name
,l.LocationTree
,l.TipchangeTimestamp 
,l.FixedWearBeforeChange
,l.MoveWearBeforeChange
,l.WearBeforeChange
,l.DressBeforeChange
,ROW_NUMBER() OVER (PARTITION BY l.controller_name ORDER BY l.TipchangeTimestamp desc) AS 'rnDESC'
,l.tipDressID
from GADATA.NGAC.TipwearBeforeChange as l 
where l.TipchangeTimestamp between GETDATE()-10 and GETDATE() --limit view window 10 days
and l.FixedWearBeforeChange <> 0 and l.MoveWearBeforeChange <> 0 and l.DressBeforeChange > 10 --no 0 and min 10 times dress
) as x 
WHERE x.rnDESC in (1,2,3) --use data from last 3 tipchanges
GROUP BY
 x.controller_name
,x.LocationTree
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'TipDressAvgWear';


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
', @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'TipDressAvgWear';

