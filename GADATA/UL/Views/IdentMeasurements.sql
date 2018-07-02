CREATE VIEW UL.IdentMeasurements
AS
SELECT timestamp, SpotID
FROM     UL.IdentsNPT22
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT23
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT24
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT26
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT27
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT28
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT29
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT30
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT31
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT32

UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT33
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT40
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT41
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT43
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT50
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT51
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT52

UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT53
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT54
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT55
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT56
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT57
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT58
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT59
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT70
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT71
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT72
UNION
SELECT timestamp, SpotID
FROM     UL.IdentsNPT73
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'UL', @level1type = N'VIEW', @level1name = N'IdentMeasurements';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[20] 4[41] 2[20] 3) )"
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
         Begin Table = "IdentsNPT22 (UL)"
            Begin Extent = 
               Top = 27
               Left = 41
               Bottom = 144
               Right = 235
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
', @level0type = N'SCHEMA', @level0name = N'UL', @level1type = N'VIEW', @level1name = N'IdentMeasurements';

