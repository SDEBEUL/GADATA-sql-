CREATE PROCEDURE [dbo].[sp_VCSC_C4G_CheckRobotGENOVR]
AS

begin
SET DATEFIRST 1
end

BEGIN

WITH rt_value_rn_desc AS
(
SELECT 
_timestamp,
controller_id,
controller_name,
value,
ROW_NUMBER() OVER (PARTITION BY controller_id, variable_id ORDER BY _timestamp DESC) AS rnDESC
FROM GADATA.dbo.rt_value
join c_controller on c_controller.id = rt_value.controller_id
WHERE 
(rt_value.variable_id = 1) --$GEN_OVER
AND 
(rt_value._timestamp > (GETDATE()-31))
)

SELECT TOP 10 
rt_value_rn_desc._timestamp AS 'TimestampNOK',
rt_value_rn_desc.controller_name,
lrt_value_rn_desc._timestamp AS 'TimestampOK',
DATEDIFF(HOUR, ISNULL(Lrt_value_rn_desc._timestamp,getdate()), rt_value_rn_desc._timestamp) AS 'hours',
rt_value_rn_desc.value,
ISNULL(Lrt_value_rn_desc.value,'ROBOT IS SLOW!!') AS 'OldValue',
OKploeg = GADATA.dbo.fn_volvoshift(Lrt_value_rn_desc._timestamp,Lrt_value_rn_desc._timestamp),
Startploeg = GADATA.dbo.fn_volvoshift(rt_value_rn_desc._timestamp, rt_value_rn_desc._timestamp)

FROM rt_value_rn_desc
LEFT JOIN rt_value_rn_desc AS Lrt_value_rn_desc ON
(
(rt_value_rn_desc.controller_id = Lrt_value_rn_desc.controller_id )
AND
(Lrt_value_rn_desc.value <> 100) 
AND 
(rt_value_rn_desc.rnDESC = Lrt_value_rn_desc.rnDESC - 1)
AND
(rt_value_rn_desc.value IN ( 100, null))
)

WHERE 
--robots that are not 100% now
(
(rt_value_rn_desc.rnDESC = 1)
AND
(rt_value_rn_desc.value <> 100)
)

OR 

--robots that where less than 100% for more than 20 minutes 
(
(DATEDIFF(hour, Lrt_value_rn_desc._timestamp, rt_value_rn_desc._timestamp) > 1)
AND
(rt_value_rn_desc.value = 100)
AND
((GADATA.dbo.fn_volvoshift(rt_value_rn_desc._timestamp, rt_value_rn_desc._timestamp)) <> 4)
)

ORDER BY rt_value_rn_desc.value DESC

END