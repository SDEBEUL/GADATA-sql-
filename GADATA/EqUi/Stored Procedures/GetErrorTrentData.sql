

CREATE PROCEDURE [EqUi].[GetErrorTrentData]
  @Location as varchar(max) = null
 ,@ERRORNUM as int = null -- why not use the index of the l_error ? might be smarter 
 ,@Logtext as varchar(max) = null
 ,@logType as varchar(max) = null
AS
BEGIN

DECLARE @controllerID as int = (select top 1 controller_id from gadata.equi.ASSETS where RTRIM(location) = @Location)
DECLARE @controllerTYPE as varchar(10) = (select top 1 controller_type from gadata.equi.ASSETS where RTRIM(location) = @Location)

if @controllerTYPE = 'c4g'
BEGIN
SELECT 
  h.c_timestamp as 'starttime'
, 1 as 'count'
FROM gadata.c4g.h_alarm as h 
left join gadata.c4g.l_error as l on l.id = h.error_id
where l.[error_number] = @errornum and h.controller_id = @controllerID
UNION
SELECT 
  getdate() as 'starttime'
, 0 as 'count'
END

if @controllerTYPE = 'c3g'
BEGIN
SELECT
  h.c_timestamp as 'starttime'
, 1 as 'count'
FROM gadata.c3g.h_alarm as h 
left join gadata.c3g.l_error as l on l.id = h.error_id
where l.[error_number] = @errornum and h.controller_id = @controllerID
UNION
SELECT 
  getdate() as 'starttime'
, 0 as 'count'
END

if @controllerTYPE = 'IRC5'
BEGIN
SELECT
  ISNULL(H._timestamp, H.wd_timestamp)  as 'starttime'
, 1 as 'count'
FROM gadata.abb.h_alarm as h 
left join gadata.abb.l_error as l on l.id = h.error_id
where LTRIM(RTRIM(l.error_text)) = LTRIM(RTRIM(@Logtext)) and h.controller_id = @controllerID
UNION
SELECT 
  getdate() as 'starttime'
, 0 as 'count'
order by ISNULL(H._timestamp, H.wd_timestamp) ASC
END

if @controllerTYPE = 'NGAC' AND @logType = 'ControllerEvent'
BEGIN
	SELECT
	  h.[timestamp]  as 'starttime'
	, 1 as 'count'
	FROM gadata.NGAC.ControllerEventLog as h 
	WHERE 
	h.controller_name = @Location
	AND
	h.Logcode = @ERRORNUM
	AND
	h.Logtext = @Logtext
	AND 
	h.[timestamp] < getdate()
	UNION
	SELECT 
	  getdate() as 'starttime'
	, 0 as 'count'
	order by h.[timestamp] ASC
END

if @controllerTYPE = 'NGAC' AND @logType = 'ErrDispLog'
BEGIN
	SELECT
	  h.[timestamp]  as 'starttime'
	, 1 as 'count'
	FROM gadata.NGAC.ErrDispLog as h 
	WHERE 
	h.controller_name = @Location
	AND
	h.Logcode = @ERRORNUM
	AND
	h.Logtext = @Logtext
	AND 
	h.[timestamp] < getdate()
	UNION
	SELECT 
	  getdate() as 'starttime'
	, 0 as 'count'
	order by h.[timestamp] ASC
END
END