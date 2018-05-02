CREATE VIEW LAUNCH.JoiningParameterPlatesGA
AS
SELECT DISTINCT 
                  GETDATE() AS Date, dbo.NPT.Name AS NPT, dbo.Timer.Name AS TIMER, dbo.Spot.Number, dbo.Spot.Program, dbo.WeldParameters.Value AS Pressure, 
                  WeldParameters_1.Value AS Squeeze, WeldParameters_2.Value AS KA_1, WeldParameters_3.Value AS WELD1, WeldParameters_6.Value AS COOL_1, 
                  WeldParameters_4.Value AS KA_2, WeldParameters_5.Value AS WELD2, WeldParameters_7.Value AS COOL_2, WeldParameters_8.Value AS KA_3, 
                  WeldParameters_9.Value AS WELD3, WeldParameters_10.Value AS HOLD, WeldParameters_11.Value AS [PRprofile ON ?], PlateType_1.Thickness AS thickness1, 
                  PlateMaterial_1.Name AS Material1, PlateCoating_1.Name AS Coating1, dbo.PlateType.Thickness AS Thickness2, dbo.PlateMaterial.Name AS Material2, 
                  dbo.PlateCoating.Name AS Coating2, PlateType_2.Thickness AS thickness3, PlateMaterial_2.Name AS Material3, PlateCoating_2.Name AS coating3, 
                  PlateType_3.Thickness AS thickness4, PlateMaterial_3.Name AS Material4, PlateCoating_3.Name AS coating4
