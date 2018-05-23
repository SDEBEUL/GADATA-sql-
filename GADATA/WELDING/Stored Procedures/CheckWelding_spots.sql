-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE welding.CheckWelding_spots

AS
BEGIN

	SET NOCOUNT ON;


-------------------------------------------------------CHECK ON SPOTLEVEL----------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------


---All jobs with spots -- on spot level

CREATE TABLE #temprobotjob_spot 
  (  
     robot  NCHAR(25), 
     number INT, 
     orders INT 
  ) 

INSERT INTO #temprobotjob_spot 
SELECT         dbo.Timer.Robot, dbo.Spot.Number, WELDING.RobotJob_spot.[order]
FROM            dbo.Timer INNER JOIN
                         dbo.Spot ON dbo.Timer.ID = dbo.Spot.TimerID AND dbo.Timer.ID = dbo.Spot.TimerID AND dbo.Timer.ID = dbo.Spot.TimerID AND dbo.Timer.ID = dbo.Spot.TimerID AND 
                         dbo.Timer.ID = dbo.Spot.TimerID INNER JOIN
                         WELDING.RobotJob_spot ON dbo.Spot.Number = WELDING.RobotJob_spot.spotnumber
ORDER BY dbo.Timer.Robot DESC

-- count job Last 8 hours 
CREATE TABLE #tempcountjobs
  (  
     robot  NCHAR(25), 
     job INT, 
     countJoborders INT ,
	 Vyear int,
	 Vweek int,
	 Vday int,
	 shift int,
	 timelineID int
  ) 
INSERT INTO #tempcountjobs
SELECT  ngac.c_controller.controller_name, 
                         ngac.rt_job.jobno, 
                         Count(ngac.rt_job.ts_start) AS countOfJobs ,L_timeline.Vyear,L_timeline.Vweek,L_timeline.Vday,L_timeline.shift, L_timeline.id
FROM   ngac.rt_job 
       INNER JOIN ngac.c_controller 
               ON ngac.rt_job.c_controller_id = ngac.c_controller.id 
                  AND ngac.rt_job.c_controller_id = ngac.c_controller.id RIGHT OUTER JOIN
                         Volvo.L_timeline ON NGAC.rt_job.ts_Start BETWEEN Volvo.L_timeline.starttime AND Volvo.L_timeline.endtime

WHERE  ( ngac.rt_job.ts_start >= DATEADD(hh,-8,Getdate() ))
GROUP  BY ngac.c_controller.controller_name, 
          ngac.rt_job.jobno ,L_timeline.Vyear,L_timeline.Vweek,L_timeline.Vday,L_timeline.shift, L_timeline.id

--combine All jobs with spots with count jobs last 8 hours spot level
CREATE TABLE #tempcombineJobsLast8Hours
  (  
     robot  NCHAR(25),
	 spot int, 
     orders INT, 
     countJoborders INT ,
	 Vyear int,
	 Vweek int,
	 Vday int,
	 shift int,
	 timelineID int
  )
insert into  #tempcombineJobsLast8Hours  
SELECT #temprobotjob_spot.robot,number as spot, orders, countJoborders, Vyear, Vweek, Vday,shift, timelineID  from #temprobotjob_spot  inner join #tempcountjobs on #temprobotjob_spot.robot = #tempcountjobs.robot AND 
#tempcountjobs.job = #temprobotjob_spot.orders


--count all jobs with welds from weldtimers ----- on spot level

SELECT #tempcombineJobsLast8Hours.robot,
dbo.spot.Number,
#tempcombineJobsLast8Hours.orders,
#tempcombineJobsLast8Hours.countJoborders,
#tempcombineJobsLast8Hours.Vyear,
#tempcombineJobsLast8Hours.Vweek,
#tempcombineJobsLast8Hours.Vday,
#tempcombineJobsLast8Hours.shift,
dbo.WeldMeasurements.NbrWeld - dbo.WeldMeasurements.NbrReweld as NbrTimerWelds ,
((dbo.WeldMeasurements.NbrWeld - dbo.WeldMeasurements.NbrReweld) - #tempcombineJobsLast8Hours.countJoborders) as differences

from         dbo.WeldMeasurements INNER JOIN
                         #tempcombineJobsLast8Hours  ON dbo.WeldMeasurements.L_TimelineID = #tempcombineJobsLast8Hours .timelineID INNER JOIN
                         dbo.Spot ON dbo.WeldMeasurements.SpotId = dbo.Spot.ID AND dbo.WeldMeasurements.SpotId = dbo.Spot.ID AND dbo.WeldMeasurements.SpotId = dbo.Spot.ID AND
                          dbo.WeldMeasurements.SpotId = dbo.Spot.ID AND #tempcombineJobsLast8Hours.spot = dbo.Spot.Number
             
ORDER BY differences DESC



DROP TABLE #temprobotjob_spot 
Drop TABLE  #tempcountjobs
Drop table #tempcombineJobsLast8Hours

END