CREATE VIEW WELDING.nutCellsWeldData
AS
SELECT        dbo.Timer.Robot, dbo.NPT.Name AS NPT, dbo.Spot.Number AS Spotnr, dbo.Spot.Program, WELDING.nut_boltWeldMeasurements.Timestamp, 
                         WELDING.nut_boltWeldMeasurements.wear, WELDING.nut_boltWeldMeasurements.I_demand, WELDING.nut_boltWeldMeasurements.I_Actual, 
                         WELDING.nut_boltWeldMeasurements.regulation, WELDING.nut_boltWeldMeasurements.BodyNr, WELDING.nut_boltWeldMeasurements.ElectrodeNr, 
                         WELDING.nut_boltWeldMeasurements.Weldtime, WELDING.nut_boltWeldMeasurements.EnergyActual, WELDING.nut_boltWeldMeasurements.EnergyRef, 
                         WELDING.nut_boltWeldMeasurements.ResistanceActual, WELDING.nut_boltWeldMeasurements.ResistanceRef, Volvo.L_timeline.Vyear, Volvo.L_timeline.Vweek, 
                         Volvo.L_timeline.Vday, Volvo.L_timeline.PLOEG, WELDING.tbl_NutBoltWelding.MachineNumber, WELDING.tbl_NutBoltWelding.NutID_BoltID_PII, 
                         WELDING.nut_boltWeldMeasurements.ExpulsionTime
FROM            dbo.NPT INNER JOIN
                         dbo.Timer ON dbo.NPT.ID = dbo.Timer.NptId AND dbo.NPT.ID = dbo.Timer.NptId AND dbo.NPT.ID = dbo.Timer.NptId INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         WELDING.nut_boltWeldMeasurements ON dbo.Spot.ID = WELDING.nut_boltWeldMeasurements.SpotID INNER JOIN
                         WELDING.tbl_NutBoltWelding ON dbo.Spot.Number = WELDING.tbl_NutBoltWelding.NutID_BoltID_BOS6000 LEFT OUTER JOIN
                         Volvo.L_timeline ON WELDING.nut_boltWeldMeasurements.Timestamp BETWEEN Volvo.L_timeline.starttime AND Volvo.L_timeline.endtime
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'nutCellsWeldData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'        Width = 975
         Width = 960
         Width = 975
         Width = 2880
         Width = 2250
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
         Filter = 2685
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'nutCellsWeldData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[38] 4[17] 2[22] 3) )"
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
         Begin Table = "NPT"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 190
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 172
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 281
               Right = 653
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "nut_boltWeldMeasurements (WELDING)"
            Begin Extent = 
               Top = 205
               Left = 120
               Bottom = 356
               Right = 298
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "tbl_NutBoltWelding (WELDING)"
            Begin Extent = 
               Top = 207
               Left = 703
               Bottom = 336
               Right = 911
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "L_timeline (Volvo)"
            Begin Extent = 
               Top = 6
               Left = 914
               Bottom = 200
               Right = 1084
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 23
         Width = 284
 ', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'nutCellsWeldData';

