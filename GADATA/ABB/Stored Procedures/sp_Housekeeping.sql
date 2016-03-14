
CREATE PROCEDURE [ABB].[sp_Housekeeping]

AS
--USE GADATA
---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------
BEGIN
--****************************************************************************************************************--
---------------------------------------------------------------------------------------------------------------------
--In this part we will compare the error text data from rt_alarm with the L_<logtext> tables.
--This is the first part in normalizing the db. (store each text / error type once
print '--*****************************************************************************--'
Print '--Running [ABB].[sp_Housekeeping]'
print '--*****************************************************************************--'
---------------------------------------------------------------------------------------------------------------------
--****************************************************************************************************************--
---------------------------------------------------------------------------------------
Print'--delete all bullshit older than 30 days'; --
---------------------------------------------------------------------------------------
--Find most commen errors in abb..
/*
select 
 count(h.error_id) as 'c'
,h.error_id
,l.error_text
,l.error_number
,c.Category
from GADATA.ABB.h_alarm as h 
left join GADATA.abb.L_error as l on l.id = h.error_id
left join GADATA.abb.c_category as c on c.id = L.category_id
GROUP BY 
 h.error_id
,l.error_text
,l.error_number
,c.Category
HAVING 
count(h.error_id) > 10000
ORDER BY 
c desc 
*/

--most commen on 10/03/2016

/*
c	error_id	error_text	error_number	Category
1394984	177	Timeout	40501	RAPID Program Events
599257	110	Regain start	10052	System State Events
594620	111	Regain ready	10053	System State Events
524977	100	Program stopped	10005	System State Events
519584	101	Program restarted	10008	System State Events
253889	178	Corner path failure	50024	Motion Control Events/Err
226446	102	Motors off state	10010	System State Events
223331	181	Restart limitation	50146	Motion Control Events/Err
220087	103	Motors on state	10011	System State Events
207825	113	Arc supervision	110023	Arcweld Events
202245	119	Auto Stop open	20205	System Errors
193265	134	Reference error	40168	Program
133699	133	Confirm rejected	20148	System
128854	104	Guard stop state	10012	System State Events
97280	131	Safety guard stop state	10012	Operational
*/

--delete these most commen errors older than 30 days..
DELETE GADATA.ABB.h_alarm
FROM GADATA.ABB.h_alarm as h 
WHERE 
H.error_id 
in
(
 177
,110
,111
,100
,101
,178
,102
,181
,103
,113
,119
,134
,133
,104
,131
)
AND
H._timestamp NOT between getdate()-30 AND GETDATE()


END