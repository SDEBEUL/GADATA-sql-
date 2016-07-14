



CREATE VIEW [GLUE].[OperatorView3]
AS
SELECT       c.location, GLUE.h_operator.c_timestamp, P.Name, g.Product as Product
, g.Doser_type as Doser_type, GLUE.Signal.SignalName, GLUE.OperatorActionInfo.Description AS OperatorActionInfo, 
                         CASE WHEN CONCAT(GLUE.h_operator.OldValue,'=>', GLUE.h_operator.NewValue) = '=>' THEN NULL ELSE CONCAT(GLUE.h_operator.OldValue,'=>', GLUE.h_operator.NewValue) END AS toestandsverandering, GLUE.Users.Name AS Users
						 , T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'Day'
, T.shift AS 'Shift'

FROM            GLUE.h_operator INNER JOIN
                         GLUE.Controller as P ON GLUE.h_operator.Controller_id = P.ID INNER JOIN
                         GLUE.OperatorActionInfo ON GLUE.h_operator.OperatorActionInfo_id = GLUE.OperatorActionInfo.ID INNER JOIN
                         GLUE.Signal ON GLUE.h_operator.Signal_id = GLUE.Signal.ID INNER JOIN
                         GLUE.Users ON GLUE.h_operator.User_id = GLUE.Users.ID
						 LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
c_timestamp BETWEEN T.starttime AND T.endtime
--join 'Rs breakdown' breakdowns where no gatestop was detected
left join glue.c_controller as c on c.controller_name=P.Name
join glue.type as g on g.Controller_id = P.ID