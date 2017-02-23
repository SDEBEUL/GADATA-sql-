
CREATE VIEW [GLUE].[AlarmView4]
AS

SELECT 
c.location
,P.Name as Teamstername
, g.Product as Product
, g.Doser_type as Doser_type
, min(H.c_timestamp) as Timestamp
, F.Priority as Severity
, F.El_Ident
, min(F.Description) AS 'Description'
, count(F.Description) AS 'count'
, T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'Day'
FROM glue.h_alarm as H

join glue.Controller as P  on (H.Controller_id  = P.ID)

join glue.FaultInfo as F on (H.FaultText_id  = F.ID)

join glue.Signal on (H.Signal_id  = glue.Signal.ID)

LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
H.c_timestamp BETWEEN T.starttime AND T.endtime
--join 'Rs breakdown' breakdowns where no gatestop was detected

left join glue.c_controller as c on c.controller_name=P.Name

join glue.type as g on g.Controller_id = P.ID

where H.c_status= ' '

GROUP BY 
c.location
,P.Name 
,g.product
,g.Doser_type
,T.Vyear
,T.Vweek
,T.Vday
,F.priority
,F.El_Ident