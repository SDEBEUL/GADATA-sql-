CREATE VIEW LAUNCH.optimalisationsV316
AS
SELECT
 [Date] , [Name] AS Timer, dbo.spot.Number, dbo.spot.Program, CONVERT(DECIMAL(5, 1), 100 * CAST(dbo.WeldMeasurements.NbrSplash AS decimal(10, 5)) 
                         / CAST(dbo.WeldMeasurements.NbrWeld AS decimal(10, 5))) AS Spatters, CONVERT(DECIMAL(5, 1), 100 * CAST(dbo.WeldMeasurements.NbrReweld AS decimal(10, 5)) 
                         / CAST(dbo.WeldMeasurements.NbrWeld AS decimal(10, 5))) AS PsfReweld, [NbrWeld],[AvgEnergy],[AvgPSF],[StdPSF] ,[AvgWeldTIme],
 Null As UltralogTime ,Null As [Losse spot?],Null As [OK spot?],Null As [SmallNugget?],Null As [StickWeld?],Null As [BadTroughWeld?],
 Null As [MeasuredThickness] , Null As [TotalThickness], Null as [InspectorComment], null as bodynummer, null as ParameterChange, null as before, null as after, null as CDSID,null as NPT
 FROM [GADATA].[dbo].[WeldMeasurements] INNER JOIN dbo.Spot ON dbo.WeldMeasurements.SpotId = dbo.spot.id 
 INNER JOIN [GADATA].[dbo].[Timer] ON [GADATA].[dbo].[Spot].TimerID = [GADATA].[dbo].[Timer].ID 
 WHERE [Date] >= GETDATE()-31  AND dbo.spot.Program BETWEEN '100' AND '200'  AND  Number LIKE '3%' OR  Number LIKE '4%'


 UNION

 SELECT
  [InspectionTime],null as Name, dbo.spot.Number, dbo.spot.Program,null AS [Loose],Null As [OK],Null As [SmallNugget],Null As [StickWeld] ,Null As [BadTroughWeld],Null As [MeasuredThickness] ,Null As [TotalThickness]
 ,[InspectionTime],[Loose],[OK],[SmallNugget],[StickWeld] ,[BadTroughWeld],[MeasuredThickness] ,[TotalThickness], [InspectorComment], [BodyNbr],null as spot,null as spot, null as ParameterChange, null as before, null as NPT
  FROM [GADATA].[dbo].[UltralogInspections] INNER JOIN dbo.spot ON [GADATA].[dbo].[UltralogInspections].spotID = dbo.spot.id
  WHERE [InspectionTime] >= GETDATE()-31 AND program BETWEEN '100' AND '200' AND  Number LIKE '3%' OR  Number LIKE '4%'


 UNION

 SELECT        dbo.SpotDataChange.DateTime AS Date, dbo.Timer.Name AS TIMER, dbo.Spot.Number, dbo.Spot.Program, null as spot,null as spot,null as spot,null as spot,null as spot,null as spot,null as spot,
  null as spot,null as spot,null as spot,null as spot,null as spot,null as spot, null as spot,null as spot, null as ParameterChange, null as spot,
                         dbo.TimerParameterName.Description, dbo.SpotDataChange.OldValue AS [oude parameter], dbo.SpotDataChange.NewValue AS [nieuwe parameter], 
                         dbo.Users.CDSID, null as NPT
FROM            dbo.Spot INNER JOIN
                         dbo.Timer ON dbo.Spot.TimerID = dbo.Timer.ID AND dbo.Spot.TimerID = dbo.Timer.ID INNER JOIN
                         dbo.NPT ON dbo.Timer.NptId = dbo.NPT.ID INNER JOIN
                         dbo.SpotDataChange ON dbo.Spot.ID = dbo.SpotDataChange.SpotID AND dbo.Spot.ID = dbo.SpotDataChange.SpotID INNER JOIN
                         dbo.TimerParameterName ON dbo.SpotDataChange.ParameterID = dbo.TimerParameterName.ID AND 
                         dbo.SpotDataChange.ParameterID = dbo.TimerParameterName.ID INNER JOIN
                         dbo.Users ON dbo.SpotDataChange.UserID = dbo.Users.ID AND dbo.SpotDataChange.UserID = dbo.Users.ID
WHERE        (dbo.SpotDataChange.DateTime >= GETDATE() - 31) AND Program BETWEEN '100' AND '200' AND   Number LIKE '3%' OR  Number LIKE '4%'

UNION

SELECT         dbo.TimerDataChange.DateTime AS Date, dbo.Timer.Name AS Timer
,null as Spot,null as Spot ,null as Spot ,null as Spot ,null as Spot ,null as Spot ,null as Spot ,null as Spot ,null as Spot ,null as Spot ,null as Spot ,null as Spot ,null as Spot 
,null as Spot ,null as Spot ,null as Spot ,null as Spot ,null as Spot ,null as Spot,

 dbo.TimerParameterName.Description, 
                         dbo.TimerDataChange.OldValue, dbo.TimerDataChange.NewValue, dbo.Users.CDSID, dbo.NPT.Name AS NPT
FROM            dbo.TimerParameterName INNER JOIN
                         dbo.TimerDataChange ON dbo.TimerParameterName.ID = dbo.TimerDataChange.ParameterID INNER JOIN
                         dbo.Users ON dbo.TimerDataChange.UserID = dbo.Users.ID INNER JOIN
                         dbo.Timer ON dbo.TimerDataChange.TimerID = dbo.Timer.ID INNER JOIN
                         dbo.NPT ON dbo.Timer.NptId = dbo.NPT.ID

WHERE       datetime  >= GETDATE()- 31 AND dbo.NPT.Name = 'NPT26' OR datetime  >= GETDATE()- 31 AND dbo.NPT.Name = 'NPT27' OR
datetime  >= GETDATE()- 31 AND dbo.NPT.Name = 'NPT28' OR datetime  >= GETDATE()- 31 AND dbo.NPT.Name = 'NPT29' OR
datetime  >= GETDATE()- 31 AND dbo.NPT.Name = 'NPT30' OR datetime  >= GETDATE()- 31 AND dbo.NPT.Name = 'NPT31' OR
datetime  >= GETDATE()- 31 AND dbo.NPT.Name = 'NPT32' OR datetime  >= GETDATE()- 31 AND dbo.NPT.Name = 'NPT33'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'optimalisationsV316';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[10] 4[18] 2[40] 3) )"
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
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
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
', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'optimalisationsV316';

