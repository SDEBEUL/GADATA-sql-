
CREATE PROCEDURE [Volvo].[sp_AlertCheck]

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
SET @StartDate = GETDATE()-'1900-01-01 23:59:59'
END

if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()
END

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
print 'Check for new C3G sbcu Alerts'
---------------------------------------------------------------------------------------
INSERT INTO GADATA.volvo.ia_Alert (_timestamp,[Type],controller_name,reference_id,[description],Detect_timestamp,controller_type,controller_id,AlertStatus)
SELECT 
 x.[timestamp] as '_timestamp'
,x.Alert_type as 'TYPE'
,x.[Robotname] as 'controller_name'
,x.Reference_ID as 'reference_id'
,x.logtekst as 'description'
,getdate() as 'Detect_timestamp'
,x.Controller_Type as 'controller_type'
,x.Controller_ID 
, 0 as 'AlertStatus' 
FROM GADATA.c3g.SBCUoutOfLimit as x
--to only join NEW alerts 
Left join GADATA.volvo.ia_Alert as alert on
(
(x.Robotname = alert.controller_name)
AND
(alert.[Type] LIKE x.Alert_type)
AND
(
(x.Reference_ID = alert.reference_id) --<== this specific trigger already exicsts
OR
(alert.AlertStatus < 2 ) -- there already is an unconfirmed alert active 
)
)
where
(x.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND
alert.id IS NULL --<== only insert NEW ALERTS
---------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------
print 'Check for new C3G Cylinder Alerts'
---------------------------------------------------------------------------------------

INSERT INTO GADATA.volvo.ia_Alert (_timestamp,[Type],controller_name,reference_id,[description],Detect_timestamp,controller_type,controller_id,AlertStatus)
SELECT 
 x.[timestamp] as '_timestamp'
,x.Alert_type as 'TYPE'
,x.[Robotname] as 'controller_name'
,x.Reference_ID as 'reference_id'
,x.logtekst as 'description'
,getdate() as 'Detect_timestamp'
,x.Controller_Type as 'controller_type'
,x.Controller_ID 
, 0 as 'AlertStatus' 
FROM GADATA.C3G.WeldGunCylinderOutOfLimit as x
--to only join NEW alerts 
Left join GADATA.volvo.ia_Alert as alert on
(
(x.Robotname = alert.controller_name)
AND
(alert.[Type] LIKE x.Alert_type)
AND
(
(x.Reference_ID = alert.reference_id) --<== this specific trigger already exicsts
OR
(alert.AlertStatus < 2 ) -- there already is an unconfirmed alert active 
)
)
where
(x.[Timestamp]  BETWEEN @StartDate AND @EndDate)
AND
alert.id IS NULL --<== only insert NEW ALERTS

---------------------------------------------------------------------------------------

END