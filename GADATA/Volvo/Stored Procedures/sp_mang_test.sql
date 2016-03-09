
CREATE PROCEDURE [Volvo].[sp_mang_test]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null
AS
BEGIN


---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------

SET @EndDate = getdate()
SET @StartDate = '2015-05-01 00:00:00.000' -- getdate()-80

---------------------------------------------------------------------------------------
--c4g 
---------------------------------------------------------------------------------------
SELECT 
  c.location AS 'Location'
, c.controller_name AS 'Robotname'
, LA.APPL AS 'Object'
, LS.Subgroup AS 'Subgroup'
, T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'day'
, T.ploeg AS 'Ploeg'
,CASE 
    WHEN (H.endofbreakdown - h.startofbreakdown) < '1900-01-01 00:15:00.00' THEN '0..15'
	WHEN (H.endofbreakdown - h.startofbreakdown) < '1900-01-01 01:00:00.00' THEN '15..60'
	ELSE '60..>'
	END as 'Dtgroep'
, DATEDIFF(SECOND, H.StartOfBreakdown, H.EndOfBreakdown) AS 'DownT'
, DATEDIFF(SECOND,'1900-01-01 00:00:00.00',H.Rt) as 'ResponseT'
, DATEDIFF(SECOND,(H.StartOfBreakdown +  H.Rt),H.EndOfBreakdown) as 'ReolveT'
, L.error_text  AS 'Logtekst'
, DATEPART(QUARTER, H.StartOfBreakdown) as 'QUARTER'
, H.StartOfBreakdown AS 'timestamp'
, 'c4g' as 'source'

FROM   GADATA.C4G.h_breakdown as H 
INNER JOIN c4g.c_controller as C ON H.controller_id = c.id 
--join L_error (normal cause)
LEFT OUTER JOIN GADATA.C4G.L_error  AS L ON 
L.id = H.error_id 
--appl (normal cause)
LEFT OUTER JOIN
GADATA.C4g.c_Appl as LA ON (LA.id =L.Appl_id) 
 LEFT OUTER JOIN
gadata.c4g.C_subgroup as LS ON (LS.id = L.subgroup_id) 
--timeline						 --
LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
H.EndOfBreakdown BETWEEN T.starttime AND T.endtime

where
(LS.subgroup NOT LIKE '%Gate/Hold%') --geen gatestops (enkel rootcause storingen gebruiken)
AND
(LS.subgroup NOT LIKE '%Water%') --koelwaterfouten eraf. (opstart)
AND
(T.ploeg NOT LIKE 'WE') --niet in weekend
AND
((H.EndOfBreakdown - H.StartOfBreakdown) < '1900-01-01 03:00:00.00') --storingen meer dan X uur eraf. (ook weekend probs)
AND
(H.StartOfBreakdown BETWEEN  @StartDate and @EndDate)
AND 
(c.location  LIKE '%%') --locatie moet gekend zijn 
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--c3g 
---------------------------------------------------------------------------------------
UNION
SELECT 
  c.location AS 'Location'
, c.controller_name AS 'Robotname'
, LA.APPL AS 'Object'
, LS.Subgroup AS 'Subgroup'
, T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'day'
, T.ploeg AS 'Ploeg'
,CASE 
    WHEN (H.endofbreakdown - h.startofbreakdown) < '1900-01-01 00:15:00.00' THEN '0..15'
	WHEN (H.endofbreakdown - h.startofbreakdown) < '1900-01-01 01:00:00.00' THEN '15..60'
	ELSE '60..>'
	END as 'Dtgroep'
, DATEDIFF(SECOND, H.StartOfBreakdown, H.EndOfBreakdown) AS 'DownT'
, DATEDIFF(SECOND,'1900-01-01 00:00:00.00',H.Rt) as 'ResponseT'
, DATEDIFF(SECOND,(H.StartOfBreakdown +  H.Rt),H.EndOfBreakdown) as 'ReolveT'
, L.error_text  AS 'Logtekst'
, DATEPART(QUARTER, H.StartOfBreakdown) as 'QUARTER'
, H.StartOfBreakdown AS 'timestamp'
, 'c3g' as 'source'

FROM   GADATA.C3G.h_breakdown as H 
INNER JOIN C3G.c_controller as C ON H.controller_id = c.id 
--join L_error (normal cause)
LEFT OUTER JOIN GADATA.C3G.L_error  AS L ON 
L.id = H.error_id 
--appl (normal cause)
LEFT OUTER JOIN
GADATA.C3G.c_Appl as LA ON (LA.id =L.Appl_id) 
--subgroup (normal cause)
 LEFT OUTER JOIN
gadata.C3G.C_subgroup as LS ON (LS.id = L.subgroup_id) 
--timeline						 --
LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
H.EndOfBreakdown BETWEEN T.starttime AND T.endtime

where
(LS.subgroup NOT LIKE '%Gate/Hold%') --geen gatestops (enkel rootcause storingen gebruiken)
AND
(LS.subgroup NOT LIKE '%Water%') --koelwaterfouten eraf. (opstart)
AND
(LA.APPL NOT LIKE '%N/A%') --niet gekende objecten weg
AND
(T.ploeg NOT LIKE 'WE') --niet in weekend
AND
((H.EndOfBreakdown - H.StartOfBreakdown) < '1900-01-01 03:00:00.00') --storingen meer dan X uur eraf. (ook weekend probs)
AND
(H.StartOfBreakdown BETWEEN  @StartDate and @EndDate)
AND 
(c.location  LIKE '%%') --locatie moet gekend zijn 
---------------------------------------------------------------------------------------



order by H.StartOfBreakdown desc 
END