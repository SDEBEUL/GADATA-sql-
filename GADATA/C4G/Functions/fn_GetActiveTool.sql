



CREATE FUNCTION [C4G].[fn_GetActiveTool] 
	(
		@controller_id int
		,@_timestamp as datetime
	) 
RETURNS varchar(50) 
AS 
BEGIN 
declare @activetool varchar(50)	
SET @activetool = 
(
SELECT TOP 1 r.value FROM GADATA.C4G.rt_toolLog as r 
WHERE 
r.controller_id = @controller_id
and 
r._timestamp < @_timestamp 
and
r.variable_id = 63
ORDER by _timestamp desc 
)
return @activetool 
end