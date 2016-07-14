






CREATE VIEW [GLUE].[vultijd_alarm2]
AS

SELECT DISTINCT
c.location
,P.Name as Teamstername
, cast(H.time as datetime) as Timestamp
, CONCAT('huidige vultijd=' , CAST(ROUND(H.gemiddelde_vultijd_ms/1000.0,5) AS DECIMAL(6,3)) , '   |   bovengrens vultijd=' , V.UCL1)   as logtekst
, g.Product as Product
, g.Doser_type as Doser_type
, T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'Day'
, 'UCL1' as 'aantal keren standaardafwijking'

FROM GLUE.vultijd_gemiddelden as H

join glue.Controller as P  on (H.Controller_id  = P.ID)

LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
cast(T.starttime as date) = cast(H.time as date)
--join 'Rs breakdown' breakdowns where no gatestop was detected
left join glue.c_controller as c on c.controller_name=P.Name
join glue.type as g on g.Controller_id = P.ID
join glue.VULTIJDreferentie2 as V on V.Controller=P.Name

where/* T.Vday <> 'NULL' AND*/ T.Vday <> '6' AND V.UCL1 < CAST(ROUND(H.gemiddelde_vultijd_ms/1000.0,5) AS DECIMAL(6,3))

UNION

SELECT DISTINCT
c.location
,P.Name as Teamstername
, cast(H.time as datetime) as Timestamp
, CONCAT('huidige vultijd=' , CAST(ROUND(H.gemiddelde_vultijd_ms/1000.0,5) AS DECIMAL(6,3)) , '   |   bovengrens vultijd=' , V.UCL2)   as logtekst
, g.Product as Product
, g.Doser_type as Doser_type
, T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'Day'
, 'UCL2' as 'aantal keren standaardafwijking'

FROM GLUE.vultijd_gemiddelden as H

join glue.Controller as P  on (H.Controller_id  = P.ID)

LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
cast(T.starttime as date) = cast(H.time as date)
--join 'Rs breakdown' breakdowns where no gatestop was detected
left join glue.c_controller as c on c.controller_name=P.Name
join glue.type as g on g.Controller_id = P.ID
join glue.VULTIJDreferentie2 as V on V.Controller=P.Name

where/* T.Vday <> 'NULL' AND*/ T.Vday <> '6' AND V.UCL2 < CAST(ROUND(H.gemiddelde_vultijd_ms/1000.0,5) AS DECIMAL(6,3))

UNION

SELECT DISTINCT
c.location
,P.Name as Teamstername
, cast(H.time as datetime) as Timestamp
, CONCAT('huidige vultijd=' , CAST(ROUND(H.gemiddelde_vultijd_ms/1000.0,5) AS DECIMAL(6,3)) , '   |   bovengrens vultijd=' , V.UCL3)   as logtekst
, g.Product as Product
, g.Doser_type as Doser_type
, T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'Day'
, 'UCL3' as 'aantal keren standaardafwijking'

FROM GLUE.vultijd_gemiddelden as H

join glue.Controller as P  on (H.Controller_id  = P.ID)

LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
cast(T.starttime as date) = cast(H.time as date)
--join 'Rs breakdown' breakdowns where no gatestop was detected
left join glue.c_controller as c on c.controller_name=P.Name
join glue.type as g on g.Controller_id = P.ID
join glue.VULTIJDreferentie2 as V on V.Controller=P.Name

where/* T.Vday <> 'NULL' AND*/ T.Vday <> '6' AND V.UCL3 < CAST(ROUND(H.gemiddelde_vultijd_ms/1000.0,5) AS DECIMAL(6,3))

UNION

SELECT DISTINCT
c.location
,P.Name as Teamstername
, cast(H.time as datetime) as Timestamp
, CONCAT('huidige vultijd=' , CAST(ROUND(H.gemiddelde_vultijd_ms/1000.0,5) AS DECIMAL(6,3)) , '   |   bovengrens vultijd=' , V.UCL4)   as logtekst
, g.Product as Product
, g.Doser_type as Doser_type
, T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'Day'
, 'UCL4' as 'aantal keren standaardafwijking'

FROM GLUE.vultijd_gemiddelden as H

join glue.Controller as P  on (H.Controller_id  = P.ID)

LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
cast(T.starttime as date) = cast(H.time as date)
--join 'Rs breakdown' breakdowns where no gatestop was detected
left join glue.c_controller as c on c.controller_name=P.Name
join glue.type as g on g.Controller_id = P.ID
join glue.VULTIJDreferentie2 as V on V.Controller=P.Name


where/* T.Vday <> 'NULL' AND*/ T.Vday <> '6' AND V.UCL4 < CAST(ROUND(H.gemiddelde_vultijd_ms/1000.0,5) AS DECIMAL(6,3))


UNION

SELECT DISTINCT
c.location
,P.Name as Teamstername
, cast(H.time as datetime) as Timestamp
, CONCAT('huidige vultijd=' , CAST(ROUND(H.gemiddelde_vultijd_ms/1000.0,5) AS DECIMAL(6,3)) , '   |   bovengrens vultijd=' , V.UCL5)   as logtekst
, g.Product as Product
, g.Doser_type as Doser_type
, T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'Day'
, 'UCL5' as 'aantal keren standaardafwijking'

FROM GLUE.vultijd_gemiddelden as H

join glue.Controller as P  on (H.Controller_id  = P.ID)

LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
cast(T.starttime as date) = cast(H.time as date)
--join 'Rs breakdown' breakdowns where no gatestop was detected
left join glue.c_controller as c on c.controller_name=P.Name
join glue.type as g on g.Controller_id = P.ID
join glue.VULTIJDreferentie2 as V on V.Controller=P.Name

where/* T.Vday <> 'NULL' AND*/ T.Vday <> '6' AND V.UCL5 < CAST(ROUND(H.gemiddelde_vultijd_ms/1000.0,5) AS DECIMAL(6,3))