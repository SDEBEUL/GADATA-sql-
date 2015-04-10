
CREATE FUNCTION [dbo].[fn_getAproxActionTs] 
	(
		@InID int
	) 
RETURNS datetime 
AS 
BEGIN 
    declare @inputID int 
	SET @inputID = @InID
	declare @rdatetime datetime 

select top 1

	-- rt_alarm.id as 'mainID'
	--,rt_alarm.controller_id as ' mainCid'
	--,rt_alarm._timestamp  as 'main_timestamp'
	@rdatetime = (rt_alarm.error_timestamp + (Lrt_alarm.Error_timestamp - Lrt_alarm._timestamp)) 
	--,rt_alarm.Error_timestamp as 'main_error_timestamp'
	--,Lrt_alarm.id as 'Local_id'
	--,Lrt_alarm._timestamp  as 'Local_timestamp'
	--,Lrt_alarm.Error_timestamp as 'Local_error_timestamp'
	--,Delta_ts = (Lrt_alarm.Error_timestamp - Lrt_alarm._timestamp)

FROM rt_alarm 

JOIN rt_alarm AS Lrt_alarm on 
(rt_alarm.id = @inputID)
AND
(rt_alarm.controller_id = Lrt_alarm.controller_id)
AND
(rt_alarm.error_is_alarm = 0)
AND
(Lrt_alarm._timestamp IS NOT NULL)
AND
(rt_alarm.id < lrt_alarm.id)

WHERE
(rt_alarm.id = @inputID)
AND
(rt_alarm.error_is_alarm = 0)
ORDER BY rt_alarm.error_timestamp DESC 



return @rdatetime 
end