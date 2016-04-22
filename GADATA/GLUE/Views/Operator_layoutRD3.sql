








CREATE VIEW [GLUE].[Operator_layoutRD3]
AS

SELECT 
c.location
,glue.Controller.Name as Robotname
,'GLUE OPERATOR' as Type
,'PARAMETERWIJZIGING' as Errortype
, H.c_timestamp as Timestamp
, NULL as Logcode
, NULL as Severity
, CONCAT(F.Description,'    |   toestandsverandering = ',  CASE WHEN CONCAT(H.OldValue,'=>', H.NewValue) = '=>' THEN NULL ELSE CONCAT(H.OldValue,'=>', H.NewValue) END) as Logtekst
, NULL as Downtime
, T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'Day'
, T.shift AS 'Shift'
, 'N/A' as Object, 'N/A' as Subgroup
, H.ID as idx
FROM glue.h_operator as H

join glue.Controller  on (H.Controller_id  = glue.Controller.ID)

join glue.OperatorActionInfo as F on (H.OperatorActionInfo_id  = F.ID)

join glue.Signal on (H.Signal_id  = glue.Signal.ID)

LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
H.c_timestamp BETWEEN T.starttime AND T.endtime
--join 'Rs breakdown' breakdowns where no gatestop was detected

left join glue.c_controller as c on c.controller_name=glue.Controller.Name