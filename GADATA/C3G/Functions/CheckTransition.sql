

CREATE FUNCTION [C3G].[CheckTransition] 
	(
	
	) 
RETURNS int 
AS 
BEGIN
DECLARE @result as int;
DECLARE @controller as int;
SELECT @controller = (SELECT TOP 1 controller_id from GADATA.c3g.Rt_sys_Event order by id desc);

With last2 as 
(
SELECT TOP 2 *, ROW_NUMBER() OVER (PARTITION BY e.controller_id ORDER BY e.id DESC) AS rnDESC FROM GADATA.C3G.rt_sys_event as e where e.controller_id = @controller order by id desc 
)

SELECT @result =
(
select  
1 as 'trig'
from last2 as lastevent
 JOIN last2 as previousevent on
previousevent.rnDESC = 2 
AND 
previousevent.sys_state & 262144 <> 262144
where 
lastevent.sys_state & 262144 = 262144
AND 
lastevent.rndesc = 1
)

return @result

end