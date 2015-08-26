CREATE PROCEDURE ABB.[sp_Update_L_breakdown]
   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null
AS
BEGIN
IF (@EndDate is null)
SET @EndDate = getdate()
IF (@StartDate is null)
SET @StartDate = getdate()-1


--attempt to find 'starting point' in the abb controller.
--Will use Program restarted / program stopped as the guide.
--Starting point will be program restarted active for more than X time 


---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--select dataset from H_alarm. get system up and system down points.
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#ABBssIDX') is not null) drop table #ABBssIDX
BEGIN
SELECT     
 H.controller_id
, H._timestamp
, H.error_id
, ROW_NUMBER() OVER (PARTITION BY h.controller_id ORDER BY h._timestamp DESC) AS rnDESC
--
INTO #ABBssIDX
FROM  ABB.h_alarm AS H
WHERE    H.error_id  in (100,101) --100= programm stopped 101 = program restarted
AND 
H._timestamp between @StartDate and @EndDate
END
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--calculation af Time in state for active and passed events.
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#ABBssTIS') is not null) drop table #ABBssTIS
--first calc Time in state for passed events. (rn desc not 1)
SELECT * INTO #ABBssTIS FROM
(
SELECT 
 x.controller_id
,X._timestamp
,X.error_id
,X.rnDESC
,(lx._timestamp - x._timestamp) as 'Tis' --time in state
FROM #ABBssIDX as x
 JOIN #ABBssIDX as lx on 
(X.controller_id = lx.controller_id)
AND 
(x.rnDESC = lx.rnDESC + 1)
AND 
(x.rnDESC <> 1)
--calc Tis for active event (rn desc is 1)
UNION 
SELECT
 x.controller_id
,X._timestamp
,X.error_id
,X.rnDESC
,(getdate() - x._timestamp) as 'Tis' --time in state
FROM #ABBssIDX as x
where x.rnDESC = 1
) as TIS
where 
(
((TIS.error_id = 101) AND (TIS.Tis > '1900-01-01 00:03:00')) --opstart events enkel door als de robot langer dan X tijd gedraaid heeft.
OR
(TIS.error_id = 100) --stop events mogen altijd door
)
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--nu moeten de dubbel 'stops' er nog af... een stop mag enkel door als deze stop zijn rn + 1 een start is.
--of als deze stop rndesc 1 heeft. (robot staat nu stil)
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#ABBss') is not null) drop table #ABBss
BEGIN
SELECT 
* 
, ROW_NUMBER() OVER (PARTITION BY ABBss.controller_id ORDER BY ABBss._timestamp DESC) AS SSidx
INTO #ABBss 
FROM 
(
SELECT
 X.controller_id
,X._timestamp
,X.error_id
,X.rnDESC
,X.Tis
,lx.rnDESC as 'lx'
FROM #ABBssTIS as x 
JOIN #ABBssTIS as Lx on 
(
(X.controller_id = lx.controller_id)
AND 
(X.error_id = 100)
AND
(lx.error_id = 101)
AND 
(x.rnDESC = lx.rnDESC + 1)
)
UNION
SELECT 
 Y.controller_id
,Y._timestamp
,Y.error_id
,Y.rnDESC
,Y.Tis
, NULL
FROM #ABBssTIS as Y
WHERE 
(Y.error_id = 101) --opstart event mag altijd door
OR
(Y.rnDESC = 1) -- actief event mag altijd door

) as ABBss
END
---------------------------------------------------------------------------------------



if (OBJECT_ID('GADATA.ABB.H_breakdown') is not null) drop table GADATA.ABB.H_breakdown
SELECT 
 Eb.controller_id 
,Eb._timestamp as 'endOfbreakdown'
,SB._timestamp as 'StartofBreakdown'
INTO GADATA.ABB.H_breakdown
FROM #ABBss as Eb
JOIN #ABBss as SB on 
(EB.controller_id = SB.controller_id)
AND 
(eb.error_id = 101) -- end of breakdown is opstart event
AND 
(sb.error_id = 100) -- start of breakdown is stop event. 
AND
(eb.SSidx = sb.SSidx - 1 ) --enkel koppelen naar volgende event 


order by Eb._timestamp desc 
---------------------------------------------------------------------------------------


END