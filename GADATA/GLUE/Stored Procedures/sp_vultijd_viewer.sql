












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


  SELECT DISTINCT
p.c_timestamp 
,p.Controller_id 
,p.vultijd_ms
,B.counten
INTO #blabla2
 FROM
 GLUE.vultijden as p
 join #blabla as B on B.controller_id=p.Controller_id AND B.time=cast(c_timestamp as date)


INSERT INTO glue.vultijden_viewers
SELECT  DISTINCT
p.c_timestamp 
,p.Controller_id 
,p.vultijd_ms
,p.counten
 FROM #blabla2 as p
  LEFT join GADATA.GLUE.vultijden_viewers AS H on   --show also compare the logtekst here.... 
(
(p.controller_id  = H.Controller_id)
AND
(p.c_timestamp = H.c_timestamp) --was losing data because of this (controle side clock resolution = 1s so errors in the same S only 1 would pass. 
AND
(p.vultijd_ms = H.vultijd_ms)
AND
(p.counten = H.couten)
)
/*nieuwe waarden van de linker tabel #GLUE_rt_alarm_normalized toevoegen aan h_operator(GLUE)*/
where (H.id IS NULL)  /*als in de lijn nog niets ingevuld is*/



END