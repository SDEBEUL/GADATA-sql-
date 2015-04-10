CREATE PROCEDURE [dbo].[sp_VCSC_Robotpositions]
   @RobotFilterWild as varchar(10) = '34020r08%'
AS
BEGIN


if (OBJECT_ID('tempdb..#modtemp') is not null) drop table #modtemp
SELECT 
       Robot.robotname
	  ,[_timestamp] AS 'Detection_time'
      ,[file_timestamp]
      ,[controller_id]
      ,[Owner]
      ,[Pos]
      ,[X]
      ,[Y]
      ,[Z]
      ,[a]
      ,[e]
      ,[r]
      ,[ax7]
      ,[ax8]
      ,[Cnfg]
	  ,ROW_NUMBER() OVER (PARTITION BY [L_robotpositions].controller_id, [L_robotpositions].Owner, [L_robotpositions].pos  ORDER BY L_robotpositions._timestamp ASC) AS 'ModCount'
  into #modtemp
  FROM [GADATA].[RobotGA].[L_robotpositions]
  join gadata.robotga.robot on Robot.id = L_robotpositions.controller_id 
  WHERE GADATA.RobotGA.Robot.RobotName like @RobotFilterWild

select 
       #modtemp.robotname
	  ,#modtemp.Detection_time
      ,#modtemp.[file_timestamp]
      ,#modtemp.[Owner]
      ,#modtemp.[Pos]
      ,#modtemp.[X]
      ,#modtemp.[Y]
      ,#modtemp.[Z]
      ,#modtemp.[a]
      ,#modtemp.[e]
      ,#modtemp.[r]
      ,#modtemp.[ax7]
      ,#modtemp.[ax8]
      ,#modtemp.[Cnfg] 
	  ,#modtemp.modcount
	  , DeltaP = ROUND(SQRT(
	  POWER((#modtemp.[X]-Lmodtemp.[X]),2)
	  +
	  POWER((#modtemp.[Y]-Lmodtemp.[Y]),2)
	  +
	  POWER((#modtemp.[Z]-Lmodtemp.[Z]),2)
	  ),2)
	  , DeltaO = ROUND(SQRT(
	  POWER((#modtemp.[a]-Lmodtemp.[a]),2)
	  +
	  POWER((#modtemp.[e]-Lmodtemp.[e]),2)
	  +
	  POWER((#modtemp.[r]-Lmodtemp.[r]),2)
	  ),2)


from #modtemp
LEFT join #modtemp Lmodtemp on 
(#modtemp.controller_id = Lmodtemp.controller_id)
AND
(#modtemp.Owner = Lmodtemp.Owner)
AND
(#modtemp.Pos = Lmodtemp.pos)
AND
((#modtemp.ModCount - 1) = Lmodtemp.ModCount)


--where #modtemp.ModCount <> 1 
order by Detection_time desc 
END