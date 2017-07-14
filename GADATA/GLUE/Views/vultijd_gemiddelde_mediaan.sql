










CREATE VIEW [GLUE].[vultijd_gemiddelde_mediaan]
AS
 
select DISTINCT
D.location
, D.controller_name as 'Controller'
, F.time
, T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'Day'
, CAST(ROUND(F.gemiddelde_vultijd_ms/1000.0,5) AS DECIMAL(6,3)) as gemiddelde_vultijd_s
from  GLUE.vultijd_gemiddelden as F
  join glue.Controller as C ON F.Controller_id = C.ID
    LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
cast(T.starttime as date) = F.time
left join glue.c_controller as D on D.controller_name=C.Name
where/* T.Vday <> 'NULL' AND*/ T.Vday <> '6'