

/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [NGAC].[TipsNotchanged]
AS
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT c.[controller_name]
	  ,c.LocationTree
	  ,t.Vweek
	  ,t.Vday
	  ,t.PLOEG
	  ,geo.Asset_png
	  ,geo.Asset_x
	  ,geo.Asset_y
	  ,[TipchangeTimestamp]
      ,[tipDressID]
      ,[WearBeforeChange]
	  ,[DressBeforeChange]
      ,[TipAge(h)]
      ,[DeltaNom]
      ,[DeltaNomBeforeChange]
	  ,ROUND(ABS([DeltaNomBeforeChange] - [DeltaNom]),2) as 'AbsDeltaChange'
  FROM [GADATA].[NGAC].[TipwearBeforeChange]
  LEFT JOIN GADATA.NGAC.c_controller as c on c.id = TipwearBeforeChange.[controller_id]
  LEFT JOIN GADATA.EqUi.GeoAssets as geo on geo.LOCATION = c.controller_name and geo.controller_ToolID = 1
  LEFT JOIN GADATA.Volvo.L_timeline as t on [TipwearBeforeChange].TipchangeTimestamp between t.starttime and t.endtime
  WHERE ABS([DeltaNomBeforeChange] - [DeltaNom]) < 0.1 --tip must have grown at least 0.1 mm 
  AND [DressBeforeChange] > 25 --tip must have at least dressed X times. (else someone might be playing)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'TipsNotchanged';


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
         Begin Table = "TipwearBeforeChange (NGAC)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 291
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 329
               Bottom = 135
               Right = 511
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "geo"
            Begin Extent = 
               Top = 6
               Left = 549
               Bottom = 135
               Right = 731
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t"
            Begin Extent = 
               Top = 6
               Left = 769
               Bottom = 135
               Right = 939
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
', @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'TipsNotchanged';

