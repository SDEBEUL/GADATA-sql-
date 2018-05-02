CREATE VIEW WELDING.[20%tolerantiebanden]
AS
SELECT        TOP (100) PERCENT t1.NPT, t1.timer, t2.[count of 20% tol spots], t1.[count of weldspots], t1.CDSID
FROM            (SELECT        dbo.NPT.Name AS NPT, dbo.Timer.Name AS timer, COUNT(dbo.Spot.Number) AS [count of weldspots], dbo.Users.CDSID
                          FROM            dbo.Timer INNER JOIN
                                                    dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                                                    dbo.NPT ON dbo.Timer.NptId = dbo.NPT.ID INNER JOIN
                                                    dbo.Users ON dbo.NPT.OwnerId = dbo.Users.ID
                          WHERE        (dbo.Spot.Number BETWEEN 30000 AND 49999) OR
                                                    (dbo.Spot.Number BETWEEN 4400000 AND 4419999)
                          GROUP BY dbo.Timer.Name, dbo.NPT.Name, dbo.Users.CDSID) AS t1 LEFT OUTER JOIN
                             (SELECT        Timer_1.Name AS timer, COUNT(dbo.WeldParameters.Value) AS [count of 20% tol spots]
                               FROM            dbo.Spot AS Spot_1 INNER JOIN
                                                         dbo.WeldParameters ON Spot_1.ID = dbo.WeldParameters.SpotID INNER JOIN
                                                         dbo.Timer AS Timer_1 ON Spot_1.TimerID = Timer_1.ID
                               WHERE        (dbo.WeldParameters.ParameterNameID = 55) AND (dbo.WeldParameters.Value = 20) AND (Spot_1.Number BETWEEN 30000 AND 49999) OR
                                                         (dbo.WeldParameters.ParameterNameID = 55) AND (dbo.WeldParameters.Value = 20) AND (Spot_1.Number BETWEEN 4400000 AND 4419999)
                               GROUP BY Timer_1.Name) AS t2 ON t1.timer = t2.timer
WHERE        (t1.timer <> 'dummy')
ORDER BY t2.[count of 20% tol spots]
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'20%tolerantiebanden';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[27] 4[26] 2[27] 3) )"
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
         Begin Table = "t1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 244
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t2"
            Begin Extent = 
               Top = 6
               Left = 282
               Bottom = 101
               Right = 505
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 3330
         Width = 3600
         Width = 1560
         Width = 3600
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1695
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2880
         Or = 3285
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'20%tolerantiebanden';

