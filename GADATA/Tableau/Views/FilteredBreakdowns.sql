


/********************************************************************************************************--
output
*******************************************************************************************************--
limits the query up to 1 year of data*/
CREATE VIEW [Tableau].[FilteredBreakdowns]
AS
--*******************************************************************************************************--
--output
--*******************************************************************************************************--
SELECT 
x.*
, T.Vyear AS 'Year'
,datepart(QUARTER,x.[timestamp]) as 'QUARTER'
,datepart(MONTH,x.[timestamp]) as 'MONTH'
, T.Vweek AS 'Week'
, T.Vday AS 'day'
, T.ploeg AS 'Ploeg'
FROM(
--*******************************************************************************************************--
--c3g breakdown
--*******************************************************************************************************--

SELECT 
 A.LOCATION	
,A.CLassificationId   AS 'AssetID'
,'BREAKDOWN'		   AS 'Logtype'
, H.EndOfBreakdown     AS 'timestamp'
, L.[error_number]      AS 'Logcode'
, L.[error_severity]			AS 'Severity'
, L.error_text AS 'logtext'
, DATEDIFF(second,'1900-01-01 00:00:00', H.Rt)		AS 'Response(s)' 
, DATEDIFF(SECOND,(H.StartOfBreakdown +  H.Rt),H.EndOfBreakdown) as 'Reolvetime(s)'
, DATEDIFF(second, H.StartOfBreakdown, H.EndOfBreakdown)AS 'Downtime(s)'
, RTRIM(ISNULL(cc.Classification,'Undefined*'))  AS 'Classification'
, ISNULL(cs.Subgroup,'Undefined*')  AS 'Subgroup'
, H.id				 AS 'refId'
, 'c3g'		As 'controller_type'
,A.[station]
,A.[Area]
,A.[Team]
,A.[Asset_x]
,A.[Asset_y]
,A.[Asset_png]
,A.[Station_x]
,A.[Station_y]
,A.[Station_png]

FROM  C3G.h_breakdown AS H 
LEFT OUTER JOIN C3G.L_error AS L ON L.id = H.error_id 
LEFT OUTER JOIN VOLVO.c_Classification as cc on cc.id = L.c_ClassificationId
LEFT OUTER JOIN VOLVO.c_Subgroup as cs on cs.id = L.c_SubgroupId
--joining of the RIGHT ASSET
LEFT OUTER JOIN equi.GeoASSETS as A on 
A.controller_type = 'c3g' --join the right 'data controller type'
AND
A.controller_id = h.controller_id --join the right 'data controller id'
AND 
A.CLassificationId LIKE '%' + RTRIM(ISNULL(cc.Classification,'UR')) + '%' --join only the asset with the right classification. (if not classified data goes to robot)
AND
A.controller_ToolID = 1 --temp until we find a multi tool support sollution
--*******************************************************************************************************--
WHERE 
cs.Subgroup not in ('EO Maint','Operational**','Operational','Undefined*')
AND
A.LOCATION is not null
--*******************************************************************************************************--

UNION
--*******************************************************************************************************--
--c4g breakdown
--*******************************************************************************************************--
SELECT 
 A.LOCATION	   
,A.CLassificationId   AS 'AssetID'
,'BREAKDOWN'		   AS 'Logtype'
, H.EndOfBreakdown     AS 'timestamp'
, L.[error_number]      AS 'Logcode'
, L.[error_severity]			AS 'Severity'
, L.error_text 		AS 'logtext'
, DATEDIFF(second,'1900-01-01 00:00:00', H.Rt) 	AS 'Response(s)' 
, DATEDIFF(SECOND,(H.StartOfBreakdown +  H.Rt),H.EndOfBreakdown) as 'Reolvetime(s)'
, DATEDIFF(second, H.StartOfBreakdown, H.EndOfBreakdown)AS 'Downtime(s)'
, RTRIM(ISNULL(cc.Classification,'Undefined*'))  AS 'Classification'
, ISNULL(cs.Subgroup,'Undefined*')					   AS 'Subgroup'
, H.id				 AS 'refId'
, 'c4g'		As 'controller_type'
,A.[station]
,A.[Area]
,A.[Team]
,A.[Asset_x]
,A.[Asset_y]
,A.[Asset_png]
,A.[Station_x]
,A.[Station_y]
,A.[Station_png]


FROM  C4G.h_breakdown AS H 
LEFT OUTER JOIN C4G.L_error AS L ON L.id = H.error_id 
LEFT OUTER JOIN VOLVO.c_Classification as cc on cc.id = L.c_ClassificationId
LEFT OUTER JOIN VOLVO.c_Subgroup as cs on cs.id = L.c_SubgroupId
--joining of the RIGHT ASSET
LEFT OUTER JOIN equi.GeoASSETS as A on 
A.controller_type = 'c4g' --join the right 'data controller type'
AND
A.controller_id = h.controller_id --join the right 'data controller id'
AND 
A.CLassificationId LIKE '%' + RTRIM(ISNULL(cc.Classification,'UR')) + '%' --join only the asset with the right classification. (if not classified data goes to robot)
AND
A.controller_ToolID = 1 --temp until we find a multi tool support sollution
--*******************************************************************************************************--
--*******************************************************************************************************--
WHERE 
cs.Subgroup not in ('EO Maint','Operational**','Operational','Undefined*')
AND 
A.LOCATION is not null
--*******************************************************************************************************--
) as X 
LEFT JOIN GADATA.Volvo.L_timeline as T on X.[timestamp] BETWEEN T.starttime AND T.endtime
WHERE 
T.[shift] <> 4 --geen WE
AND
X.[Downtime(s)] BETWEEN 1 AND (60*60*5) --a breakdown must be between 1 second and 5 hours
AND 
X.[Timestamp] > GETDATE()-365 --limits the query up to 1 year of data
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'Tableau', @level1type = N'VIEW', @level1name = N'FilteredBreakdowns';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[30] 4[31] 2[20] 3) )"
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
', @level0type = N'SCHEMA', @level0name = N'Tableau', @level1type = N'VIEW', @level1name = N'FilteredBreakdowns';

