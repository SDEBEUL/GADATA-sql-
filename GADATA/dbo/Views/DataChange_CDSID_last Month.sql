CREATE VIEW dbo.[DataChange_CDSID_last Month]
AS
SELECT        TOP (100) PERCENT dbo.NPT.Name, dbo.Timer.Name AS Timer, dbo.SpotDataChange.DateTime, dbo.Spot.Number AS Spot, dbo.Spot.Program, 
                         dbo.TimerParameterName.Name AS parameter, dbo.TimerParameterName.Description AS Parameter_Description, dbo.SpotDataChange.OldValue, 
                         dbo.SpotDataChange.NewValue, dbo.Users.CDSID, dbo.Users.Voornaam, dbo.Users.Achternaam
FROM            dbo.SpotDataChange INNER JOIN
                         dbo.Spot ON dbo.SpotDataChange.SpotID = dbo.Spot.ID INNER JOIN
                         dbo.Timer ON dbo.Spot.TimerID = dbo.Timer.ID INNER JOIN
                         dbo.NPT ON dbo.Timer.NptId = dbo.NPT.ID INNER JOIN
                         dbo.Users ON dbo.SpotDataChange.UserID = dbo.Users.ID INNER JOIN
                         dbo.TimerParameterName ON dbo.SpotDataChange.ParameterID = dbo.TimerParameterName.ID
WHERE        (dbo.SpotDataChange.DateTime >= GETDATE() - 7)
ORDER BY dbo.NPT.Name, Timer, dbo.SpotDataChange.DateTime
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'DataChange_CDSID_last Month';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'        Width = 2760
         Width = 1335
         Width = 1185
         Width = 2205
         Width = 3195
         Width = 1185
         Width = 1125
         Width = 1500
         Width = 1245
         Width = 2340
         Width = 900
         Width = 1110
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
         Column = 2940
         Alias = 2040
         Table = 2265
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2655
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'DataChange_CDSID_last Month';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[43] 4[15] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
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
         Begin Table = "SpotDataChange"
            Begin Extent = 
               Top = 0
               Left = 36
               Bottom = 180
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Spot"
            Begin Extent = 
               Top = 182
               Left = 97
               Bottom = 332
               Right = 296
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "Timer"
            Begin Extent = 
               Top = 207
               Left = 351
               Bottom = 336
               Right = 521
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "NPT"
            Begin Extent = 
               Top = 207
               Left = 716
               Bottom = 336
               Right = 886
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 71
               Left = 554
               Bottom = 200
               Right = 724
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimerParameterName"
            Begin Extent = 
               Top = 0
               Left = 303
               Bottom = 135
               Right = 473
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
      Begin ColumnWidths = 21
         Width = 284
         Width = 1335
         Width = 1545
 ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'DataChange_CDSID_last Month';

