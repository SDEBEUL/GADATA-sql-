





CREATE VIEW [NGAC].[TipDressLogFile]
AS
select 
 c.controller_name
 ,c.LocationTree
 ,c.id as 'c_controller_id'
	  ,rt.[id]
      ,rt.[rt_csv_file_id]
      ,rt.[Date Time]
      ,isnull(rt.[Tool_Nr],1) as 'Tool_Nr' --stat gun not passing tool_nr? what happens in case of 2 statguns ?
      ,rt.[Dress_Num]
      ,rt.[Weld_Counter]
      ,rt.[Dress_Reason]
      ,rt.[Weld_Result]
      ,rt.[Length_Fixed_Result]
      ,rt.[Length_Move_Result]
      ,rt.[Max_Wear_Fixed]
      ,rt.[Wear_Fixed]
      ,rt.[DiffFrLastWear_Fixed]
      ,rt.[Max_Wear_Move]
      ,rt.[Wear_Move]
      ,rt.[DiffFrLastWear_Move]
      ,rt.[MaxDiffFrLastMeas]
      ,rt.[Current_TipWear]
      ,rt.[TipWearRatio]
      ,rt.[Dress_Time1]
      ,rt.[Dress_Pressure1]
      ,rt.[Dress_Time2]
      ,rt.[Dress_Pressure2]
      ,rt.[CleanDress_Time]
      ,rt.[CleanDress_Pressure]
      ,rt.[Time_DressCycleTime]
      ,rt.[ErrorType]
      ,rt.[ExtraInfo]
      ,rt.[GunTCP_X]
      ,rt.[GunTCP_Y]
      ,rt.[GunTCP_Z]
      ,rt.[GunRefTCP_X]
      ,rt.[GunRefTCP_Y]
      ,rt.[GunRefTCP_Z]
      ,rt.[NomTCP_X]
      ,rt.[NomTCP_Y]
      ,rt.[NomTCP_Z]
      ,rt.[Tool_NrHs]
      ,rt.[ChkDrWear_Fixed_Result]
      ,rt.[ChkDrWear_Move_Result]
      ,rt.[FxSens_SetupVal]
      ,rt.[FxSens_StartVal]
      ,rt.[FxSens_PrevVal]
      ,rt.[FxSens_PrevWare]
      ,rt.[FxSens_DiffValue]
      ,rt.[FxSens_MaxSensZComp]
      ,rt.[FxSens_WarmSensZComp]
      ,rt.[FxSens_FlPinPrevVal]
      ,rt.[FxSens_FlPinSetupVal]
      ,rt.[FxSens_FlPinPhysActVal]
      ,rt.[FxSens_FlPinPhysSetupVal]
      ,rt.[Internal_Arg]
,[NGAC].[DistanceBetweenPoints]([GunTCP_X],[GunTCP_Y],[GunTCP_Z],[GunRefTCP_X],[GunRefTCP_Y],[GunRefTCP_Z]) as 'DeltaRef'
,[NGAC].[DistanceBetweenPoints]([GunTCP_X],[GunTCP_Y],[GunTCP_Z],[NomTCP_X],[NomTCP_Y],[NomTCP_Z]) as 'DeltaNom'
,rt._timestamp
from GADATA.NGAC.rt_TipDressLogFile as rt 
left join GADATA.NGAC.rt_csv_file as rt_csv on rt.rt_csv_file_id = rt_csv.id
left join GADATA.NGAC.c_controller as c on c.id = rt_csv.c_controller_id
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'TipDressLogFile';


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
         Begin Table = "rt"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 264
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rt_csv"
            Begin Extent = 
               Top = 6
               Left = 302
               Bottom = 135
               Right = 472
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 510
               Bottom = 135
               Right = 685
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
', @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'TipDressLogFile';

