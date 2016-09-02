

CREATE PROCEDURE [Volvo].[sp_GADATAFrontHand]
--timeparameters
   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
--Filterparameters.
   @RobotFilterWild as varchar(10) = '%',
   @LocationFilterWild as varchar(20) = '%',
--COMAU C4G booleans
   @GetC4GSBCU as bit = 0, --TBT
--Comau C3G Booleans   
   @GetC3GSBCU as bit = 0 
--gives the right permission when a low level user only has execution rights
with execute as owner
AS
BEGIN

---------------------------------------------------------------------------------------
--Set default values of start and end date
---------------------------------------------------------------------------------------
if ((@StartDate is null) OR (@StartDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @StartDate = GETDATE()-200
END

if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()
END

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--**************DATA FROM GRIPPERS**************--
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--voorlopig om data om te zetten...

exec GADATA.c4g.sp_Decode_HandMonitor
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
SELECT *
FROM GADATA.C4G.HandMonitor as h
where --h.timestamp between   @startdate and @EndDate AND
 h.Robotname LIKE @RobotFilterWild
 AND h.Time < 3000 --zit nog ergens bug langs controller kant 
UNION
SELECT 
'timeline' as 'Location'
,'timeline' as 'Robotname'
,T.[Timestamp]
,NULL as 'Grip'
,NULL as 'MoveType'
,NULL as 'Seq'
,NULL as 'Time'
,T.[Year]
,T.[Week]
,T.[day]
,T.[Shift] as 'shift'
,T.id as 'RnDesc'
FROM GADATA.Volvo.Timeline AS T
WHERE
--datetime filter
(T.[Timestamp]  BETWEEN @StartDate AND @EndDate)


 ---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Activity log (logs the execution of the Query to a table)
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
DECLARE @rowcountmen as int 
SET @rowcountmen = @@rowcount
EXEC GADATA.volvo.sp_Alog  @rowcount = @rowcountmen, @Request = 'Running: [Volvo].[sp_GADATAFrontHand]'

END
GO
GRANT EXECUTE
    ON OBJECT::[Volvo].[sp_GADATAFrontHand] TO [db_frontendUser]
    AS [GADATA];

