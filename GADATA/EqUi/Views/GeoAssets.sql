







CREATE VIEW [EqUi].[GeoAssets]
AS
SELECT 
A.*
,ISNULL(ISNULL(assetlevelXY.X_pos, assetlevelXY2.X_pos),assetlevelXY3.X_pos) as  'Asset_x'  
,ISNULL(ISNULL(assetlevelXY.Y_pos, assetlevelXY2.Y_pos),assetlevelXY3.Y_pos) as 'Asset_y'
,ISNULL(ISNULL(assetlevelXY.png,assetlevelXY2.PNG),assetlevelXY3.PNG)  as 'Asset_png'
,stationlevelXY.X_pos as 'Station_x'
,stationlevelXY.Y_pos as 'Station_y'
,stationlevelXY.png as 'Station_png'
FROM     EqUi.Assets as A 
--join asset level 
LEFT OUTER JOIN EqUi.Assets_XY as assetlevelXY ON assetlevelXY.location = A.LOCATION
--Asset that are null and have a know controller can join the controller 
LEFT OUTER JOIN Equi.Assets_XY assetlevelXY2 on assetlevelXY2.location = A.controller_name
--Asset that are still null plot them on the station
LEFT OUTER JOIN Equi.Assets_XY assetlevelXY3 on assetlevelXY3.location = A.Station 
--join station level
LEFT OUTER JOIN EqUi.Assets_XY as stationlevelXY ON stationlevelXY.location = A.station
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'EqUi', @level1type = N'VIEW', @level1name = N'GeoAssets';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "ASSETS (EqUi)"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 168
               Right = 259
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Assets_XY (EqUi)"
            Begin Extent = 
               Top = 7
               Left = 307
               Bottom = 146
               Right = 501
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
', @level0type = N'SCHEMA', @level0name = N'EqUi', @level1type = N'VIEW', @level1name = N'GeoAssets';

