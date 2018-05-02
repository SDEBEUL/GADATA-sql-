


CREATE VIEW [EqUi].[HopBoltingTest]
AS

select 
  c.controller_name	   AS 'Location' 
, rt.[Date Time]        AS 'timestamp'
,t.Vyear
,t.Vweek
,t.Vday
, [Txt 2]  
--,[Txt 1]
,[Txt 3]
--,[Txt 4]
,[Txt 5]
,[Txt 6]
,[Txt 7]
,[Txt 8]
--,[Txt 9] //keuze mogelijkehden
--,[Txt 10]
--,[Txt 11]
,[Action]

, rt.id				 AS 'refId'
,REPLACE(CASE  
     WHEN [Txt 7] LIKE '%SEQUENCE%' THEN [Txt 7]
	 WHEN [Txt 3] LIKE '%SEQUENCE%' THEN 'Rebolting'
     ELSE 'notDetected' 
END,'SEQUENCE:','')  as 'BOLTS'


,CASE  
     WHEN [Txt 7] LIKE '%REBOLTING%' THEN 'Rebolting'
	 WHEN [Txt 7] LIKE '%REBOLT%' THEN 'Rebolting'
     WHEN [Txt 7] LIKE '%UNBOLTING%' THEN 'Unbolting'
	 WHEN [Txt 7] LIKE '%Picking%' THEN 'Picking'
	 WHEN [Txt 7] LIKE '%Bolting%' THEN 'Bolting'
	 
	 WHEN [Txt 3] LIKE '%REBOLTING%' THEN 'Rebolting'
	 WHEN [Txt 3] LIKE '%REBOLT%' THEN 'Rebolting'
     WHEN [Txt 3] LIKE '%UNBOLTING%' THEN 'Unbolting'
	 WHEN [Txt 3] LIKE '%Picking%' THEN 'Picking'
	 WHEN [Txt 3] LIKE '%Bolting%' THEN 'Bolting'
     ELSE 'notDetected' 
END  as 'SequenceType'


from GADATA.NGAC.rt_ErrDispLog as rt 
LEFT JOIN GADATA.NGAC.rt_csv_file as rt_csv on rt.rt_csv_file_id = rt_csv.id
LEFT JOIN NGAC.c_controller as c  on c.id = rt_csv.c_controller_id
LEFT JOIN Volvo.L_timeline as t on rt.[Date Time] between t.starttime and t.endtime
where 
c.controller_name like '7%'
and rt.[Txt 2] like '%nutrunner error%'
and rt.[Txt 3] not like '%Skipped%'

UNION
select 
  c.controller_name	   AS 'Location' 
, rt.[Date Time]        AS 'timestamp'
,t.Vyear
,t.Vweek
,t.Vday
, [Txt 2]  
--,[Txt 1]
,[Txt 3]
--,[Txt 4]
,[Txt 5]
,[Txt 6]
,[Txt 7]
,[Txt 8]
--,[Txt 9] //keuze mogelijkehden
--,[Txt 10]
--,[Txt 11]
,[Action]

, rt.id				 AS 'refId'
,REPLACE([Txt 3],'SEQUENCE:','')  as 'BOLTS'


,CASE  
     WHEN [Txt 7] LIKE '%REBOLTING%' THEN 'Rebolting'
	 WHEN [Txt 7] LIKE '%REBOLT%' THEN 'Rebolting'
     WHEN [Txt 7] LIKE '%UNBOLTING%' THEN 'Unbolting'
	 WHEN [Txt 7] LIKE '%Picking%' THEN 'Picking'
	 WHEN [Txt 7] LIKE '%Bolting%' THEN 'Bolting'
	 
	 WHEN [Txt 3] LIKE '%REBOLTING%' THEN 'Rebolting'
	 WHEN [Txt 3] LIKE '%REBOLT%' THEN 'Rebolting'
     WHEN [Txt 3] LIKE '%UNBOLTING%' THEN 'Unbolting'
	 WHEN [Txt 3] LIKE '%Picking%' THEN 'Picking'
	 WHEN [Txt 3] LIKE '%Bolting%' THEN 'Bolting'
     ELSE 'notDetected' 
END  as 'SequenceType'


from GADATA.ngac.rt_ErrDispLogS4C as rt 
LEFT JOIN GADATA.NGAC.rt_csv_file as rt_csv on rt.rt_csv_file_id = rt_csv.id
LEFT JOIN NGAC.c_controller as c  on c.id = rt_csv.c_controller_id
LEFT JOIN Volvo.L_timeline as t on rt.[Date Time] between t.starttime and t.endtime
where 
c.controller_name like '7%'
and rt.[Txt 2] like '%nutrunner error%'
and rt.[Txt 3] not like '%Skipped%'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'EqUi', @level1type = N'VIEW', @level1name = N'HopBoltingTest';


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
         Begin Table = "e"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 213
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
', @level0type = N'SCHEMA', @level0name = N'EqUi', @level1type = N'VIEW', @level1name = N'HopBoltingTest';

