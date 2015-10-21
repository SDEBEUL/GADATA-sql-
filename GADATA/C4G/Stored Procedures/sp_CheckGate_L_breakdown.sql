CREATE PROCEDURE [C4G].[sp_CheckGate_L_breakdown]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @Show as bit = 0,
   @Robotname as varchar(50) = '%',
   @controller_id as int = 13
AS
BEGIN


---------------------------------------------------------------------------------------
print 'Running: [C4G].[sp_CheckGate_L_breakdown]'
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1

---------------------------------------------------------------------------------------
print'Pull dataset van H_alarm/L_error. Get only Gatestops (to speed up performance)'
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#C4Gerror') is not null) drop table #C4Gerror
       (
	   SELECT 
	    H.id
	   ,H._timestamp
	   ,H.controller_id
       into #C4Gerror
       FROM GADATA.C4G.h_alarm as H
	   LEFT JOIN GADATA.c4G.L_error as L on L.id = H.error_id
	   WHERE H._timestamp BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())
		AND
		(L.id IN(1173,9585))
		)
 --safety gate 1173
 --saftey gate 2 9585
 --Hold from fieldbus 6319
	 
---------------------------------------------------------------------------------------
--SELECT TOP 10 * FROM #C4Gerror --where controller_id =  @controller_id order by _timestamp desc 
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
print'Call CheckGate'
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#C4GCheckGate') is not null) drop table #C4GCheckGate
(
SELECT 
       Hb.id
      ,Hb.[controller_id]
      ,Hb.[EndOfBreakdown]
      ,Hb.[StartOfBreakdown]
      ,Hb.[Trig_state]
      ,Hb.[Trig_id]
      ,Hb.[Rt]
      ,Hb.[error_id]
	  ,NULL as 'Rclas_id'
	  ,1 as 'NoGs'
  INTO #C4GCheckGate
  FROM [GADATA].[C4G].[h_breakdown] AS Hb
  LEFT JOIN #C4Gerror AS GS on 
  (
  (GS.controller_id = HB.controller_id)
  AND
  (GS._timestamp BETWEEN (HB.StartOfBreakdown - '1900-01-01 00:00:05:000') AND HB.EndOfBreakdown) --take 5 s of start to be sure we have the window
  )
   
   where 
   Hb.EndOfBreakdown BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())
   AND 
   GS.id is null
) 
---------------------------------------------------------------------------------------


If (@Show = 1)
BEGIN
---------------------------------------------------------------------------------------
print'Show alternative causes for a breakdown.'
---------------------------------------------------------------------------------------
SELECT 
C.controller_name
,* 
FROM #C4GCheckGate
LEFT JOIN GADATA.c4g.c_controller as C  ON C.id = #C4GCheckGate.controller_id 
WHERE 
c.controller_name LIKE ('%' + @Robotname +'%')

order by EndOfBreakdown desc  
END
---------------------------------------------------------------------------------------

If (@Show = 0)
BEGIN
---------------------------------------------------------------------------------------
print'Reclass Update'
---------------------------------------------------------------------------------------
INSERT INTO GADATA.C4G.[h_NoGateStop]
SELECT 
gs.id
FROM #C4GCheckGate as gs
LEFT JOIN GADATA.C4G.[h_NoGateStop] as H ON GS.id = H.Breakdown_id
WHERE H.ID is null
END
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Activity log (logs the execution of the Query to a table)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

DECLARE @rowcountmen as int 
SET @rowcountmen = @@rowcount
DECLARE @RequestString as varchar(255)
SET @RequestString = 'Running: [C4G].[sp_CheckGate_L_breakdown]'
EXEC GADATA.volvo.sp_Alog  @rowcount = @rowcountmen, @Request = @RequestString

---------------------------------------------------------------------------------------
END