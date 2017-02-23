








CREATE VIEW [GLUE].[timeline]
AS
SELECT DISTINCT
C.Name
,rt.Year
,rt.Week
,rt.Day
FROM GADATA.volvo.timeline as rt 
cross join glue.controller as C