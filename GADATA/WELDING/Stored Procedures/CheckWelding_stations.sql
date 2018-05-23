
-- ============================================= 
-- Author:     Coppejans Jens
-- Create date:  08/05/2018
-- Description:   
-- ============================================= 
CREATE PROCEDURE [WELDING].[CheckWelding_stations] 
AS 
  BEGIN 
      -- SET NOCOUNT ON added to prevent extra result sets from 
      -- interfering with SELECT statements. 
      SET nocount ON; 

      -- Insert statements for procedure here 
      -------------------------------------------------------CHECK ON ROBOT LEVEL---------------------------------------------- 
      ------------------------------------------------------------------------------------------------------------------------- 
      ------------------------------------------------------------------------------------------------------------------------- 
      --- check robot is welded with weldmeasurements 
      CREATE TABLE #tempcountalljobslast8hours 
        ( 
           robot      NCHAR(25), 
           countjobs  INT, 
           vyear      INT, 
           vweek      INT, 
           vday       INT, 
           shift      INT, 
           timelineid INT 
        ) 

      INSERT INTO #tempcountalljobslast8hours 
      SELECT ngac.c_controller.controller_name, 
             Count(ngac.rt_job.ts_start) AS countOfJobs, 
             volvo.l_timeline.vyear, 
             volvo.l_timeline.vweek, 
             volvo.l_timeline.vday, 
             volvo.l_timeline.shift, 
             volvo.l_timeline.id 
      FROM   ngac.rt_job 
             INNER JOIN ngac.c_controller 
                     ON ngac.rt_job.c_controller_id = ngac.c_controller.id 
                        AND ngac.rt_job.c_controller_id = ngac.c_controller.id 
             RIGHT OUTER JOIN volvo.l_timeline 
                           ON ngac.rt_job.ts_start BETWEEN 
                              volvo.l_timeline.starttime AND 
                              volvo.l_timeline.endtime 
      WHERE  ( ngac.rt_job.ts_start >= Dateadd(hh, -8, Getdate()) ) 
      GROUP  BY ngac.c_controller.controller_name, 
                volvo.l_timeline.vyear, 
                volvo.l_timeline.vweek, 
                volvo.l_timeline.vday, 
                volvo.l_timeline.shift, 
                volvo.l_timeline.id 

      -- check the avg of spotwelds last 8 hours 
      CREATE TABLE #tempavgweldslastshift 
        ( 
           timerid         INT, 
           robot           NCHAR(25), 
           sumwelds        INT, 
           timelineidtimer INT 
        ) 

      INSERT INTO #tempavgweldslastshift 
      SELECT dbo.timer.id 
             AS 
             timerID, 
             dbo.timer.robot 
             AS 
             robot, 
             Sum(dbo.weldmeasurements.nbrweld - dbo.weldmeasurements.nbrreweld) 
             AS 
             SUMWelds, 
             volvo.l_timeline.id 
      FROM   dbo.timer 
             INNER JOIN dbo.spot 
                     ON dbo.timer.id = dbo.spot.timerid 
                        AND dbo.timer.id = dbo.spot.timerid 
                        AND dbo.timer.id = dbo.spot.timerid 
             INNER JOIN dbo.weldmeasurements 
                     ON dbo.spot.id = dbo.weldmeasurements.spotid 
                        AND dbo.spot.id = dbo.weldmeasurements.spotid 
                        AND dbo.spot.id = dbo.weldmeasurements.spotid 
             INNER JOIN volvo.l_timeline 
                     ON dbo.weldmeasurements.l_timelineid = volvo.l_timeline.id 
      WHERE  ( dbo.weldmeasurements.date >= Dateadd(hh, -14, Getdate()) ) 
      GROUP  BY dbo.timer.id, 
                dbo.timer.robot, 
                volvo.l_timeline.id 

      --join the 2 temp tables 
      CREATE TABLE #tempchecknewrecords 
        ( 
           timerid    INT, 
           timelineid INT, 
           vyear      INT, 
           vweek      INT, 
           vday       INT, 
           shift      INT, 
           countjobs  INT, 
           sumwelds   INT, 
           ratio      INT 
        ) 

      INSERT INTO #tempchecknewrecords 
      SELECT timerid, 
             timelineid, 
             vyear, 
             vweek, 
             vday, 
             shift, 
             countjobs, 
             sumwelds, 
             sumwelds / countjobs AS ratio --must be the same and not null 
      FROM   #tempcountalljobslast8hours 
             INNER JOIN #tempavgweldslastshift 
                     ON #tempcountalljobslast8hours .robot = 
                        #tempavgweldslastshift.robot 
                        AND #tempcountalljobslast8hours.timelineid = 
                            #tempavgweldslastshift.timelineidtimer 

      -- check diff from  [GADATA].[WELDING].[ControleWelding_ratio] 
      CREATE TABLE #tempcheckdiff 
        ( 
           timerid          INT, 
           timelineid       INT, 
           vyear            INT, 
           vweek            INT, 
           vday             INT, 
           shift            INT, 
           countjobs        INT, 
           sumwelds         INT, 
           ratio            INT, 
           ration           INT, 
           checkweldprocess NCHAR (25) 
        ) 

      INSERT INTO #tempcheckdiff 
      SELECT #tempchecknewrecords.timerid, 
             timelineid, 
             vyear, 
             vweek, 
             vday, 
             shift, 
             countjobs, 
             sumwelds, 
             ratio, 
             [WELDING].[controlewelding_ratio].ration, 
             CASE 
               WHEN ratio = [WELDING].[controlewelding_ratio].ration THEN 
               'WELDING OK' 
               ELSE 'ROBOT NOT WELDING' 
             END AS Checkweldprocess 
      FROM   #tempchecknewrecords 
             INNER JOIN [WELDING].[controlewelding_ratio] 
                     ON #tempchecknewrecords.timerid = 
                        [WELDING].[controlewelding_ratio].timerid 

--delete old records in [WELDING].[controlewelding_stations] 

      DELETE FROM [GADATA].[WELDING].[controlewelding_stations] 

--insert new records 

      INSERT INTO [GADATA].[WELDING].[controlewelding_stations] 
      SELECT #tempcheckdiff.timerid, 
             timelineid, 
             vyear, 
             vweek, 
             vday, 
             shift, 
             countjobs, 
             sumwelds, 
             ratio, 
             checkweldprocess 
      FROM   #tempcheckdiff 
             INNER JOIN [WELDING].[controlewelding_ratio] 
                     ON #tempcheckdiff.timerid = 
                        [WELDING].[controlewelding_ratio].timerid 
    

      DROP TABLE #tempcountalljobslast8hours 

      DROP TABLE #tempavgweldslastshift 

      DROP TABLE #tempchecknewrecords 

      DROP TABLE #tempcheckdiff 
  END