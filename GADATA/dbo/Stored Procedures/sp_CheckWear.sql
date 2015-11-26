-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_CheckWear]
	-- Add the parameters for the stored procedure here
	@FilterTime SmallDateTime
AS
BEGIN

with WBC as (
SELECT 
  WBC.[DateTime]
, WBC.ElectrodeNbr
, WBC.TimerID
, WBC.wear
, WBC.[DateTime] - LAG(WBC.[DateTime],1,'1900-01-01 00:00:00') OVER (PARTITION BY WBC.TimerID, WBC.ElectrodeNbr ORDER BY WBC.[DateTime] ASC) AS 'TimeSincePrevious'
, LAG(WBC.wear,1,-100) OVER (PARTITION BY WBC.TimerID, WBC.ElectrodeNbr ORDER BY WBC.[DateTime] ASC) AS 'PreviousWear'
, LEAD(WBC.[DateTime],1,'2079-06-06 23:59:00') OVER (PARTITION BY WBC.TimerID, WBC.ElectrodeNbr ORDER BY WBC.[DateTime] ASC) - WBC.[DateTime] AS 'TimeToNext'
, LEAD(WBC.wear,1,-100) OVER (PARTITION BY WBC.TimerID, WBC.ElectrodeNbr ORDER BY WBC.[DateTime] ASC) AS 'NextWear'
FROM GADATA.dbo.WearBeforeChange as WBC
)

select 
  WBC.[DateTime]
, WBC.ElectrodeNbr
, WBC.wear
,timer.Robot
,robot.location
,robot.controller_type

 from WBC
 left join GADATA.dbo.timer as timer on timer.ID = wbc.TimerID
 left join GADATA.Volvo.Robots as robot on robot.controller_name = timer.Robot

 where
(WBC.TimeSincePrevious > @FilterTime AND WBC.TimeToNext > @FilterTime) OR
(WBC.TimeToNext > @FilterTime AND WBC.PreviousWear < wbc.wear) OR 
(WBC.TimeSincePrevious > @FilterTime AND WBC.NextWear <= wbc.wear) OR
(WBC.PreviousWear < WBC.wear AND WBC.NextWear <= WBC.wear)

ORDER BY WBC.[DateTime] DESC

END