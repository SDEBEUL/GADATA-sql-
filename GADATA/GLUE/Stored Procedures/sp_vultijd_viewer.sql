

















CREATE PROCEDURE [GLUE].[sp_vultijd_viewer]

AS
--USE GADATA
---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------
BEGIN
--****************************************************************************************************************--
if (OBJECT_ID('tempdb..#blabla') is not null) drop table #blabla


SELECT
controller_id,time, COUNT(house.time) as counten
INTO #blabla
FROM
(SELECT
 controller_id 
 ,  cast(c_timestamp as date) as time 
FROM
 GLUE.vultijden
) as house
 GROUP BY  controller_id, time

 if (OBJECT_ID('tempdb..#blabla2') is not null) drop table #blabla2


  SELECT 
p.c_timestamp 
,p.Controller_id 
,p.vultijd_ms
,B.counten
INTO #blabla2
 FROM
 GLUE.vultijden as p
 join #blabla as B on B.controller_id=p.Controller_id AND B.time=cast(c_timestamp as date)

 DELETE FROM [GLUE].[vultijden_viewers]
 

INSERT INTO glue.vultijden_viewers
SELECT
p.c_timestamp 
,p.Controller_id 
,p.vultijd_ms
,p.counten
 FROM #blabla2 as p
END