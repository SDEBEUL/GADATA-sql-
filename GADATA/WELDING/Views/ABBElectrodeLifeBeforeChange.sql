CREATE VIEW WELDING.ABBElectrodeLifeBeforeChange
AS
SELECT        NGAC.TipwearBeforeChange.controller_name, NGAC.TipwearBeforeChange.TipchangeTimestamp, NGAC.TipwearBeforeChange.FixedWearBeforeChange, 
                         NGAC.TipwearBeforeChange.MoveWearBeforeChange, NGAC.TipwearBeforeChange.WearBeforeChange, NGAC.TipwearBeforeChange.WeldsBeforeChange, 
                         NGAC.TipwearBeforeChange.DressBeforeChange, NGAC.TipwearBeforeChange.[%FixedWearBeforeChange], 
                         NGAC.TipwearBeforeChange.[%MoveWearBeforeChange], NGAC.TipwearBeforeChange.[TipAge(h)], MAX(WELDING.ABBWearComponent.WearComponent) 
                         AS WearComponent
FROM            NGAC.TipwearBeforeChange INNER JOIN
                         WELDING.ABBWearComponent ON NGAC.TipwearBeforeChange.controller_name = WELDING.ABBWearComponent.Robot
GROUP BY NGAC.TipwearBeforeChange.controller_name, NGAC.TipwearBeforeChange.TipchangeTimestamp, NGAC.TipwearBeforeChange.FixedWearBeforeChange, 
                         NGAC.TipwearBeforeChange.MoveWearBeforeChange, NGAC.TipwearBeforeChange.WearBeforeChange, NGAC.TipwearBeforeChange.WeldsBeforeChange, 
                         NGAC.TipwearBeforeChange.DressBeforeChange, NGAC.TipwearBeforeChange.[%FixedWearBeforeChange], 
                         NGAC.TipwearBeforeChange.[%MoveWearBeforeChange], NGAC.TipwearBeforeChange.[TipAge(h)]
HAVING        (NGAC.TipwearBeforeChange.FixedWearBeforeChange > 2) AND (NGAC.TipwearBeforeChange.MoveWearBeforeChange > 2) AND 
                         (NGAC.TipwearBeforeChange.WeldsBeforeChange > 100)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'ABBElectrodeLifeBeforeChange';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[16] 2[9] 3) )"
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
         Begin Table = "TipwearBeforeChange (NGAC)"
            Begin Extent = 
               Top = 0
               Left = 100
               Bottom = 331
               Right = 353
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "ABBWearComponent (WELDING)"
            Begin Extent = 
               Top = 91
               Left = 511
               Bottom = 253
               Right = 691
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
      Begin ColumnWidths = 14
         Width = 284
         Width = 1500
         Width = 2160
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1545
         Width = 1875
         Width = 1725
         Width = 1500
         Width = 1230
         Width = 1935
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 2745
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
', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'ABBElectrodeLifeBeforeChange';

