CREATE VIEW LAUNCH.[Parameters]
AS
SELECT DISTINCT 
                         GETDATE() AS Date, dbo.Spot.Number, dbo.Spot.Program, dbo.WeldParameters.Value AS Pressure, WeldParameters_1.Value AS Squeeze, 
                         WeldParameters_2.Value AS KA_1, WeldParameters_3.Value AS WELD1, WeldParameters_6.Value AS COOL_1, WeldParameters_4.Value AS KA_2, 
                         WeldParameters_5.Value AS WELD2, WeldParameters_7.Value AS COOL_2, WeldParameters_8.Value AS KA_3, WeldParameters_9.Value AS WELD3, 
                         WeldParameters_10.Value AS HOLD, WeldParameters_11.Value AS [PRprofile ON ?]
FROM            dbo.Spot INNER JOIN
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
                         dbo.TimerParameterName AS TimerParameterName_11 ON WeldParameters_11.ParameterNameID = TimerParameterName_11.ID
WHERE        (dbo.TimerParameterName.Description LIKE N'Base pressu%') AND (TimerParameterName_1.Description LIKE N'Squeeze%') AND 
                         (TimerParameterName_2.Description LIKE N'1. HEA%') AND (TimerParameterName_3.Description LIKE N'1. Weld%') AND 
                         (TimerParameterName_4.Description LIKE N'2. Hea%') AND (TimerParameterName_5.Description LIKE N'2. Weld%') AND 
                         (TimerParameterName_6.Description LIKE N'1. Cool%') AND (TimerParameterName_7.Description LIKE N'2. COOL%') AND 
                         (TimerParameterName_8.Description LIKE N'3. Hea%') AND (TimerParameterName_9.Description LIKE N'3. Weld%') AND 
                         (TimerParameterName_10.Description LIKE N'HOLD%') AND (TimerParameterName_11.Description LIKE N'PRESSURE PRO%') AND (dbo.Spot.Number BETWEEN 
                         30000 AND 49999)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane3', @value = N'             Left = 11
               Bottom = 277
               Right = 181
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_10"
            Begin Extent = 
               Top = 185
               Left = 212
               Bottom = 246
               Right = 398
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_10"
            Begin Extent = 
               Top = 200
               Left = 0
               Bottom = 261
               Right = 170
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_11"
            Begin Extent = 
               Top = 230
               Left = 208
               Bottom = 291
               Right = 394
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_11"
            Begin Extent = 
               Top = 249
               Left = 11
               Bottom = 310
               Right = 181
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
      Begin ColumnWidths = 17
         Width = 284
         Width = 2220
         Width = 1500
         Width = 1500
         Width = 1065
         Width = 795
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
         Filter = 4035
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'Parameters';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 3, @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'Parameters';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' 187
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_3"
            Begin Extent = 
               Top = 86
               Left = 208
               Bottom = 169
               Right = 394
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_3"
            Begin Extent = 
               Top = 87
               Left = 14
               Bottom = 167
               Right = 184
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_4"
            Begin Extent = 
               Top = 114
               Left = 200
               Bottom = 175
               Right = 386
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_4"
            Begin Extent = 
               Top = 113
               Left = 11
               Bottom = 174
               Right = 181
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_5"
            Begin Extent = 
               Top = 122
               Left = 209
               Bottom = 183
               Right = 395
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_5"
            Begin Extent = 
               Top = 142
               Left = 11
               Bottom = 203
               Right = 181
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_6"
            Begin Extent = 
               Top = 164
               Left = 210
               Bottom = 225
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "TimerParameterName_6"
            Begin Extent = 
               Top = 166
               Left = 1
               Bottom = 227
               Right = 171
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_7"
            Begin Extent = 
               Top = 170
               Left = 199
               Bottom = 231
               Right = 385
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "TimerParameterName_7"
            Begin Extent = 
               Top = 188
               Left = 2
               Bottom = 249
               Right = 172
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_8"
            Begin Extent = 
               Top = 194
               Left = 208
               Bottom = 255
               Right = 394
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_8"
            Begin Extent = 
               Top = 204
               Left = 7
               Bottom = 265
               Right = 177
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_9"
            Begin Extent = 
               Top = 203
               Left = 204
               Bottom = 264
               Right = 390
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_9"
            Begin Extent = 
               Top = 216
  ', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'Parameters';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[37] 4[16] 2[19] 3) )"
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
               Top = 17
               Left = 651
               Bottom = 255
               Right = 850
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName"
            Begin Extent = 
               Top = 0
               Left = 24
               Bottom = 135
               Right = 194
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters"
            Begin Extent = 
               Top = 0
               Left = 207
               Bottom = 133
               Right = 393
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_1"
            Begin Extent = 
               Top = 31
               Left = 209
               Bottom = 160
               Right = 395
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_1"
            Begin Extent = 
               Top = 30
               Left = 22
               Bottom = 159
               Right = 192
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_2"
            Begin Extent = 
               Top = 61
               Left = 208
               Bottom = 176
               Right = 394
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_2"
            Begin Extent = 
               Top = 57
               Left = 17
               Bottom = 163
               Right =', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'Parameters';

