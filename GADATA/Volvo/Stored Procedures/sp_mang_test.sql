
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
SET @StartDate = getdate()-60


SELECT 
  dbo.c_controller.location AS 'Location'
, dbo.c_controller.controller_name AS 'Robotname'
, ISNULL(LRA.APPL, LA.APPL) AS 'Object'
, ISNULL(LRS.Subgroup, LS.Subgroup) AS 'Subgroup'
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
, ISNULL(('|R: ' + LR.error_text), L.error_text ) AS 'Logtekst'

FROM   GADATA.C4G.h_breakdown as H 
INNER JOIN dbo.c_controller ON H.controller_id = dbo.c_controller.id 
--join L_error (normal cause)
LEFT OUTER JOIN GADATA.C4G.L_error  AS L ON 
L.id = H.error_id 
--join L_error (special cause)
LEFT OUTER JOIN GADATA.C4G.L_error AS lR ON
H.RC_error_id = LR.id
AND
H.RC_error_id IS NOT NULL
--appl (normal cause)
LEFT OUTER JOIN
GADATA.C4g.c_Appl as LA ON (LA.id =L.Appl_id) 
--subgroup (normal cause)
 LEFT OUTER JOIN
gadata.c4g.C_subgroup as LRS ON (LRS.id = LR.subgroup_id) 
--appl (special cause)
LEFT OUTER JOIN
GADATA.C4g.c_Appl as LRA ON (LRA.id = LR.Appl_id) 
--subgroup (special cause)
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
(dbo.c_controller.location  LIKE '%UB9%') --locatie moet gekend zijn 


order by H.StartOfBreakdown desc 
END