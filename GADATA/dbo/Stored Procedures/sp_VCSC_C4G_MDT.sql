CREATE PROCEDURE [dbo].[sp_VCSC_C4G_MDT]

/*
Oke this was build as a first test...
it is working but here is the issue.
it only gens a tag is there is a breakdown...
because if there is no data it will not count an item...

this start here is L_breakdown... and that was the big mistake

this is where version MDT1 one will come it.

MDT1 will start from TIME
you give a start and end date.
the system must gen a table
WEEK DAY SHIFT for that range.
That will be cross joined with all the robotname
That will be cross joined with all the objects and as follow with al the subgroups.

if we than run the some Counting and stuff on this we are golden



*/
 @StartDate AS datetime = null 
,@EndDate As datetime = null

AS
BEGIN

SET @StartDate = GETDATE()-10
---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

if (OBJECT_ID('tempdb..#Temp_L_breakdownObjectindx') is not null) drop table #Temp_L_breakdownObjectindx
SELECT L_breakdown.controller_id
	   ,L_breakdown.StartOfBreakdown
	   ,L_breakdown.EndOfBreakdown
	   ,DATEPART(WEEK, L_breakdown.StartOfBreakdown) AS WEEK
	   ,DATEPART(WEEKDAY,L_breakdown.StartOfBreakdown)AS 'Day'
	   ,L_breakdown.error_number
	   ,L_breakdown.error_text
	   ,L_breakdown.idx
	   ,c_logclass1.appl AS 'Object'
	   ,c_logclass1.subgroup AS 'Subgroup'
	   ,ROW_NUMBER() OVER (PARTITION BY L_breakdown.controller_id,  c_logclass1.appl, c_logclass1.subgroup, DATEPART(WEEK, L_breakdown.StartOfBreakdown) ORDER BY L_breakdown.idx DESC) AS testindx

INTO #Temp_L_breakdownObjectindx
from L_breakdown
--try and get an error classification
LEFT JOIN GADATA.dbo.c_logclass1 as c_logclass1 ON 
(
(L_breakdown.error_number BETWEEN c_logclass1.error_codeStart AND c_logclass1.error_codeEnd)
OR
(L_breakdown.error_text LIKE c_logclass1.error_tekst)
)

WHERE 
--Datetime filter
 L_breakdown.StartOfBreakdown  BETWEEN ISNULL(@StartDate,GETDATE()-1) AND ISNULL(@EndDate,GETDATE())

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------


