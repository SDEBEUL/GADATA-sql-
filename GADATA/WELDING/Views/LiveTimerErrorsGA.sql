CREATE VIEW WELDING.LiveTimerErrorsGA
AS

 SELECT GETDATE() AS timestamp, [timerName], [errorText]
FROM            [19.148.189.9\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
 UNION ALL
 SELECT GETDATE() AS timestamp, [timerName], [errorText]
FROM            [19.148.170.244\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
 UNION ALL
 SELECT GETDATE() AS timestamp, [timerName], [errorText]
FROM            [19.148.170.103\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
UNION ALL
 SELECT GETDATE() AS timestamp, [timerName], [errorText]
FROM            [19.148.184.10\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
UNION ALL
 SELECT GETDATE() AS timestamp, [timerName], [errorText]
FROM            [19.148.185.36\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
 UNION ALL
 SELECT GETDATE() AS timestamp, [timerName], [errorText]
FROM            [19.148.185.37\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
UNION ALL
 SELECT GETDATE() AS timestamp, [timerName], [errorText]
FROM            [19.148.179.160\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
 UNION ALL
 SELECT GETDATE() AS timestamp, [timerName], [errorText]
FROM            [19.148.179.161\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
 UNION ALL
 SELECT GETDATE() AS timestamp, [timerName], [errorText]
FROM            [19.148.182.11\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
 UNION ALL
 SELECT GETDATE() AS timestamp, [timerName], [errorText]
FROM            [136.20.175.212\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
UNION ALL
 SELECT GETDATE() AS timestamp, [timerName], [errorText]
FROM            [136.20.175.213\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
UNION ALL
 SELECT GETDATE() AS timestamp, [timerName], [errorText]
FROM            [136.20.175.254\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
 UNION ALL
 SELECT GETDATE() AS timestamp, [timerName], [errorText]
FROM            [19.148.176.27\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT22*/ UNION ALL
 SELECT GETDATE() AS timestamp, [timerName], [errorText]
FROM            [19.148.180.162\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT23*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName], [errorText]
FROM            [19.148.181.53\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT24*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [19.148.180.227\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT26*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [19.148.181.154\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT27*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [19.148.181.155\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT28*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [19.148.180.141\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT29*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [19.148.180.149\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT30*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [19.148.180.203\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT31*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [19.148.180.39\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT32*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [19.148.192.18\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT33*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [19.148.192.33\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT40*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [10.249.240.10\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '103' AND Errornumber <> '87' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%' AND Errornumber <> '87'
/*-NPT41*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [10.249.240.11\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT42*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [10.249.240.12\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '94' AND Errornumber <> '87' AND 
                         Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT43*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [10.249.240.13\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT50*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [10.249.225.199\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT51*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [10.249.225.197\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*NPT52*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [10.249.225.198\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT53*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [10.249.240.14\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT54*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [10.249.225.200\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT55*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [10.249.226.5\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT56*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [10.249.225.133\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT57*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [10.249.203.138\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT58*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [10.249.226.7\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT59*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [10.249.226.8\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT70*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [10.249.227.69\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT71*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [10.249.222.197\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT72*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [10.249.225.135\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
/*-NPT73*/ UNION ALL
SELECT        GETDATE() AS timestamp, [timerName] COLLATE DATABASE_DEFAULT, [errorText] COLLATE DATABASE_DEFAULT
FROM            [10.249.222.198\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[ExtActualErrorQueue_V]
WHERE        Errornumber <> '0' AND Errornumber <> '80' AND Errornumber <> '102' AND Errornumber <> '84' AND Errornumber <> '87' AND Errornumber <> '103' OR
                         Errortext LIKE 'Tip Life Expir%' OR
                         Errortext LIKE 'Tip Life ne%'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'LiveTimerErrorsGA';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[9] 4[10] 2[72] 3) )"
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 2235
         Width = 1575
         Width = 2355
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
', @level0type = N'SCHEMA', @level0name = N'WELDING', @level1type = N'VIEW', @level1name = N'LiveTimerErrorsGA';

