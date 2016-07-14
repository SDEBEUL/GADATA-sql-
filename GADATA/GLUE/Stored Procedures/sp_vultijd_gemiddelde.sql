

CREATE PROCEDURE [GLUE].[sp_vultijd_gemiddelde]

AS
--USE GADATA
---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------
BEGIN
--****************************************************************************************************************--




DELETE FROM [GLUE].[vultijd_gemiddelden]
 
 
INSERT INTO [GLUE].[vultijd_gemiddelden]
select DISTINCT
cast(R.c_timestamp as date) as time,
R.Controller_id
,avg(R.vultijd_ms) OVER (PARTITION BY  cast(R.c_timestamp as date), R.Controller_id) as gemiddelde_vultijd_ms
,couten
from  GLUE.vultijden_viewers as R
where couten > 20 AND vultijd_ms < 60000 AND vultijd_ms > 100
END