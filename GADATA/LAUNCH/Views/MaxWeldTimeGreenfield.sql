CREATE VIEW LAUNCH.MaxWeldTimeGreenfield
AS
SELECT        dbo.NPT.Name AS NPT, dbo.Timer.Name AS Timer, dbo.Spot.Number AS Spot, dbo.Spot.Program, dbo.WeldParameters.Value AS Weldtime1, 
                         WeldParameters_1.Value AS WeldTime2, WeldParameters_2.Value AS WeldTime3
FROM            dbo.NPT INNER JOIN
                         dbo.Timer ON dbo.NPT.ID = dbo.Timer.NptId INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID AND dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         dbo.WeldParameters ON dbo.Spot.ID = dbo.WeldParameters.SpotID INNER JOIN
                         dbo.TimerParameterName ON dbo.WeldParameters.ParameterNameID = dbo.TimerParameterName.ID INNER JOIN
                         dbo.WeldParameters AS WeldParameters_1 ON dbo.Spot.ID = WeldParameters_1.SpotID INNER JOIN
                         dbo.TimerParameterName AS TimerParameterName_1 ON WeldParameters_1.ParameterNameID = TimerParameterName_1.ID INNER JOIN
                         dbo.WeldParameters AS WeldParameters_2 ON dbo.Spot.ID = WeldParameters_2.SpotID INNER JOIN
                         dbo.TimerParameterName AS TimerParameterName_2 ON WeldParameters_2.ParameterNameID = TimerParameterName_2.ID
WHERE        (dbo.Spot.Number BETWEEN 4400000 AND 4419999) AND (dbo.TimerParameterName.Description = N'1. Weld Time') AND 
                         (TimerParameterName_1.Description = N'2. Weld Time') AND (TimerParameterName_2.Description = N'3. Weld Time')
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[54] 4[17] 2[9] 3) )"
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
               Bottom = 169
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 151
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 253
               Right = 653
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters"
            Begin Extent = 
               Top = 0
               Left = 1055
               Bottom = 95
               Right = 1241
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName"
            Begin Extent = 
               Top = 0
               Left = 1254
               Bottom = 95
               Right = 1424
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_1"
            Begin Extent = 
               Top = 93
               Left = 1053
               Bottom = 193
               Right = 1239
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_1"
            Begin Extent = 
               Top = 95
               Left = 1256
               Bottom = 192
               Right = 1426
            End
 ', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'MaxWeldTimeGreenfield';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'MaxWeldTimeGreenfield';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'           DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WeldParameters_2"
            Begin Extent = 
               Top = 187
               Left = 1055
               Bottom = 291
               Right = 1241
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName_2"
            Begin Extent = 
               Top = 187
               Left = 1253
               Bottom = 288
               Right = 1423
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2400
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
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'MaxWeldTimeGreenfield';

