


CREATE PROCEDURE [EqUi].[GetErrorTrentData]
  @Location as varchar(max) = null
 ,@ERRORNUM as int = null -- why not use the index of the l_error ? might be smarter 
 ,@Logtext as varchar(max) = null
 ,@logType as varchar(max) = null
 ,@refId as int = null
AS
BEGIN
-- Remove hash tag from location
SET @Location = REPLACE(@location,'#','')

DECLARE @controllerID as int = (select top 1 controller_id from gadata.equi.ASSETS where RTRIM(location) = @Location)
DECLARE @controllerTYPE as varchar(10) = (select top 1 controller_type from gadata.equi.ASSETS where RTRIM(location) = @Location)

--COMAU C4G ALARMS***************************************************************************************--
if @controllerTYPE = 'c4g'
BEGIN
SELECT 
  h.c_timestamp as 'starttime'
FROM gadata.c4g.h_alarm as h 
left join gadata.c4g.l_error as l on l.id = h.error_id
where l.[error_number] = @errornum and h.controller_id = @controllerID
END

--COMAU C3G ALARMS***************************************************************************************--
if @controllerTYPE = 'c3g'
BEGIN
SELECT
  h.c_timestamp as 'starttime'
FROM gadata.c3g.h_alarm as h 
left join gadata.c3g.l_error as l on l.id = h.error_id
where l.[error_number] = @errornum and h.controller_id = @controllerID
END

--ALERTS****************************************************************************************************--
if @logType = 'ALERT'
BEGIN
SELECT
  h._timestamp as 'starttime'
FROM gadata.Alerts.h_alert as h 
left join gadata.Alerts.c_triggers as c on c.id = h.c_tirgger_id
where c.id = @errornum and h.location = @Location
END

--ABB NGAC ControllerEvent***************************************************************************************--
if @controllerTYPE = 'NGAC' AND @logType in('ControllerEvent','LIVE')
BEGIN
IF @refId is not null
BEGIN
	SET @Logtext = (SELECT TOP 1 Logtext FROM GADATA.NGAC.ControllerEventLog WHERE refId = @refid)
END

	SELECT
	  h.[timestamp]  as 'starttime'
	FROM gadata.NGAC.ControllerEventLog as h 
	WHERE 
	h.controller_name = @Location
	AND
	h.Logcode = @ERRORNUM
	AND
	@Logtext like h.logtext+'%' --because can be logtext or fulllogtext
	AND 
	h.[timestamp] < getdate()
	order by h.[timestamp] ASC
END

--ABB NGAC BREAKDOWN***************************************************************************************--
if @controllerTYPE = 'NGAC' AND @logType = 'BREAKDOWN'
BEGIN
IF @refId is not null
BEGIN
	SET @Logtext = (SELECT TOP 1 Logtext FROM GADATA.NGAC.Breakdown WHERE refId = @refid)
END

	SELECT
	  h.[timestamp]  as 'starttime'
	FROM gadata.NGAC.Breakdown as h 
	WHERE 
	h.controller_name = @Location
	AND
	h.Logcode = @ERRORNUM
	AND
	@Logtext like h.logtext+'%' --because can be logtext or fulllogtext
	AND 
	h.[timestamp] < getdate()
	order by h.[timestamp] ASC
END

--ABB NGAC ErrDispLog***************************************************************************************--
if @controllerTYPE = 'NGAC' AND @logType = 'ErrDispLog'
BEGIN
	SELECT
	  h.[timestamp]  as 'starttime'
	FROM gadata.NGAC.ErrDispLog as h 
	WHERE 
	h.controller_name = @Location
	AND
	h.Logcode = @ERRORNUM
	AND
	@Logtext like h.logtext+'%' --because can be logtext or fulllogtext
	AND 
	h.[timestamp] < getdate()
	order by h.[timestamp] ASC
END

--ABB NGAC ErrDispLog***************************************************************************************--
if @controllerTYPE = 'S4C' AND @logType = 'ErrDispLog'
BEGIN
	SELECT
	  h.[timestamp]  as 'starttime'
	FROM gadata.S4C.ErrDispLog as h 
	WHERE 
	h.controller_name = @Location
	AND
	h.Logcode = @ERRORNUM
	AND
	@Logtext like h.logtext+'%' --because can be logtext or fulllogtext
	AND 
	h.[timestamp] < getdate()
	order by h.[timestamp] ASC
END
END