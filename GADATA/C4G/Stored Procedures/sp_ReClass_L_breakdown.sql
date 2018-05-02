CREATE PROCEDURE [C4G].[sp_ReClass_L_breakdown]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @Show as bit = 0,
   @Robotname as varchar(50) = '%',
   @controller_id as int = 13
AS
BEGIN


---------------------------------------------------------------------------------------
print 'Running: [C4G].[sp_ReClass_L_breakdown]'
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1

---------------------------------------------------------------------------------------
print'Pull dataset van H_alarm/L_error. (to speed up performance)'
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#C4Gerror') is not null) drop table #C4Gerror
       (
	   SELECT 
	    H.id
	   ,H._timestamp
	   ,H.controller_id
	   ,H.error_id
	   ,L.[error_number]
	   ,L.[error_severity]
	   ,L.error_text
       into #C4Gerror
       FROM GADATA.C4G.h_alarm as H
	   LEFT JOIN GADATA.c4G.L_error as L on L.id = H.error_id
	   WHERE H._timestamp BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())
	    AND
		(L.id <> 1173) --safety gate
		AND
		(L.id <> 9585) --saftey gate 2
		AND 
		(L.id <> 6319) --Hold from fieldbus
	   )
---------------------------------------------------------------------------------------
--SELECT TOP 10 * FROM #C4Gerror where controller_id =  @controller_id order by _timestamp desc 
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
print'Call Reclass'
---------------------------------------------------------------------------------------
if (OBJECT_ID('tempdb..#C4GRclass') is not null) drop table #C4GRclass
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
	  ,Err.error_id as 'Rclas_id'
	  ,Err.error_text
	  ,Err.error_severity
	  ,ROW_NUMBER() OVER (PARTITION BY Hb.id ORDER BY Err.[error_severity] DESC) as 'Rn' 
  INTO #C4GRclass
  FROM [GADATA].[C4G].[h_breakdown] AS Hb
  LEFT JOIN #C4Gerror as Err on 
  (Err.controller_id = Hb.controller_id)
  AND
(
	(
	(Err._timestamp BETWEEN HB.StartOfBreakdown AND (HB.EndOfBreakdown)) 
	AND
	(Err.[error_severity] > 2)
	AND
	(Hb.error_id <> Err.error_id) --added for GB
	)
  OR 
	(
	(Err._timestamp BETWEEN HB.StartOfBreakdown AND (HB.EndOfBreakdown + '1900-01-01 00:03:00')) --3 min bij omdat tips have been changed ...
	AND
	(Err.error_text LIKE '%tips have been changed%') 
	)
)
   where  
   Hb.EndOfBreakdown BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())
   AND 
   Hb.error_id IN(1173,9585,6319,1008,4165,21958,22070) --only reclas gatestops (and dsa error upon drive on ..)
   --added last 2 for GB
   AND 
   Err.error_id is not null --mag enkel door als er iets beter gevonden is.
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
FROM #C4GRclass
LEFT JOIN GADATA.C4G.c_controller as C  ON C.id = #C4GRclass.controller_id 
WHERE 
c.controller_name LIKE ('%' + @Robotname +'%')
--AND 
--#C4GRclass.Rn = 1 --enkel 'beste' reclas id mag door
order by EndOfBreakdown desc  
END
---------------------------------------------------------------------------------------

If (@Show = 0)
BEGIN
---------------------------------------------------------------------------------------
print'Reclass Update'
---------------------------------------------------------------------------------------
UPDATE HB
SET HB.RC_error_id = RB.Rclas_id
--SELECT TOP 10 * 
FROM GADATA.C4G.h_breakdown As HB
LEFT JOIN #C4GRclass as RB on RB.id = HB.id
WHERE 
HB.EndOfBreakdown BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())
AND
RB.Rn = 1 --enkel 'beste' relcas id word gebruikt
AND
HB.RC_error_id is null --enkel update doen als hij nog niet gebeurd is.
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
SET @RequestString = 'Running: [C4G].[sp_ReClass_L_breakdown]'
EXEC GADATA.volvo.sp_Alog  @rowcount = @rowcountmen, @Request = @RequestString
---------------------------------------------------------------------------------------
END