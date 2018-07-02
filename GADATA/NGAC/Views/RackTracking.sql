


CREATE VIEW [NGAC].[RackTracking]
AS

--one rack
select  
--in case there are 2 racks we put both rfidnum into the bodynum
--RFID1*10000 + RFID2 = bodyno
rt.bodyNo % 10000  AS 'RFID'
,1 as 'racknum'
,b.*
from GADATA.NGAC.rt_job  as rt
left join GADATA.NGAC.c_controller as c on c.id = rt.c_controller_id
left join GADATA.NGAC.breakdown as b on b.refid = rt.id
where c.hasRackidAsBodynum = 1 --has bodym as rack 
and rt.breakDownCount <> 0 --has breakdown 
and rt.bodyNo < 10000 --first rack
and b.subgroup not in ('Operational','Undefined*') -- no junk
and b.classification like 'UG'

--second rack
union
select  
--in case there are 2 racks we put both rfidnum into the bodynum
--RFID1*10000 + RFID2 = bodyno
ROUND(rt.bodyNo/10000,0)  AS 'RFID'
,2 as 'racknum'
,b.*
from GADATA.NGAC.rt_job  as rt
left join GADATA.NGAC.c_controller as c on c.id = rt.c_controller_id
left join GADATA.NGAC.breakdown as b on b.refid = rt.id
where c.hasRackidAsBodynum = 1 --has bodym as rack 
and rt.breakDownCount <> 0 --has breakdown 
and rt.bodyNo <> 0 --in case of second rack one of the 2 must be on else we always make dups 
and rt.bodyNo > 10000 --second rack
and b.subgroup not in ('Operational','Undefined*') -- no junk
and b.classification like 'UG'


--filter only gripper faults
--this is still bullshit because i join the breakdown blind. I'm not shure the robot was in the rack when we had the breakdown.
--I just know I had a gripper fault and rack X was there.
--Even more shitty is that in multy rack locations I don't know what rack it was.
--This just sucks balls UGHH Ron... 
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'RackTracking';


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
               Right = 225
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 263
               Bottom = 135
               Right = 470
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
', @level0type = N'SCHEMA', @level0name = N'NGAC', @level1type = N'VIEW', @level1name = N'RackTracking';

