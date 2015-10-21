
CREATE PROCEDURE [c3g].[LiveView]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null


AS
BEGIN
---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--Set default values of start and end date
---------------------------------------------------------------------------------------
if ((@StartDate is null) OR (@StartDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @StartDate = GETDATE()-'1900-01-01 12:00:00'
END

if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()
END

---------------------------------------------------------------------------------------
print'Preselect and join H_alarm with L_error.'
--also join rt_sys_events 0 and 1 (disconnect and controller side block) give this a servity of 11
--WATCH OUT ! I added id = 0 to the L_error table to represent the 2 events
--id	error_number	error_severity	error_text							Appl_id	Subgroup_id
--0		99010			11				Controller disconnected / Watchdog	1		1
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#Error') is not null) drop table #Error
(
SELECT * INTO  #Error
FROM
(
	SELECT 
	 L.id 
	,H._timestamp
	,H.c_timestamp
	,H.controller_id
	,H.error_id
	,L.[error_number]
	,L.[error_severity]
	,L.error_text 
	FROM GADATA.C3G.h_alarm as h 
	LEFT JOIN GADATA.C3G.L_error as L 
	on L.id = h.error_id 
	WHERE 
	H._timestamp  BETWEEN @StartDate AND  @EndDate 
	AND L.[error_severity] <> -1

	UNION --union disconnect an watchdog events 
	SELECT  
	 0 as 'id' 
	,H._timestamp
	,H._timestamp as 'C_timestamp'
	,H.controller_id
	,H.sys_state as 'error_id'
	,H.sys_state as 'error_number'
	,11 as 'error_severity'
	,'Disconnected OR controller watchdog' as 'error_text'
	FROM GADATA.C3G.rt_sys_event as h 
	WHERE 
	H._timestamp  BETWEEN @StartDate AND @EndDate 
	AND 
	H.sys_state in(0,1)
) as x
)	
---------------------------------------------------------------------------------------

SELECT Act.[Location]
      ,[Robotname]
     -- ,[controller_id]
     -- ,[enable_bit]
      ,[Timestamp]
	  ,DATEDIFF(minute,timestamp,getdate()) as 'DT'
     ,[Logtekst]
      ,[sys_state]
      ,[robstate]
    --  ,[rn]
	  , ROW_NUMBER() OVER (PARTITION BY Act.controller_id ORDER BY T_a._timestamp ASC) AS TriggerIndx --index op de mogelijke 'trigger errors' idx 1 is normaal de trigger
	  ,T_a.error_text
  FROM [GADATA].[C3G].[ActiveState] as Act

 --join last 'uptime' einde van laatste storing. (om te weten hoe ver in de error log je mag terug zoeken)
    LEFT JOIN GADATA.C3G.Uptime as Up
	  ON (act.controller_id = up.controller_id)

  --Join mogelijke errors in 'Trigger' timeslot => Dit is de poging om de errorcode te vinden die als 'trigger' van de breakdown kan worden gezien.
---------------------------------------------------------
	LEFT JOIN #Error as T_a
	   ON (
		(Act.controller_id = T_a.controller_id) 
		AND
		--fout moet zicht voordoen tussen de 30 seconden voor of + 1 min na de trigger (gebruikt _timestamp = moment van insert)
		(T_a.C_timestamp BETWEEN Up.lastOK AND getdate())
		AND
		(T_a.[error_severity] >= 4) --een trigger fout moet minsten severity 4 zijn
	      )
---------------------------------------------------------
  where robstate = 0
  and sys_state not in(0,1) -- ja voorlopig omdat H_err nog niet overal draait... (anders krijg je overal disconnect of watchdogs)

END