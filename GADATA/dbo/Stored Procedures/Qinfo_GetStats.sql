CREATE PROCEDURE [dbo].[Qinfo_GetStats]
   @Robot as varchar(16) = null
   ,@ErrCode as int = null
AS
BEGIN

DECLARE @IsC4g int 
set @IsC4g = (select c_controller.id from c_controller where c_controller.controller_name = @robot)

--case of C4G robot
IF @IsC4g is not null
BEGIN

SELECT
'Count LastDay:' =
(SELECT count(Error.Logcode) FROM GADATA.C4G.Error WHERE (Robotname = @Robot AND [timestamp] BETWEEN getdate()-1 AND getdate()) AND Error.logcode = @Errcode)

,'Count LastWeek:' =
(SELECT count(Error.Logcode) FROM GADATA.C4G.Error WHERE (Robotname = @Robot AND [timestamp] BETWEEN getdate()-7 AND getdate()) AND Error.logcode = @Errcode)

,'Count LastMonth:' =
(SELECT count(Error.Logcode) FROM GADATA.C4G.Error WHERE (Robotname = @Robot AND [timestamp] BETWEEN getdate()-31 AND getdate()) AND Error.logcode = @Errcode)

,'Count ALL:' =
(SELECT count(Error.Logcode) FROM GADATA.C4G.Error WHERE Robotname = @Robot  AND Error.logcode = @Errcode)

,'First Time:' =
(SELECT top 1 CONVERT(char(19),Error.[timestamp], 120)  FROM GADATA.C4G.Error WHERE (Robotname = @Robot AND Error.logcode = @Errcode) order by Error.[timestamp] ASC)

,'Last Time:' = 
(SELECT top 1 CONVERT(char(19),Error.[timestamp], 120)  FROM GADATA.C4G.Error WHERE (Robotname = @Robot AND Error.logcode = @Errcode) order by Error.[timestamp] DESC)

END

--case of C3G robot
IF @IsC4g is null
SELECT
'Count LastDay:' =
(select Count(rt_alarm.error_number) from robotga.rt_alarm join RobotGA.Robot on Robot.id = rt_alarm.controller_id 
  where (Robot.RobotName = @Robot) AND (rt_alarm.error_number = @ErrCode) AND (rt_alarm.error_timestamp BETWEEN getdate()-1 AND getdate()))

,'Count LastWeek:' =
(select Count(rt_alarm.error_number) from robotga.rt_alarm join RobotGA.Robot on Robot.id = rt_alarm.controller_id 
  where (Robot.RobotName = @Robot) AND (rt_alarm.error_number = @ErrCode) AND (rt_alarm.error_timestamp BETWEEN getdate()-7 AND getdate()))

,'Count LastMonth:' =
(select Count(rt_alarm.error_number) from robotga.rt_alarm join RobotGA.Robot on Robot.id = rt_alarm.controller_id 
  where (Robot.RobotName = @Robot) AND (rt_alarm.error_number = @ErrCode) AND (rt_alarm.error_timestamp BETWEEN getdate()-31 AND getdate()))

,'Count ALL:' =
(select Count(rt_alarm.error_number) from robotga.rt_alarm join RobotGA.Robot on Robot.id = rt_alarm.controller_id 
  where (Robot.RobotName = @Robot) AND (rt_alarm.error_number = @ErrCode))

,'First Time:' =
(select top 1 CONVERT(char(19),rt_alarm.error_timestamp, 120)  from robotga.rt_alarm join RobotGA.Robot on Robot.id = rt_alarm.controller_id 
  where (Robot.RobotName = @Robot) AND (rt_alarm.error_number = @ErrCode) ORDER BY rt_alarm.error_timestamp ASC)

,'Last Time:' =
(select top 1 CONVERT(char(19),rt_alarm.error_timestamp, 120)  from robotga.rt_alarm join RobotGA.Robot on Robot.id = rt_alarm.controller_id 
  where (Robot.RobotName = @Robot) AND (rt_alarm.error_number = @ErrCode) ORDER BY rt_alarm.error_timestamp DESC)

END