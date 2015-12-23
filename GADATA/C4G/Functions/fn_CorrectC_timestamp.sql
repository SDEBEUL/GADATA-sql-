


CREATE FUNCTION [C4G].[fn_CorrectC_timestamp] 
	(
		@InController_id int,
		@InTimestamp Datetime
	) 
RETURNS DATETIME
AS 
BEGIN 
DECLARE @offsetTs as datetime 
SET @offsetTs = 
(
SELECT TOP 1 h._timestamp - h.c_timestamp FROM GADATA.C4G.h_alarm as h 
where h.controller_id = @InController_id 
and 
h.c_timestamp < @intimestamp 
and
h.error_is_alarm = 1
order by id desc
)
return (@Intimestamp + @offsetTs)
END