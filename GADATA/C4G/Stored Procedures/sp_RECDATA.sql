

CREATE PROCEDURE [C4G].[sp_RECDATA]
--timeparameters
   @StartDate as DATETIME = null,
   @EndDate as DATETIME = null,
--Filterparameters.
   @Robot as varchar(25) = '%',
   @ProgN as varchar(25) = '3%'
AS
BEGIN

---------------------------------------------------------------------------------------
--Set default values of start and end date
---------------------------------------------------------------------------------------
if ((@StartDate is null) OR (@StartDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @StartDate = GETDATE()-30
END

if ((@EndDate is null) OR (@EndDate = '1900-01-01 00:00:00:000'))
BEGIN
SET @EndDate = GETDATE()
END
---------------------------------------------------------------------------------------


select 
 c.controller_name
,rt_rec_group.*
,c_rec_variable.name
,rt_rec_data.*
,t.Vweek
,t.Vday

from GADATA.C4G.rt_rec_group
left join GADATA.C4G.rt_rec_data on rt_rec_data.rt_rec_group_id = rt_rec_group.id
left join GADATA.C4G.c_controller as c on c.id = rt_rec_group.controller_id
left join GADATA.C4G.c_rec_variable on c_rec_variable.id = rt_rec_data.c_rec_variable_id
left join GADATA.volvo.L_timeline as t on rt_rec_group._timestamp between t.starttime and t.endtime
WHERE 
rt_rec_data.axis <> 0
AND
rt_rec_group._timestamp between @StartDate and @EndDate
AND
c.controller_name LIKE @Robot
AND
rt_rec_group.model_code like @ProgN
order by rt_rec_group.id desc 
END