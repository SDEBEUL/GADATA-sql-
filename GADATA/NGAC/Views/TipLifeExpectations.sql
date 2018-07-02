





CREATE VIEW [NGAC].[TipLifeExpectations]
AS
SELECT 
  twBc.controller_name
 ,twBc.LocationTree
 ,twBc.Tool_Nr
 ,ROUND(AVG(twBc.ESTnSpotsFixedWearBefore100),0) as 'avgESTnSpotsFixedWearBefore100'
 ,ROUND(AVG(twBC.ESTnSpotsMoveWearBefore100),0) as 'avgESTnSpotsMoveWearBefore100'
 ,ROUND(AVG(twBC.WeldsBeforeChange/twBc.DressBeforeChange),0) as 'avgWeldPerDress'
 ,MAX(nWearComponent.TotWearComponent) as 'TotWearComponent'
 --extra info 
 ,MAX(twBc.[WearBeforeChange]) as 'maxWearInCalc'
 ,MIN(twBc.[WearBeforeChange]) as 'minWearInCalc'
 ,COUNT(twBc.[WearBeforeChange]) as 'countWearInCalc'
 ,MAX(twBc.TipchangeTimestamp) as 'LastTipchange'
 ,MAX(twBc.[%FixedWearBeforeChange]) as 'Last%FixedWearBeforeChange'
 ,MAX(twBc.[%MoveWearBeforeChange]) as 'Last%MovWearBeforeChange'
 ,ROUND(AVG(twbc.[DeltaNom]),2) as 'avgDeltaNomAfterchange'
 ,ROUND(AVG(twBc.ESTnSpotsFixedWearBefore100)/MAX(nWearComponent.TotWearComponent),0) as 'avgPartsFixedBefore100'
 ,ROUND(AVG(twBc.ESTnSpotsMoveWearBefore100)/MAX(nWearComponent.TotWearComponent),0) as 'avgPartsMoveBefore100'
 --refID
 ,MAX(twbc.refid) as 'refid'
  FROM [GADATA].[NGAC].[TipwearBeforeChange] as twBc
--**************************************************************************--
--join number of spots per car for this tip. 
--**************************************************************************--
left join (
SELECT 
       Sum([WearComponent]) as 'TotWearComponent' --this is wrong it just sums the variants 
      ,[Robot]
  FROM [GADATA].[WELDING].[ABBWearComponent]
  group by Robot
  ) as nWearComponent on nWearComponent.Robot = twBc.controller_name
  --AND
  -- MUST JOIN ELECTRODE !! but its not in jens his table
--**************************************************************************--
  WHERE 
   --last 100 days of data
   --SDEBEUL 18w22 increase to 100 days because of lazy 331050r01
   twBc.TipchangeTimestamp between getdate()-30 and getdate()
   AND 
  --The tipwear must be more than x% to include it in the calculation
   twBc.[%FixedWearBeforeChange] >= 25 --zeker 25% wear gehad hebben voor wissel
   AND 
   twBc.[%MoveWearBeforeChange] >= 25 --zeker 25% wear gehad hebben voor wissel
   AND
   twBc.[%FixedWearBeforeChange] < 100 --niet meer dan 100% wear voor wissel
   AND 
   twBc.[%MoveWearBeforeChange] < 100 --niet meer dan 100% wear voor wissel
   AND 
   twBc.WeldsBeforeChange > 200 --moet minsten 200 spot gelast hebben voor wissel
  
  --THIS DESTROYSSSS performance!!!!
  -- AND 
  --SDEBEUL 18w22 added this limit  to only look at the last 20 changes 
  -- twBc.tipchangeindex < 20 --must be withing the last 20 tipchanges 
  
  
  GROUP BY 
   twBc.controller_name
  ,twBc.LocationTree
  ,twBc.Tool_Nr
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'TipLifeExpectations';


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
', @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'TipLifeExpectations';

