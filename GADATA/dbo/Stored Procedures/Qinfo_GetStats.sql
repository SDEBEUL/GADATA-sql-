CREATE PROCEDURE [dbo].[Qinfo_GetStats]
   @Robot as varchar(16) = null
   ,@ErrCode as int = null
AS
BEGIN

DECLARE @IsC4g int 
set @IsC4g = (select c_controller.id from c_controller where c_controller.controller_name = @robot)

--case of C4G robot
IF @IsC4g is not null
SELECT
'Count LastDay:' =
(select Count(rt_alarm.error_number) from dbo.rt_alarm join dbo.c_controller on c_controller.id = rt_alarm.controller_id 
  where (c_controller.controller_name = @Robot) AND (rt_alarm.error_number = @ErrCode) AND (rt_alarm._timestamp BETWEEN getdate()-1 AND getdate()))

,'Count LastWeek:' =
(select Count(rt_alarm.error_number) from dbo.rt_alarm join dbo.c_controller on c_controller.id = rt_alarm.controller_id 
  where (c_controller.controller_name = @Robot) AND (rt_alarm.error_number = @ErrCode) AND (rt_alarm._timestamp  BETWEEN getdate()-7 AND  getdate()))

,'Count LastMonth:' =
(select Count(rt_alarm.error_number) from dbo.rt_alarm join dbo.c_controller on c_controller.id = rt_alarm.controller_id 
  where (c_controller.controller_name = @Robot) AND (rt_alarm.error_number = @ErrCode) AND (rt_alarm._timestamp  BETWEEN getdate()-31 AND  getdate()))

,'Count ALL:' =
(select Count(rt_alarm.error_number) from dbo.rt_alarm join dbo.c_controller on c_controller.id = rt_alarm.controller_id 
  where (c_controller.controller_name = @Robot) AND (rt_alarm.error_number = @ErrCode))

,'First Time:' =
(select top 1 isnull(rt_alarm._timestamp,rt_alarm.error_timestamp) from dbo.rt_alarm join dbo.c_controller on c_controller.id = rt_alarm.controller_id 
  where (c_controller.controller_name = @Robot) AND (rt_alarm.error_number = @ErrCode) ORDER BY _timestamp ASC)

,'Last Time:' =
(select top 1 isnull(rt_alarm._timestamp,rt_alarm.error_timestamp) from dbo.rt_alarm join dbo.c_controller on c_controller.id = rt_alarm.controller_id 
  where (c_controller.controller_name = @Robot) AND (rt_alarm.error_number = @ErrCode)  ORDER BY _timestamp DESC)

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
(select top 1 rt_alarm.error_timestamp from robotga.rt_alarm join RobotGA.Robot on Robot.id = rt_alarm.controller_id 
  where (Robot.RobotName = @Robot) AND (rt_alarm.error_number = @ErrCode) ORDER BY rt_alarm.error_timestamp ASC)

,'Last Time:' =
(select top 1 rt_alarm.error_timestamp from robotga.rt_alarm join RobotGA.Robot on Robot.id = rt_alarm.controller_id 
  where (Robot.RobotName = @Robot) AND (rt_alarm.error_number = @ErrCode) ORDER BY rt_alarm.error_timestamp DESC)

END