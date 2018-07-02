









CREATE VIEW [Tableau].[Last100d_Breakdown]
AS

--c3g
SELECT 
 x.logtype
,x.timestamp
,x.logcode
,x.severity
,x.logtext
,x.logtext as 'fulllogtext'
,x.[Response(s)]
,x.[Downtime(s)]
,x.classification
,x.subgroup
,'C3G_' + x.Subgroup as 'Category'
,x.refid
,x.locationtree
,A.[LOCATION]
,A.[station]
,A.[Area]
,A.[Team]
,A.[Asset_x]
,A.[Asset_y]
,A.[Asset_png]
,A.[Station_x]
,A.[Station_y]
,A.[Station_png]
,t.Vyear
,t.Vweek
,t.Vday
,t.PLOEG
,t.shift
FROM 
(
SELECT * 
FROM [GADATA].C3G.Breakdown as b
WHERE b.Subgroup not in('EO Maint','Operational**','Operational')
AND b.timestamp between GETDATE()-100 and GETDATE()
)as x 
LEFT OUTER JOIN gadata.equi.GeoASSETS as A on a.LOCATION = x.Location and A.controller_ToolID = 1
LEFT OUTER JOIN GADATA.volvo.L_timeline as t on x.[timestamp] between t.starttime and t.endtime
WHERE A.Asset_png is not null

--c4g
UNION
SELECT 
 x.logtype
,x.timestamp
,x.logcode
,x.severity
,x.logtext
,x.logtext as 'fulllogtext'
,x.[Response(s)]
,x.[Downtime(s)]
,x.classification
,x.subgroup
,'C4G_' + x.Subgroup as 'Category'
,x.refid
,x.locationtree
,A.[LOCATION]
,A.[station]
,A.[Area]
,A.[Team]
,A.[Asset_x]
,A.[Asset_y]
,A.[Asset_png]
,A.[Station_x]
,A.[Station_y]
,A.[Station_png]
,t.Vyear
,t.Vweek
,t.Vday
,t.PLOEG
,t.shift
FROM 
(
SELECT * 
FROM [GADATA].C4G.Breakdown as b
WHERE b.Subgroup not in('EO Maint','Operational**','Operational')
AND b.timestamp between GETDATE()-100 and GETDATE()
)as x 
LEFT OUTER JOIN gadata.equi.GeoASSETS as A on a.LOCATION = x.Location and A.controller_ToolID = 1
LEFT OUTER JOIN GADATA.volvo.L_timeline as t on x.[timestamp] between t.starttime and t.endtime
WHERE A.Asset_png is not null


--NGAC
UNION
SELECT 
 x.logtype
,x.timestamp
,x.logcode
,x.severity
,x.logtext
,x.fulllogtext
,x.response
,x.downtime
,x.classification
,x.subgroup
,'NGAC_' + ISNULL(x.Category,'undefined') as 'Category'
,x.refid
,x.locationtree
,A.[LOCATION]
,A.[station]
,A.[Area]
,A.[Team]
,A.[Asset_x]
,A.[Asset_y]
,A.[Asset_png]
,A.[Station_x]
,A.[Station_y]
,A.[Station_png]
,t.Vyear
,t.Vweek
,t.Vday
,t.PLOEG
,t.shift
FROM 
(
SELECT * 
FROM [GADATA].NGAC.Breakdown as b
WHERE b.Subgroup not in('EO Maint','Operational**','Operational')
AND b.timestamp between GETDATE()-100 and GETDATE()
)as x 
LEFT OUTER JOIN gadata.equi.GeoASSETS as A on a.LOCATION = x.Location and A.controller_ToolID = 1
LEFT OUTER JOIN GADATA.volvo.L_timeline as t on x.[timestamp] between t.starttime and t.endtime
WHERE A.Asset_png is not null
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'Tableau', @level1type = N'VIEW', @level1name = N'Last100d_Breakdown';


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
', @level0type = N'SCHEMA', @level0name = N'Tableau', @level1type = N'VIEW', @level1name = N'Last100d_Breakdown';