if (OBJECT_ID('tempdb..#Temp_L_breakdownCounted') is not null) drop table #Temp_L_breakdownCounted
SELECT  c_controller.controller_name
       ,#Temp_L_breakdownObjectindx.controller_id
	   ,#Temp_L_breakdownObjectindx.StartOfBreakdown
	   ,#Temp_L_breakdownObjectindx.EndOfBreakdown
	   ,#Temp_L_breakdownObjectindx.WEEK
	   ,#Temp_L_breakdownObjectindx.Day
	   --,#Temp_L_breakdownObjectindx.error_number
	   --,#Temp_L_breakdownObjectindx.error_text
	   ,#Temp_L_breakdownObjectindx.idx
	   ,#Temp_L_breakdownObjectindx.Object
	   ,#Temp_L_breakdownObjectindx.subgroup

	   ,convert(Char(8),(#Temp_L_breakdownObjectindx.EndOfBreakdown - #Temp_L_breakdownObjectindx.StartOfBreakdown),108) AS DOWNTIME
	   ,DOWNTIMEmin = DATEDIFF(MINUTE,#Temp_L_breakdownObjectindx.StartOfBreakdown,#Temp_L_breakdownObjectindx.EndOfBreakdown)

	   ,convert(Char(8),(#Temp_L_breakdownObjectindx.StartOfBreakdown - Ltest.EndOfBreakdown),108) AS UPTIME
	   ,UPTIMEmin = DATEDIFF(MINUTE,Ltest.EndOfBreakdown,#Temp_L_breakdownObjectindx.StartOfBreakdown)
	   
	   ,convert(Char(8),(#Temp_L_breakdownObjectindx.StartOfBreakdown - Ltest.StartOfBreakdown),108) AS TBF 
	   ,DATEDIFF(MINUTE, Ltest.StartOfBreakdown,#Temp_L_breakdownObjectindx.StartOfBreakdown) AS TBFmin

	   ,(MAX(#Temp_L_breakdownObjectindx.testindx) OVER (PARTITION BY #Temp_L_breakdownObjectindx.controller_id,  #Temp_L_breakdownObjectindx.object, #Temp_L_breakdownObjectindx.subgroup, #Temp_L_breakdownObjectindx.week, #Temp_L_breakdownObjectindx.Day ORDER BY #Temp_L_breakdownObjectindx.testindx DESC)+1 )AS Cbreakdowns
       ,DATEDIFF(MINUTE,ISNULL(@StartDate,GETDATE()-1),ISNULL(@EndDate,GETDATE())) AS TotalTime

 INTO #Temp_L_breakdownCounted
      
 FROM #Temp_L_breakdownObjectindx
 
 JOIN #Temp_L_breakdownObjectindx Ltest on 

 (#Temp_L_breakdownObjectindx.testindx = (Ltest.testindx -1))
 AND 
 (#Temp_L_breakdownObjectindx.idx <> Ltest.idx)
 AND 
 (#Temp_L_breakdownObjectindx.controller_id = Ltest.controller_id)
 AND 
 (#Temp_L_breakdownObjectindx.Object = Ltest.Object)
 AND
 (#Temp_L_breakdownObjectindx.Subgroup = Ltest.Subgroup)
 AND
 (#Temp_L_breakdownObjectindx.WEEK = Ltest.WEEK)
 AND 
 (#Temp_L_breakdownObjectindx.Day = Ltest.Day)

 JOIN c_controller on c_controller.id = #Temp_L_breakdownObjectindx.controller_id

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT
       #Temp_L_breakdownCounted.controller_name
	   ,#Temp_L_breakdownCounted.week
	   ,#Temp_L_breakdownCounted.Day
       ,#Temp_L_breakdownCounted.Object
	   ,#Temp_L_breakdownCounted.Subgroup
	   ,#Temp_L_breakdownCounted.Cbreakdowns
	   ,(#Temp_L_breakdownCounted.TotalTime  - SUM(DOWNTIMEmin) 
	      OVER (PARTITION BY #Temp_L_breakdownCounted.controller_id,  #Temp_L_breakdownCounted.object, #Temp_L_breakdownCounted.subgroup, #Temp_L_breakdownCounted.week, #Temp_L_breakdownCounted.Day ORDER BY #Temp_L_breakdownCounted.Cbreakdowns DESC)) AS TotalUptime
	   
	   ,SUM(DOWNTIMEmin) OVER  (PARTITION BY #Temp_L_breakdownCounted.controller_id,  #Temp_L_breakdownCounted.object, #Temp_L_breakdownCounted.subgroup, #Temp_L_breakdownCounted.week, #Temp_L_breakdownCounted.Day ORDER BY #Temp_L_breakdownCounted.Cbreakdowns DESC) AS TotalDowntime 
	   
	   ,AVG(DOWNTIMEmin) OVER  (PARTITION BY #Temp_L_breakdownCounted.controller_id,  #Temp_L_breakdownCounted.object, #Temp_L_breakdownCounted.subgroup, #Temp_L_breakdownCounted.week, #Temp_L_breakdownCounted.Day ORDER BY #Temp_L_breakdownCounted.Cbreakdowns DESC) AS MDT
	   
	   ,(
	   #Temp_L_breakdownCounted.TotalTime - SUM(DOWNTIMEmin) 
		OVER  (PARTITION BY #Temp_L_breakdownCounted.controller_id,  #Temp_L_breakdownCounted.object, #Temp_L_breakdownCounted.subgroup, #Temp_L_breakdownCounted.week, #Temp_L_breakdownCounted.Day ORDER BY #Temp_L_breakdownCounted.Cbreakdowns DESC)
	    ) 
			/ #Temp_L_breakdownCounted.Cbreakdowns AS MTBF
	   ,ROUND((CAST(SUM(DOWNTIMEmin) OVER  (PARTITION BY #Temp_L_breakdownCounted.controller_id,  #Temp_L_breakdownCounted.object, #Temp_L_breakdownCounted.subgroup, #Temp_L_breakdownCounted.week, #Temp_L_breakdownCounted.Day ORDER BY #Temp_L_breakdownCounted.Cbreakdowns DESC) AS float) / CAST((DATEDIFF(MINUTE,(getdate()-10),getdate())) AS float) ) *100,3) AS Unavailablity  
FROM #Temp_L_breakdownCounted

where controller_name LIKE '%53110r01%'
ORDER BY week,day DESC
END