FROM     dbo.PlateMaterial AS PlateMaterial_1 INNER JOIN
                  dbo.PlateType AS PlateType_1 ON PlateMaterial_1.ID = PlateType_1.MaterialID INNER JOIN
                  dbo.PlateCoating AS PlateCoating_1 ON PlateType_1.CoatingID = PlateCoating_1.ID RIGHT OUTER JOIN
                  dbo.PlateCoating INNER JOIN
                  dbo.PlateMaterial INNER JOIN
                  dbo.PlateType ON dbo.PlateMaterial.ID = dbo.PlateType.MaterialID ON dbo.PlateCoating.ID = dbo.PlateType.CoatingID RIGHT OUTER JOIN
                  dbo.NPT INNER JOIN
                  dbo.Timer INNER JOIN
                  dbo.PlateCombinations INNER JOIN
                  dbo.Spot INNER JOIN
                  dbo.TimerParameterName INNER JOIN
                  dbo.WeldParameters ON dbo.TimerParameterName.ID = dbo.WeldParameters.ParameterNameID ON dbo.Spot.ID = dbo.WeldParameters.SpotID INNER JOIN
                  dbo.WeldParameters AS WeldParameters_1 ON dbo.Spot.ID = WeldParameters_1.SpotID INNER JOIN
                  dbo.TimerParameterName AS TimerParameterName_1 ON WeldParameters_1.ParameterNameID = TimerParameterName_1.ID INNER JOIN
                  dbo.WeldParameters AS WeldParameters_2 ON dbo.Spot.ID = WeldParameters_2.SpotID INNER JOIN
                  dbo.TimerParameterName AS TimerParameterName_2 ON WeldParameters_2.ParameterNameID = TimerParameterName_2.ID INNER JOIN
                  dbo.WeldParameters AS WeldParameters_3 ON dbo.Spot.ID = WeldParameters_3.SpotID INNER JOIN
                  dbo.TimerParameterName AS TimerParameterName_3 ON WeldParameters_3.ParameterNameID = TimerParameterName_3.ID INNER JOIN
                  dbo.WeldParameters AS WeldParameters_4 ON dbo.Spot.ID = WeldParameters_4.SpotID INNER JOIN
                  dbo.TimerParameterName AS TimerParameterName_4 ON WeldParameters_4.ParameterNameID = TimerParameterName_4.ID INNER JOIN
                  dbo.WeldParameters AS WeldParameters_5 ON dbo.Spot.ID = WeldParameters_5.SpotID INNER JOIN
                  dbo.TimerParameterName AS TimerParameterName_5 ON WeldParameters_5.ParameterNameID = TimerParameterName_5.ID INNER JOIN
                  dbo.WeldParameters AS WeldParameters_6 ON dbo.Spot.ID = WeldParameters_6.SpotID INNER JOIN
                  dbo.TimerParameterName AS TimerParameterName_6 ON WeldParameters_6.ParameterNameID = TimerParameterName_6.ID INNER JOIN
                  dbo.WeldParameters AS WeldParameters_7 ON dbo.Spot.ID = WeldParameters_7.SpotID INNER JOIN
                  dbo.TimerParameterName AS TimerParameterName_7 ON WeldParameters_7.ParameterNameID = TimerParameterName_7.ID INNER JOIN
                  dbo.WeldParameters AS WeldParameters_8 ON dbo.Spot.ID = WeldParameters_8.SpotID INNER JOIN
                  dbo.TimerParameterName AS TimerParameterName_8 ON WeldParameters_8.ParameterNameID = TimerParameterName_8.ID INNER JOIN
                  dbo.WeldParameters AS WeldParameters_9 ON dbo.Spot.ID = WeldParameters_9.SpotID INNER JOIN
                  dbo.TimerParameterName AS TimerParameterName_9 ON WeldParameters_9.ParameterNameID = TimerParameterName_9.ID INNER JOIN
                  dbo.WeldParameters AS WeldParameters_10 ON dbo.Spot.ID = WeldParameters_10.SpotID INNER JOIN
                  dbo.TimerParameterName AS TimerParameterName_10 ON WeldParameters_10.ParameterNameID = TimerParameterName_10.ID INNER JOIN
                  dbo.WeldParameters AS WeldParameters_11 ON dbo.Spot.ID = WeldParameters_11.SpotID INNER JOIN
                  dbo.TimerParameterName AS TimerParameterName_11 ON WeldParameters_11.ParameterNameID = TimerParameterName_11.ID ON 
                  dbo.PlateCombinations.ID = dbo.Spot.PlateCombinationtId ON dbo.Timer.ID = dbo.Spot.TimerID ON dbo.NPT.ID = dbo.Timer.NptId ON 
                  dbo.PlateType.ID = dbo.PlateCombinations.Plate2ID ON PlateType_1.ID = dbo.PlateCombinations.Plate1ID LEFT OUTER JOIN
                  dbo.PlateMaterial AS PlateMaterial_2 INNER JOIN
                  dbo.PlateType AS PlateType_2 ON PlateMaterial_2.ID = PlateType_2.MaterialID INNER JOIN
                  dbo.PlateCoating AS PlateCoating_2 ON PlateType_2.CoatingID = PlateCoating_2.ID ON dbo.PlateCombinations.Plate3ID = PlateType_2.ID LEFT OUTER JOIN
                  dbo.PlateMaterial AS PlateMaterial_3 INNER JOIN
                  dbo.PlateType AS PlateType_3 ON PlateMaterial_3.ID = PlateType_3.MaterialID INNER JOIN
                  dbo.PlateCoating AS PlateCoating_3 ON PlateType_3.CoatingID = PlateCoating_3.ID ON dbo.PlateCombinations.Plate4ID = PlateType_3.ID
WHERE  (dbo.TimerParameterName.Description LIKE N'Base pressu%') AND (TimerParameterName_1.Description LIKE N'Squeeze%') AND 
                  (TimerParameterName_2.Description LIKE N'1. HEA%') AND (TimerParameterName_3.Description LIKE N'1. Weld%') AND 
                  (TimerParameterName_4.Description LIKE N'2. Hea%') AND (TimerParameterName_5.Description LIKE N'2. Weld%') AND 
                  (TimerParameterName_6.Description LIKE N'1. Cool%') AND (TimerParameterName_7.Description LIKE N'2. COOL%') AND 
                  (TimerParameterName_8.Description LIKE N'3. Hea%') AND (TimerParameterName_9.Description LIKE N'3. Weld%') AND 
                  (TimerParameterName_10.Description LIKE N'HOLD%') AND (TimerParameterName_11.Description LIKE N'PRESSURE PRO%') AND (NOT (dbo.Spot.Program BETWEEN 
                  '250' AND '255'))
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 4, @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'JoiningParameterPlatesGA';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane4', @value = N'"
            Begin Extent = 
               Top = 762
               Left = 38
               Bottom = 891
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_11"
            Begin Extent = 
               Top = 762
               Left = 694
               Bottom = 891
               Right = 864
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateMaterial_3"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 118
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateType_3"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 135
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateCoating_3"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 118
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NPT"
            Begin Extent = 
               Top = 799
               Left = 479
               Bottom = 960
               Right = 673
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
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1344
         Table = 2112
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'JoiningParameterPlatesGA';




GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane3', @value = N'     Bottom = 513
               Right = 656
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_4"
            Begin Extent = 
               Top = 402
               Left = 902
               Bottom = 531
               Right = 1072
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_5"
            Begin Extent = 
               Top = 498
               Left = 38
               Bottom = 627
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_5"
            Begin Extent = 
               Top = 498
               Left = 694
               Bottom = 627
               Right = 864
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_6"
            Begin Extent = 
               Top = 498
               Left = 1110
               Bottom = 627
               Right = 1296
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_6"
            Begin Extent = 
               Top = 516
               Left = 262
               Bottom = 645
               Right = 432
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_7"
            Begin Extent = 
               Top = 516
               Left = 470
               Bottom = 645
               Right = 656
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_7"
            Begin Extent = 
               Top = 534
               Left = 902
               Bottom = 663
               Right = 1072
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_8"
            Begin Extent = 
               Top = 630
               Left = 38
               Bottom = 759
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_8"
            Begin Extent = 
               Top = 630
               Left = 694
               Bottom = 759
               Right = 864
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_9"
            Begin Extent = 
               Top = 630
               Left = 1110
               Bottom = 759
               Right = 1296
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_9"
            Begin Extent = 
               Top = 648
               Left = 262
               Bottom = 777
               Right = 432
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_10"
            Begin Extent = 
               Top = 648
               Left = 470
               Bottom = 777
               Right = 656
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_10"
            Begin Extent = 
               Top = 666
               Left = 902
               Bottom = 795
               Right = 1072
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_11', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'JoiningParameterPlatesGA';




GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateMaterial"
            Begin Extent = 
               Top = 138
               Left = 246
               Bottom = 250
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateType"
            Begin Extent = 
               Top = 138
               Left = 870
               Bottom = 267
               Right = 1040
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 761
               Left = 1174
               Bottom = 953
               Right = 1368
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateCombinations"
            Begin Extent = 
               Top = 234
               Left = 38
               Bottom = 363
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 234
               Left = 662
               Bottom = 541
               Right = 861
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName"
            Begin Extent = 
               Top = 234
               Left = 1078
               Bottom = 363
               Right = 1248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters"
            Begin Extent = 
               Top = 252
               Left = 246
               Bottom = 381
               Right = 432
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_1"
            Begin Extent = 
               Top = 252
               Left = 470
               Bottom = 381
               Right = 656
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_1"
            Begin Extent = 
               Top = 270
               Left = 899
               Bottom = 399
               Right = 1069
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_2"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 495
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_2"
            Begin Extent = 
               Top = 366
               Left = 694
               Bottom = 495
               Right = 864
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_3"
            Begin Extent = 
               Top = 366
               Left = 1107
               Bottom = 495
               Right = 1293
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_3"
            Begin Extent = 
               Top = 384
               Left = 262
               Bottom = 513
               Right = 432
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_4"
            Begin Extent = 
               Top = 384
               Left = 470
          ', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'JoiningParameterPlatesGA';




GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[56] 4[18] 2[7] 3) )"
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
         Top = -494
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PlateMaterial_2"
            Begin Extent = 
               Top = 6
               Left = 662
               Bottom = 118
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateType_2"
            Begin Extent = 
               Top = 6
               Left = 870
               Bottom = 135
               Right = 1040
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateCoating_2"
            Begin Extent = 
               Top = 6
               Left = 1078
               Bottom = 118
               Right = 1248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateMaterial_1"
            Begin Extent = 
               Top = 120
               Left = 38
               Bottom = 232
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateType_1"
            Begin Extent = 
               Top = 120
               Left = 454
               Bottom = 249
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateCoating_1"
            Begin Extent = 
               Top = 120
               Left = 662
               Bottom = 232
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PlateCoating"
            Begin Extent = 
               Top = 120
               Left = 1078
               Bottom = 232
               Right = 1248', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'JoiningParameterPlatesGA';



