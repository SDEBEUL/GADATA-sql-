-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_CheckWear]
	-- Add the parameters for the stored procedure here
AS
BEGIN

with WBC as (
SELECT 
  WBC.ID
, WBC.[DateTime]
, WBC.TimerID
, WBC.ElectrodeNbr
, WBC.wear
,ROW_NUMBER() OVER (PARTITION BY WBC.TimerID, WBC.ElectrodeNbr  ORDER BY WBC.[DateTime] ASC) AS 'idx'
FROM GADATA.dbo.WearBeforeChange as WBC
)

select 
  WBC.ID
, WBC.[DateTime]
, WBC.TimerID
, WBC.ElectrodeNbr
, WBC.wear
, Lwbc.wear as 'oldWear'
, Lwbc.[DateTime] as 'OldDT'
, (wbc.[DateTime]  - lwbc.[DateTime]) as 'Timebetween'
,timer.Name

 from WBC
 left join wbc as Lwbc on 
 (
 wbc.TimerID = Lwbc.TimerID
 AND
 wbc.ElectrodeNbr = Lwbc.ElectrodeNbr
 AND
 wbc.idx= Lwbc.idx+1
 )

 left outer join GADATA.dbo.timer as timer on timer.ID = wbc.TimerID

  where 
  (wbc.[DateTime]  - lwbc.[DateTime]) < '1900-01-01 01:00:00' 
  OR
  lwbc.[DateTime] is NULL
END