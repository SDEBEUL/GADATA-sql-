
-- ============================================= 
-- Author:     Coppejans Jens
-- Create date:  
-- Description:   
-- ============================================= 
CREATE PROCEDURE [UL].[spotIdentImport] 
AS 
  BEGIN 
      SET nocount ON; 

      --NPT26 
      INSERT INTO ul.spotidentmeasurements 
                  (timestamp, 
                   spotid) 
      SELECT tbl.datetime, 
             dbo.spot.id 
      FROM   (SELECT [datetime], 
                     [spotname] 
              FROM 
[19.148.181.154\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '45386' 
         OR spotname = '35074' 
         OR spotname = '35440' 
         OR spotname = '35767')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
UNION 
--NPT27 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[19.148.181.155\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '35501' 
         OR spotname = '35502' 
         OR spotname = '35989' 
         OR spotname = '35990' 
         OR spotname = '45409' 
         OR spotname = '35694' 
         OR spotname = '43627' 
         OR spotname = '32215' 
         OR spotname = '32420' 
         OR spotname = '32421' 
         OR spotname = '35066')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
UNION 
--NPT30 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[19.148.180.203\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '39623' 
         OR spotname = '38892' 
         OR spotname = '39633' 
         OR spotname = '39308')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
UNION 
--NPT31 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[19.148.180.39\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '38916' 
         OR spotname = '39162' 
         OR spotname = '39283' 
         OR spotname = '39339')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
UNION 
--NPT32 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[19.148.192.18\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '38924' 
         OR spotname = '39205' 
         OR spotname = '39344' 
         OR spotname = '39355' 
         OR spotname = '39373' 
         OR spotname = '39374')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
UNION 
--NPT33 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[19.148.192.33\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '36052' 
         OR spotname = '38358')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
UNION 
--NPT40 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[10.249.240.10\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '4404114' 
         OR spotname = '4404703')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
UNION 
--NPT41 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[10.249.240.11\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '4405975' 
         OR spotname = '4401870')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
UNION 
--NPT43 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[10.249.240.13\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '4413310' 
         OR spotname = '4404970' 
         OR spotname = '4413158' 
         OR spotname = '4413219' 
         OR spotname = '4413341' 
         OR spotname = '4412873' 
         OR spotname = '4405861' 
         OR spotname = '4409388' 
         OR spotname = '4409426' 
         OR spotname = '4413698')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
UNION 
--NPT50 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[10.249.225.199\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '4402401' 
         OR spotname = '4405598' 
         OR spotname = '4403036')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
UNION 
--NPT51 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[10.249.225.197\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '4402290' 
         OR spotname = '4405635' 
         OR spotname = '4405982' 
         OR spotname = '4405998')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
UNION 
--NPT53 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[10.249.240.14\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '4401863' 
         OR spotname = '4405722')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
--NPT56 
UNION 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[10.249.225.133\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '4405888')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
--NPT57 
UNION 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[10.249.203.138\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '4405859' 
         OR spotname = '4413708' 
         OR spotname = '4404091' 
         OR spotname = '4414062')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
--NPT58 
UNION 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[10.249.226.7\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '4405050' 
         OR spotname = '4405301' 
         OR spotname = '4405037' 
         OR spotname = '4412419' 
         OR spotname = '4413741')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
--NPT59 
UNION 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[10.249.226.8\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '4404636' 
         OR spotname = '4405572' 
         OR spotname = '4405617' 
         OR spotname = '4405657' 
         OR spotname = '4405676')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
--NPT70 
UNION 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[10.249.227.69\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '4408841' 
         OR spotname = '4409789' 
         OR spotname = '4408039' 
         OR spotname = '4409811')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
--NPT71 
UNION 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[10.249.222.197\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '4408040' 
         OR spotname = '4408842' 
         OR spotname = '4406477' 
         OR spotname = '4409790' 
         OR spotname = '4409812')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
--NPT72 
UNION 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[10.249.225.135\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '4408625' 
         OR spotname = '4408815' 
         OR spotname = '4408185' 
         OR spotname = '4408779')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
--NPT73 
UNION 
SELECT tbl.datetime, 
       dbo.spot.id 
FROM   (SELECT [datetime], 
               [spotname] 
        FROM 
[10.249.222.198\BOS_SQLSERV_2005].[BOS_6000_DB].[dbo].[extweldmeasureprotddw_v] 
 WHERE  spotname = '4408459' 
         OR spotname = '4408481' 
         OR spotname = '4408780' 
         OR spotname = '4408816')tbl 
LEFT OUTER JOIN ul.spotidentmeasurements 
             ON tbl.datetime = ul.spotidentmeasurements.timestamp 
LEFT OUTER JOIN dbo.spot 
             ON tbl.spotname = dbo.spot.number 
WHERE  ( ul.spotidentmeasurements.timestamp IS NULL ) 
END