
CREATE VIEW [STO].[Breakdown]
AS
SELECT 
 isnull(A.location,x.[SOURCE] +'#') as 'location'
,A.CLassificationId as 'AssetID'
,'STO'  as 'Logtype'
,CAST(x.TIMESTAMP as datetime) as 'timestamp'
,SUBSTRING( x.[Object],CHARINDEX('.',  x.[Object])+1,LEN(x.[Object])) as 'Logcode'
,x.SEVERITY as 'Severity'
,'<'
+isnull(SUBSTRING( x.[Object],0,CHARINDEX('.',  x.[Object])),'NA')  
+ '> <'
+isnull(x.comment,'NA')
+'>'			 as 'logtext'
,null as 'Response'
,DATEDIFF(second, CAST(x.timestamp as datetime), x.EndOfError) as 'Downtime'
, RTRIM(ISNULL(null,'Undefined*'))  AS 'Classification'
, ISNULL(null,'Undefined*')		 AS 'Subgroup'
, null AS 'Category'
, null	 AS 'refId'
, a.LocationTree     As 'LocationTree'
, a.ClassificationTree as 'ClassTree'
, x.[SOURCE]		AS 'controller_name'
, 'STO'		As 'controller_type'

FROM (
SELECT 
 rt.*
 ,Lead(rt.STATUS) OVER (PARTITION BY rt.Object ORDER BY CAST(rt.timestamp as datetime)) as 'LeadStatus'
 ,Lead(CAST(rt.timestamp as datetime)) OVER (PARTITION BY rt.Object ORDER BY CAST(rt.timestamp as datetime)) as 'EndOfError'
FROM GADATA.STO.rt_breakdown as rt
)  X
--Join the asset from maximo 
LEFT JOIN GADATA.EQUI.ASSETS as A on 
SUBSTRING( x.[Object],0,CHARINDEX('.',  x.[Object]) ) LIKE A.LOCATION +'%'
WHERE 
X.STATUS = 1 --use tag where breakdown started
AND 
(X.LEADSTATUS = 0 OR X.LEADSTATUS is null) --use tag where breakdown finshed OR breakdown still bussy 
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'STO', @level1type = N'VIEW', @level1name = N'Breakdown';


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
', @level0type = N'SCHEMA', @level0name = N'STO', @level1type = N'VIEW', @level1name = N'Breakdown';

