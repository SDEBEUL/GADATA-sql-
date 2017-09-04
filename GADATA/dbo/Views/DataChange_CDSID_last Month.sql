CREATE VIEW dbo.[DataChange_CDSID_last Month]
AS
SELECT dbo.NPT.Name AS NPT, dbo.Timer.Name AS Timer, dbo.Spot.Number, dbo.Spot.Program AS 'program/electrodeNr.', dbo.SpotDataChange.DateTime, 
                  dbo.TimerParameterName.Description AS parameter, dbo.SpotDataChange.OldValue, dbo.SpotDataChange.NewValue, dbo.Users.CDSID
FROM     dbo.NPT INNER JOIN
                  dbo.Timer ON dbo.NPT.ID = dbo.Timer.NptId INNER JOIN
                  dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                  dbo.SpotDataChange ON dbo.Spot.ID = dbo.SpotDataChange.SpotID INNER JOIN
                  dbo.TimerParameterName ON dbo.SpotDataChange.ParameterID = dbo.TimerParameterName.ID INNER JOIN
                  dbo.Users ON dbo.SpotDataChange.UserID = dbo.Users.ID
WHERE  (dbo.SpotDataChange.DateTime >= GETDATE() - 7) AND (dbo.Users.CDSID <> 'jvancau1') AND (dbo.Users.CDSID <> 'jcoppej1') AND (dbo.Users.CDSID <> 'tleemans') AND 
                  (dbo.Users.CDSID <> 'gcoppiet') AND (dbo.Users.CDSID <> 'tnotebae') AND (dbo.Users.CDSID <> 'DREYNIE1') AND (dbo.Users.CDSID <> 'BDEVUYS2') AND 
                  (dbo.Users.CDSID <> 'DSTEENBE') AND (dbo.Users.CDSID <> 'WARNDINOI') AND (dbo.Users.CDSID <> 'HBEYERS') AND (dbo.Users.CDSID <> 'SVANDENE') AND 
                  (dbo.Users.CDSID <> 'LVANEETV') AND (dbo.Users.CDSID <> 'BRASEMO1') AND (dbo.Users.CDSID <> 'JVANDE37')
UNION
SELECT dbo.NPT.Name, dbo.Timer.Name AS Expr1, dbo.Spot.Program, NULL AS number, dbo.TimerDataChange.DateTime, dbo.TimerParameterName.Description, 
                  dbo.TimerDataChange.OldValue, dbo.TimerDataChange.NewValue, dbo.Users.CDSID
FROM     dbo.NPT INNER JOIN
                  dbo.Timer ON dbo.NPT.ID = dbo.Timer.NptId INNER JOIN
                  dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                  dbo.TimerDataChange ON dbo.Timer.ID = dbo.TimerDataChange.TimerID INNER JOIN
                  dbo.TimerParameterName ON dbo.TimerDataChange.ParameterID = dbo.TimerParameterName.ID INNER JOIN
                  dbo.Users ON dbo.TimerDataChange.UserID = dbo.Users.ID
WHERE   
 (dbo.Users.CDSID <> 'jvancau1') AND(dbo.TimerDataChange.DateTime >= GETDATE() - 31)  AND
 (dbo.Users.CDSID <> 'jcoppej1') AND (dbo.TimerDataChange.DateTime >= GETDATE() - 31) AND
 (dbo.Users.CDSID <> 'tleemans') AND (dbo.TimerDataChange.DateTime >= GETDATE() - 31) AND
 (dbo.Users.CDSID <> 'gcoppiet') AND (dbo.TimerDataChange.DateTime >= GETDATE() - 31) AND
 (dbo.Users.CDSID <> 'tnotebae') AND (dbo.TimerDataChange.DateTime >= GETDATE() - 31) AND
 (dbo.Users.CDSID <> 'DREYNIE1') AND (dbo.TimerDataChange.DateTime >= GETDATE() - 31) AND
 (dbo.Users.CDSID <> 'DSTEENBE') AND (dbo.TimerDataChange.DateTime >= GETDATE() - 31) AND
 (dbo.Users.CDSID <> 'WARNDINOI') AND (dbo.TimerDataChange.DateTime >= GETDATE() - 31) AND
 (dbo.Users.CDSID <> 'HBEYERS') AND (dbo.TimerDataChange.DateTime >= GETDATE() - 31)  AND
 (dbo.Users.CDSID <> 'SVANDENE') AND (dbo.TimerDataChange.DateTime >= GETDATE() - 31) AND
 (dbo.Users.CDSID <> 'LVANEETV') AND (dbo.TimerDataChange.DateTime >= GETDATE() - 31) AND
 (dbo.Users.CDSID <> 'BRASEMO1') AND  (dbo.TimerDataChange.DateTime >= GETDATE() - 31)AND
 (dbo.Users.CDSID <> 'JVANDE37') AND (dbo.TimerDataChange.DateTime >= GETDATE() - 31)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'DataChange_CDSID_last Month';




GO



GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[15] 4[17] 2[26] 3) )"
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
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 21
         Width = 284
         Width = 1332
         Width = 1548
         Width = 1656
         Width = 2052
         Width = 2616
         Width = 1368
         Width = 1212
         Width = 1188
         Width = 1128
         Width = 1500
         Width = 1248
         Width = 2340
         Width = 900
         Width = 1116
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
         Table = 2268
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 2652
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'DataChange_CDSID_last Month';



