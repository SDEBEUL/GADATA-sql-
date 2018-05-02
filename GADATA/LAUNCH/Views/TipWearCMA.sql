CREATE VIEW LAUNCH.TipWearCMA
AS
SELECT        NGAC.c_controller.controller_name, NGAC.rt_TipDressLogFile.Length_Fixed_Result, NGAC.rt_TipDressLogFile.Length_Move_Result, 
                         NGAC.rt_TipDressLogFile.[Date Time], NGAC.rt_TipDressLogFile.Wear_Move, NGAC.rt_TipDressLogFile.Wear_Fixed, NGAC.rt_TipDressLogFile.Max_Wear_Move, 
                         NGAC.rt_TipDressLogFile.Max_Wear_Fixed, NGAC.rt_TipDressLogFile.Dress_Reason, NGAC.rt_TipDressLogFile.Current_TipWear, 
                         NGAC.rt_TipDressLogFile.TipWearRatio, NGAC.rt_TipDressLogFile.Weld_Counter, NGAC.rt_TipDressLogFile.Dress_Num
FROM            NGAC.c_controller INNER JOIN
                         NGAC.rt_csv_file ON NGAC.c_controller.id = NGAC.rt_csv_file.c_controller_id INNER JOIN
                         NGAC.rt_TipDressLogFile ON NGAC.rt_csv_file.id = NGAC.rt_TipDressLogFile.rt_csv_file_id
WHERE        (NGAC.rt_TipDressLogFile.[Date Time] >= GETDATE() - 64)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[16] 3) )"
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
         Begin Table = "c_controller (NGAC)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 188
               Right = 213
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rt_csv_file (NGAC)"
            Begin Extent = 
               Top = 50
               Left = 298
               Bottom = 179
               Right = 468
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rt_TipDressLogFile (NGAC)"
            Begin Extent = 
               Top = 74
               Left = 623
               Bottom = 360
               Right = 849
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
      Begin ColumnWidths = 14
         Width = 284
         Width = 1500
         Width = 1785
         Width = 1875
         Width = 1500
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
         Filter = 2430
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'TipWearCMA';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'LAUNCH', @level1type = N'VIEW', @level1name = N'TipWearCMA';

