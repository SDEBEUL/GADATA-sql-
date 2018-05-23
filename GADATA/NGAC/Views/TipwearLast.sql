











CREATE VIEW [NGAC].[TipwearLast]
AS
select 
 y.*
,avgESTspots.avgESTnSpotsFixedWearBefore100
,avgESTspots.avgESTnSpotsMoveWearBefore100
,avgESTspots.maxWearInCalc
,avgESTspots.minWearInCalc
,avgESTspots.countWearInCalc
,avgESTspots.avgESTnSpotsFixedWearBefore100 - (y.Dress_Num*avgESTspots.avgWeldPerDress) as 'ESTremainingspotsFixed'
,avgESTspots.avgESTnSpotsMoveWearBefore100 - (y.Dress_Num*avgESTspots.avgWeldPerDress) as 'ESTremainingspotsMove'
,ROUND(((avgESTspots.avgESTnSpotsFixedWearBefore100 - (y.Dress_Num*avgESTspots.avgWeldPerDress)) / nSpotsCar.TotWearComponent),0) as 'ESTremainingCarsFixed'
,ROUND(((avgESTspots.avgESTnSpotsMoveWearBefore100 - (y.Dress_Num*avgESTspots.avgWeldPerDress)) / nSpotsCar.TotWearComponent),0) as 'ESTremainingsCarsMove'
,nSpotsCar.TotWearComponent
,avgESTspots.LastTipchange
,avgESTspots.avgDeltaNomAfterchange
from(
select x.*  from(--nested to optimize return result for next join
select
 rt.*
,ROW_NUMBER() OVER (PARTITION BY rt.controller_name, rt.Tool_nr ORDER BY rt.[Date Time] DESC) AS 'rnDesc'
from GADATA.NGAC.TipDressLogFile as rt 
where
--SDB bug trap 'divide by 0' 18w4d1
/*
controller_name	id	rt_csv_file_id	Date Time	Tool_Nr	Dress_Num	Weld_Counter	Dress_Reason	Weld_Result	Length_Fixed_Result	Length_Move_Result	Max_Wear_Fixed	Wear_Fixed	DiffFrLastWear_Fixed	Max_Wear_Move	Wear_Move	DiffFrLastWear_Move	MaxDiffFrLastMeas	Current_TipWear	TipWearRatio	Dress_Time1	Dress_Pressure1	Dress_Time2	Dress_Pressure2	CleanDress_Time	CleanDress_Pressure	Time_DressCycleTime	ErrorType	ExtraInfo	GunTCP_X	GunTCP_Y	GunTCP_Z	GunRefTCP_X	GunRefTCP_Y	GunRefTCP_Z	NomTCP_X	NomTCP_Y	NomTCP_Z	Tool_NrHs	ChkDrWear_Fixed_Result	ChkDrWear_Move_Result	FxSens_SetupVal	FxSens_StartVal	FxSens_PrevVal	FxSens_PrevWare	FxSens_DiffValue	FxSens_MaxSensZComp	FxSens_WarmSensZComp	FxSens_FlPinPrevVal	FxSens_FlPinSetupVal	FxSens_FlPinPhysActVal	FxSens_FlPinPhysSetupVal	Internal_Arg	DeltaRef	DeltaNom	rnDesc	avgESTnSpotsFixedWearBefore100	avgESTnSpotsMoveWearBefore100	maxWearInCalc	minWearInCalc	countWearInCalc	ESTremainingspotsFixed	ESTremainingspotsMove	ESTremainingCarsFixed	ESTremainingsCarsMove	nSpots44	LastTipchange
356020R04	112949	4936	2018-01-22 06:41:56.000	1	1	0			WELDCHKCOLLAPS (-1.6)		0	0	0	0	0	0	NULL	0	NULL	0	0	0	0	NULL	NULL	0	NULL	NULL	0	0	0	0	0	0	0	0	0	6			0	0	0	0	0	0	0	0	0	0	0		0	0	1	3274	3270	6,75	0,76	17	3274	3270	172	172	19	2018-01-18 05:33:35.000
*/
rt.Max_Wear_Fixed <> 0 and rt.Max_Wear_Move <> 0
--limit the data range we search. (qry performance) If no data for 48 hours we lose it
AND rt._timestamp between GETDATE() - 2 and GETDATE()
) as x 
where x.rnDesc =1
) as y
--**************************************************************************--
--join estemation of welds for 100 wear based on last 100 days of data 
--**************************************************************************--
left join (
SELECT 
  twBc.controller_name
 ,twBc.Tool_Nr
 ,ROUND(AVG(twBc.ESTnSpotsFixedWearBefore100),0) as 'avgESTnSpotsFixedWearBefore100'
 ,ROUND(AVG(twBC.ESTnSpotsMoveWearBefore100),0) as 'avgESTnSpotsMoveWearBefore100'
 ,ROUND(AVG(twBC.WeldsBeforeChange/twBc.DressBeforeChange),0) as 'avgWeldPerDress'
 --extra info 
 ,MAX(twBc.[WearBeforeChange]) as 'maxWearInCalc'
 ,MIN(twBc.[WearBeforeChange]) as 'minWearInCalc'
 ,COUNT(twBc.[WearBeforeChange]) as 'countWearInCalc'
 ,MAX(twBc.TipchangeTimestamp) as 'LastTipchange'
 ,AVG(twbc.[DeltaNom]) as 'avgDeltaNomAfterchange'
  FROM [GADATA].[NGAC].[TipwearBeforeChange] as twBc
  WHERE 
   --last 100 days of data
   twBc.TipchangeTimestamp between getdate()-30 and getdate()
   AND 
  --The tipwear must be more than x% to include it in the calculation
   twBc.[%FixedWearBeforeChange] >= 10 --zeker 10% wear gehad hebben voor wissel
   AND 
   twBc.[%MoveWearBeforeChange] >= 10 --zeker 10% wear gehad hebben voor wissel
   AND 
   twBc.WeldsBeforeChange > 100 --moet minsten 100 spot gelast hebben voor wissel
  GROUP BY 
   twBc.controller_name
  , twBc.Tool_Nr
  ) as avgESTspots on 
  avgESTspots.controller_name = y.controller_name
  AND 
  avgESTspots.Tool_Nr = y.Tool_Nr
--**************************************************************************--
--join number of spots per car for this tip. 
--**************************************************************************--
left join (
SELECT TOP (1000) 
       Sum([WearComponent]) as 'TotWearComponent' --this is wrong it just sums the variants 
      ,[Robot]
  FROM [GADATA].[WELDING].[ABBWearComponent]
  group by Robot
  ) as nSpotsCar on nSpotsCar.Robot = y.controller_name
  --AND
  -- MUST JOIN ELECTRODE !! 
--**************************************************************************--
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'TipwearLast';


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
', @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'TipwearLast';

