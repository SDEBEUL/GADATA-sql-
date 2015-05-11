CREATE PROCEDURE [ABB].[sp_ActivityProc ]
AS
begin
select 
DATEPART(year,h._timestamp) as 'year'
,DATEPART(WEEK,h._timestamp) as 'week'
,DATEPART(day,h._timestamp) as 'day'
,DATEPART(hour,h._timestamp) as 'hour'
,count(h._timestamp) as 'MsgPerHour'
,c.controller_name
from GADATA.abb.h_alarm as h
join GADATA.abb.c_controller as c on c.id = h.controller_id
Group by DATEPART(year,h._timestamp),DATEPART(WEEK,h._timestamp),DATEPART(day,h._timestamp),DATEPART(hour,h._timestamp), c.controller_name
end