CREATE VIEW dbo.WeldingParameters
AS
SELECT dbo.NPT.Name AS NPT, dbo.Timer.Name AS Timer, dbo.Spot.Number, dbo.Spot.Program, dbo.TimerParameterName.Description AS Pressure, 
                  dbo.WeldParameters.Value AS [Pressure Value], TimerParameterName_1.Description AS Squeeze, WeldParameters_1.Value AS SqueezValue, 
                  TimerParameterName_2.Description AS [Weld1 KA], WeldParameters_2.Value AS [Weld1 KA Value], TimerParameterName_3.Description AS [Weld1 MS], 
                  WeldParameters_3.Value AS [Weld1 MS Value], TimerParameterName_4.Description AS [CoolTime 1], WeldParameters_4.Value AS [CoolTime 1 Value], 
                  TimerParameterName_5.Description AS [Weld2 KA], WeldParameters_5.Value AS [Weld2 KA Value], TimerParameterName_6.Description AS [Weld2 Ms], 
                  WeldParameters_6.Value AS [Weld2 Ms Value], TimerParameterName_7.Description AS CoolTime2, WeldParameters_7.Value AS [CoolTime2 Value], 
                  TimerParameterName_8.Description AS [Weld3 KA], WeldParameters_8.Value AS [Weld3 KA Value], TimerParameterName_9.Description AS [Weld3 Ms], 
                  WeldParameters_9.Value AS [Weld3 Ms Value], TimerParameterName_10.Description AS Hold, WeldParameters_10.Value AS [Hold Value], 
                  TimerParameterName_11.Description AS [Pressure profile on?], WeldParameters_11.Value AS [On ?]
FROM     dbo.Spot INNER JOIN
                  dbo.WeldParameters ON dbo.Spot.ID = dbo.WeldParameters.SpotID INNER JOIN
                  dbo.TimerParameterName ON dbo.WeldParameters.ParameterNameID = dbo.TimerParameterName.ID INNER JOIN
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
                  dbo.TimerParameterName AS TimerParameterName_11 ON WeldParameters_11.ParameterNameID = TimerParameterName_11.ID INNER JOIN
                  dbo.Timer ON dbo.Spot.TimerID = dbo.Timer.ID INNER JOIN
                  dbo.NPT ON dbo.Timer.NptId = dbo.NPT.ID
WHERE  (dbo.TimerParameterName.Description = N'Base Pressure Value') AND (TimerParameterName_1.Description = N'Squeeze Time') AND (NOT (dbo.Spot.Program BETWEEN 
                  '250' AND '255')) AND (TimerParameterName_2.Description = N'1. Heat') AND (TimerParameterName_3.Description = N'1. Weld Time') AND 
                  (TimerParameterName_4.Description = N'1. Cool Time') AND (TimerParameterName_5.Description = N'2. Heat') AND (TimerParameterName_6.Description = N'2. Weld Time') 
                  AND (TimerParameterName_7.Description = N'2. Cool Time') AND (TimerParameterName_8.Description = N'3. Heat') AND 
                  (TimerParameterName_9.Description = N'3. Weld Time') AND (TimerParameterName_10.Description = N'Hold Time') AND 
                  (TimerParameterName_11.Description = N'Pressure Profile')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane3', @value = N'op = 499
               Left = 519
               Bottom = 560
               Right = 689
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_10"
            Begin Extent = 
               Top = 548
               Left = 304
               Bottom = 609
               Right = 490
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_10"
            Begin Extent = 
               Top = 558
               Left = 517
               Bottom = 619
               Right = 687
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_11"
            Begin Extent = 
               Top = 609
               Left = 305
               Bottom = 670
               Right = 491
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_11"
            Begin Extent = 
               Top = 612
               Left = 530
               Bottom = 673
               Right = 700
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 248
               Left = 17
               Bottom = 409
               Right = 211
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NPT"
            Begin Extent = 
               Top = 7
               Left = 990
               Bottom = 168
               Right = 1184
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
      Begin ColumnWidths = 27
         Width = 284
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
         Column = 2436
         Alias = 2460
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 2712
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'WeldingParameters';




GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 3, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'WeldingParameters';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'= 695
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_3"
            Begin Extent = 
               Top = 155
               Left = 305
               Bottom = 216
               Right = 491
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_3"
            Begin Extent = 
               Top = 156
               Left = 527
               Bottom = 217
               Right = 697
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_4"
            Begin Extent = 
               Top = 212
               Left = 307
               Bottom = 273
               Right = 493
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_4"
            Begin Extent = 
               Top = 218
               Left = 526
               Bottom = 279
               Right = 696
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_5"
            Begin Extent = 
               Top = 268
               Left = 304
               Bottom = 329
               Right = 490
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_5"
            Begin Extent = 
               Top = 276
               Left = 529
               Bottom = 337
               Right = 699
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_6"
            Begin Extent = 
               Top = 329
               Left = 303
               Bottom = 390
               Right = 489
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_6"
            Begin Extent = 
               Top = 332
               Left = 527
               Bottom = 393
               Right = 697
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_7"
            Begin Extent = 
               Top = 390
               Left = 304
               Bottom = 451
               Right = 490
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_7"
            Begin Extent = 
               Top = 385
               Left = 525
               Bottom = 446
               Right = 695
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_8"
            Begin Extent = 
               Top = 454
               Left = 306
               Bottom = 515
               Right = 492
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_8"
            Begin Extent = 
               Top = 443
               Left = 526
               Bottom = 504
               Right = 696
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_9"
            Begin Extent = 
               Top = 506
               Left = 306
               Bottom = 567
               Right = 492
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_9"
            Begin Extent = 
               T', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'WeldingParameters';




GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[52] 4[21] 2[11] 3) )"
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
         Begin Table = "Spot"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 319
               Right = 237
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters"
            Begin Extent = 
               Top = 0
               Left = 311
               Bottom = 61
               Right = 497
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName"
            Begin Extent = 
               Top = 2
               Left = 530
               Bottom = 63
               Right = 700
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_1"
            Begin Extent = 
               Top = 60
               Left = 306
               Bottom = 121
               Right = 492
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_1"
            Begin Extent = 
               Top = 64
               Left = 528
               Bottom = 125
               Right = 698
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_2"
            Begin Extent = 
               Top = 115
               Left = 304
               Bottom = 176
               Right = 490
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_2"
            Begin Extent = 
               Top = 119
               Left = 525
               Bottom = 180
               Right ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'WeldingParameters';



