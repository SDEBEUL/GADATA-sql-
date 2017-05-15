
CREATE PROCEDURE [Volvo].[sp_GADATAFrontSBCU]
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

SELECT 'THIS SYSTEM IS DISABELD' as 'info'

END
GO
GRANT EXECUTE
    ON OBJECT::[Volvo].[sp_GADATAFrontSBCU] TO [db_frontendUser]
    AS [GADATA];

