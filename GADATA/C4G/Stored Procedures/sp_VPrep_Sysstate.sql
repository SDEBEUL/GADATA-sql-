CREATE PROCEDURE [C4G].[sp_VPrep_Sysstate]

   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
   @Show as bit = 0,
   @Robotname as varchar(50) = '%',
   @controller_id as int = 13
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
SET @StartDate = GETDATE()-1
END

if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()
END
---------------------------------------------------------------------------------------


if (OBJECT_ID('tempdb..#C4GVPrep_Sysstate') is not null) drop table #C4GVPrep_Sysstate
CREATE TABLE #C4GVPrep_Sysstate(
	[id] [int]  NOT NULL,
	[controller_id] [int] NULL,
	[_timestamp] [datetime] NULL,
	[sys_state] [int] NULL,
	[robotstate] [int] NULL,
	[rnDESC] [int] NULL)
---------------------------------------------------------------------------------------

EXEC('
INSERT INTO #C4GVPrep_Sysstate
SELECT      
*
, ROW_NUMBER() OVER (PARTITION BY x.controller_id ORDER BY x._timestamp DESC) AS rnDESC
FROM            
(
/*data from rt_sys_event table. */ 
SELECT 
  rt_sys_event.id
, rt_sys_event.controller_id
, rt_sys_event._timestamp
, rt_sys_event.sys_state
, robotState = dbo.fn_robstate(rt_sys_event.sys_state)
/*calculates a robot state a running robot has 2 a non running one 0 */ 
FROM GADATA.dbo.rt_sys_event AS rt_sys_event
WHERE rt_sys_event._timestamp between getdate()-1 and getdate()
/*data from L_operation (to catch robots goning offline)*/ 
UNION
SELECT        
  l_operation.id
, l_operation.controller_id
, l_operation._timestamp
, sys_state = 262144
, robotState = 0
FROM GADATA.dbo.l_operation AS l_operation
WHERE (l_operation.code = 4)/*connection lost */ 
and 
l_operation._timestamp between getdate()-1 and getdate()
) 
AS x
')

--SELECT * FROM #C4GVPrep_Sysstate
END