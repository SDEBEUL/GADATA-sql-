
CREATE PROCEDURE [EqUi].[GetSbcuData]
--timeparameters
	   @StartDate as DATETIME = '1900-01-01',
	   @EndDate as DATETIME = '2050-01-01',
	   @Robot as varchar(25) = null,
       @Tool as varchar(25) = null,
       @Toolname as varchar(25) = null --'321030WS01a'
AS
BEGIN

---------------------------------------------------------------------------------------
--Als er een weldgun name word gebruikt zoeken we de juiste robot en tool id op..
---------------------------------------------------------------------------------------

if (@Toolname is not null)
BEGIN
--for C3G C4G and NGAC Weldguns
SET @Robot = (SELECT TOP 1 '%' + rws.Robot + '%' from GADATA.volvo.RobotWeldGunRelation as rws where rws.WeldgunName LIKE RTRIM(@Toolname)+'%')
SET @Tool = (SELECT TOP 1 '%Tool: ' + CAST(rws.ElectrodeNbr as varchar(2)) + '%' from GADATA.volvo.RobotWeldGunRelation as rws where rws.WeldgunName LIKE RTRIM(@Toolname)+'%')
END

--get controller type
DECLARE @ControllerType as varchar(max)
SET @ControllerType = (SELECT TOP 1 rws.RobotType from GADATA.volvo.RobotWeldGunRelation as rws where rws.WeldgunName LIKE RTRIM(@Toolname)+'%')

--if no result check for NGAC Stud or Dispense
if (@ControllerType is null)
BEGIN
  SET @ControllerType = 'NGAC_DispenseStud'
  SET @Tool = @Toolname
END

---------------------------------------------------------------------------------------
--COMAU C3G Robots
---------------------------------------------------------------------------------------
if (@ControllerType = 'c3g') 
BEGIN
SELECT 
  sbcu.tool_timestamp  as 'timestamp'
, @ControllerType as 'ControllerType'
, sbcu.Dsetup as 'LongDsetup'
, null as 'ShortDsetup' 
, sbcu.UCL as 'LongUCL'
, sbcu.LCL as 'LongLCL'
,null as 'ShortUCL'
,null as 'ShortLCL'
,*
FROM gadata.c3g.sbcudata as sbcu 
WHERE
sbcu.Longcheck = 1
AND
sbcu.tool_timestamp between   @startdate and @EndDate 
AND
sbcu.Robotname LIKE @Robot
AND
sbcu.tool_id LIKE @Tool

UNION  
SELECT 
  sbcu.tool_timestamp  as 'timestamp'
, @ControllerType as 'ControllerType'
, null as 'LongDsetup'
, sbcu.Dsetup as 'ShortDsetup' 
, null as 'LongUCL'
, null as 'LongLCL'
,sbcu.UCL  as 'ShortUCL'
,sbcu.LCL  as 'ShortLCL'
,*
FROM gadata.c3g.sbcudata as sbcu 
WHERE
sbcu.Longcheck = 0
AND
sbcu.tool_timestamp between   @startdate and @EndDate 
AND
sbcu.Robotname LIKE @Robot
AND
sbcu.tool_id LIKE @Tool  
END
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--ABB NGAC robots (data uit tipdresslogfile ) ENKEL SPOT
---------------------------------------------------------------------------------------
if (@ControllerType = 'NGAC') 
BEGIN
SELECT 
  [Date Time]  as 'timestamp'
,@ControllerType as 'ControllerType'
,controller_name
,[Date Time]
,GunRefTCP_X
,GunRefTCP_Y
,GunRefTCP_Z
,GunTCP_X
,GunTCP_Y
,GunTCP_Z
,NomTCP_X
,NomTCP_Y
,NomTCP_Z
,DeltaNom
,DeltaRef
--Dummys (need to rework UI side)
, null as 'LongUCL'
, null as 'LongLCL'
, null  as 'ShortUCL'
, null  as 'ShortLCL'
, DeltaNom as 'LongDsetup'
, DeltaRef as 'ShortDsetup' 
FROM GADATA.NGAC.TipDressLogFile
where controller_name like @Robot and Tool_Nr = 1 
and [Date Time] between @startdate and @enddate
END
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
--ABB NGAC robots (data TCP_logfile) ENKEL Stud 
---------------------------------------------------------------------------------------
if (@ControllerType = 'NGAC_DispenseStud') 
BEGIN
SELECT 
  [Date Time]  as 'timestamp'
,@ControllerType as 'ControllerType'
,controller_name
,[Date Time]
,rt.*
--Dummys (need to rework UI side)
, null as 'LongUCL'
, null as 'LongLCL'
, null  as 'ShortUCL'
, null  as 'ShortLCL'
, rt.DeltaRef as 'LongDsetup'
, null as 'ShortDsetup' 
FROM GADATA.NGAC.TCP_LOG as rt
where @Tool = rt.Toolname
and [Date Time] between @startdate and @enddate
END
END