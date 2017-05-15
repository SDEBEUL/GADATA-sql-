



CREATE VIEW [GLUE].[viewerToolDavid]

AS


SELECT
  output.Location AS 'Location' 
, output.robotname		AS 'Robotname'
, output.type			AS 'Type'
, output.errortype		AS 'Errortype'
, CONVERT(char(19),output.timestamp, 120) AS 'timestamp'
, output.logcode		AS 'Logcode'
, output.severity		AS 'Severity'
, output.logtekst		AS 'Logtekst'
, output.downtime		AS 'Downtime'
, output.year			AS 'Year'
, output.week			AS 'Week'
, output.day			AS 'day'
, output.shift AS 'Shift'
, output.object			AS 'Object'
, output.Subgroup		AS 'Subgroup'
, output.idx		    AS 'idx'
FROM
(

--***********************************************************************************************************************--
--COMAU C4G
--***********************************************************************************************************************--

--C4G Qry Breakdowns (einde van storings met storings tijd)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

SELECT * FROM GADATA.C4G.OLD_breakdown as B
WHERE 
--Datetime filter
 (B.[Timestamp]  BETWEEN GETDATE()  - '1900-02-14 00:00:00' AND GETDATE())


---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C4G Alarm information (error log)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--UNION
--SELECT * FROM GADATA.C4G.Error AS C4GE
--WHERE 
----datetime filter
--(C4GE.[Timestamp] BETWEEN GETDATE()  - '1900-02-14 00:00:00' AND GETDATE())

---------------------------------------------------------------------------------------

--***********************************************************************************************************************--
--COMAU C3G
--***********************************************************************************************************************--

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C3G Alarm information (error log)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--UNION
--SELECT * FROM GADATA.C3G.Error AS C3GE

--WHERE
----date time filter
--(C3GE.[timestamp] BETWEEN GETDATE()  - '1900-02-14 00:00:00' AND GETDATE())

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--C3G Qry Breakdowns (einde van storings met storings tijd)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
UNION
SELECT * FROM GADATA.C3G.old_Breakdown as B
WHERE 
--Datetime filter
 (B.[Timestamp]  BETWEEN GETDATE()  - '1900-02-14 00:00:00' AND GETDATE())) as output

---------------------------------------------------------------------------------------
---------------------

---------

---------------------------------------------------------------------------------------

UNION
SELECT
  output.Robotname AS 'Location' 
, output.robotname		AS 'Robotname'
, output.type			AS 'Type'
, output.errortype		AS 'Errortype'
, CONVERT(char(19),output.timestamp, 120) AS 'timestamp'
, output.logcode		AS 'Logcode'
, output.severity		AS 'Severity'
, output.logtekst		AS 'Logtekst'
, output.downtime		AS 'Downtime'
, output.year			AS 'Year'
, output.week			AS 'Week'
, output.day			AS 'day'
, output.shift AS 'Shift'
, output.object			AS 'Object'
, output.Subgroup		AS 'Subgroup'
, output.idx		    AS 'idx'
FROM
(
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Timeline
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
SELECT 
T.Location
,T.Robotname
,T.[Type]
,T.Errortype
,T.[Timestamp]
,T.Logcode
,T.Severity
,T.Logtekst
,T.DOWNTIME
,T.[Year]
,T.[Week]
,T.[day]
,T.[Shift] as 'shift'
,T.[Object]
,T.Subgroup
,T.id as 'idx'
FROM GADATA.Volvo.Timeline AS T
WHERE
--datetime filter
(T.[Timestamp]  BETWEEN GETDATE()  - '1900-02-14 00:00:00' AND GETDATE())

---------------------------------------------------------------------------------------
) as output
--***********************************************************************************************************************--