









CREATE VIEW [NGAC].[TipMonitor]
AS
SELECT DISTINCT top 10000  c.controller_name as 'Robot'
					      ,rt.Tool_Nr 
                          ,isnull(rt.[Date Time],getdate()) as 'Date time'
                          ,rt.[Dress_Num] as 'nDress'
                          ,rt.[Weld_Counter] as 'nWelds'
						  ,rt.TipWearRatio as 'WearRatio'
	                      ,CASE 
						     --tipalert and fixed dominant
						      WHEN (tipalert.refId is not null) AND rt.[Wear_Fixed] >= rt.[Wear_Move]  THEN ROUND((rt.[Wear_Fixed]  / rt.[Max_Wear_Fixed])*100,0) + isnull(rt.[Last%FixedWearBeforeChange],0)
			                  --tipalert and mov dominant
							  WHEN (tipalert.refId is not null) AND rt.[Wear_Fixed] <= rt.[Wear_Move]  THEN ROUND((rt.Wear_Move  / rt.Max_Wear_Move)*100,0) + isnull(rt.[Last%MovWearBeforeChange],0)
							  --NO tipalert and fixed dominant
						      WHEN (tipalert.refId is null) AND rt.[Wear_Fixed] >= rt.[Wear_Move]  THEN ROUND((rt.[Wear_Fixed]  / rt.[Max_Wear_Fixed])*100,0)
			                  --NO tipalert and mov dominant
							  WHEN (tipalert.refId is null) AND rt.[Wear_Fixed] <= rt.[Wear_Move]  THEN ROUND((rt.Wear_Move  / rt.Max_Wear_Move)*100,0) 
		                      ELSE -1
		                   END 'pWear' --in case of an alert we combine the previous wear and the current wear
                          ,CASE 
						     --if tipalert return error on remaining spots
						      WHEN (tipalert.refId is not null) THEN -1
							--if not tipalert
	                          WHEN (tipalert.refId is null) AND rt.[ESTremainingspotsFixed] >= rt.[ESTremainingspotsMove] THEN rt.[ESTremainingspotsFixed]
		                      WHEN (tipalert.refId is null) AND rt.[ESTremainingspotsFixed] <= rt.[ESTremainingspotsMove] THEN rt.[ESTremainingspotsMove]
							  ELSE null
		                   END 'nRspots'
                          ,CASE 
						     --if tipalert return error on remaining spots
						      WHEN (tipalert.refId is not null) THEN -1
							  --if not tipalert
	                          WHEN  (tipalert.refId is null) AND rt.[ESTremainingCarsFixed] >= rt.[ESTremainingsCarsMove] THEN rt.ESTremainingCarsFixed
							  WHEN  (tipalert.refId is null) AND rt.[ESTremainingCarsFixed] <= rt.[ESTremainingsCarsMove] THEN rt.ESTremainingsCarsMove
		                      ELSE null
		                   END 'nRcars'
						 ,DATEDIFF(hour,rt.LastTipchange,getdate()) as 'TipAge(h)'
						 ,rt.LastTipchange
						 ,rt.Time_DressCycleTime
						 ,c.id
						 ,c.LocationTree
						 ,ROUND(rt.DeltaNom-rt.[avgDeltaNomAfterchange],2) as 'MagicFiXedWear'
						 ,CASE 
						     WHEN rt._timestamp is null THEN 'ND' --no data!
							 WHEN tipalert.refId is not null THEN 'NTCD' --no tipchange deteced
							 WHEN rt.countWearInCalc is null THEN 'NWIC' --no wear in calc
							 ELSE ''
						  END as 'Status'
						 ,ROUND(rt.Wear_Fixed+rt.Wear_Move,2) as 'RobotWear'

                      FROM GADATA.NGAC.c_controller as c
					  left join [GADATA].[NGAC].[TipwearLast] as rt on rt.controller_name = c.controller_name
					  --join active tiplife alerts
					  left join GADATA.Alerts.Alerts as tipalert on tipalert.LocationTree = rt.LocationTree 
					  and tipalert.Subgroup like '%TIPLIFE%'
					  and tipalert.Category = 'WGK'
                      where ((rt.[Date Time] < getdate()) or rt.[Date Time] is null) AND (c.hasspotweld = 1) --only robots with the bit set will be handed!
					  --
                      Order by [pWear] DESC
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'TipMonitor';


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
         Begin Table = "TipwearLast (NGAC)"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 168
               Right = 376
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
', @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'TipMonitor';

