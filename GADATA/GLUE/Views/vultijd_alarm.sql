




CREATE VIEW [GLUE].[vultijd_alarm]
AS

SELECT DISTINCT
c.location
,P.Name as Teamstername
, cast(H.time as datetime) as Timestamp
, CONCAT('huidige vultijd=' , CAST(ROUND(H.gemiddelde_vultijd_ms/1000.0,5) AS DECIMAL(6,3)) , '   |   bovengrens vultijd=' , V.UCL)   as logtekst
, g.Product as Product
, g.Doser_type as Doser_type
, T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'Day'

FROM GLUE.vultijd_gemiddelden as H

join glue.Controller as P  on (H.Controller_id  = P.ID)

LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
cast(T.starttime as date) = cast(H.time as date)
--join 'Rs breakdown' breakdowns where no gatestop was detected
left join glue.c_controller as c on c.controller_name=P.Name
join glue.type as g on g.Controller_id = P.ID
join glue.VULTIJDreferentie as V on V.Controller=P.Name

where/* T.Vday <> 'NULL' AND*/ T.Vday <> '6' AND V.UCL < H.gemiddelde_vultijd_ms/1000