CREATE PROCEDURE [dbo].[sp_VCSC_C4G_CheckRobotNOTSAVED]
AS

begin
SET DATEFIRST 1
end

BEGIN
WITH rt_not_saved_rndesc AS 
(
	SELECT 
		   [id]
		  ,[controller_id]
		  ,[_timestamp]
		  ,[program]
		  ,[modified],
		  ROW_NUMBER() OVER (PARTITION BY controller_id, program ORDER BY _timestamp DESC) AS rnDESC
	  FROM [GADATA].[dbo].[rt_not_saved]
)


SELECT
	rt_not_saved_rndesc._timestamp As 'last change',
    c_controller.controller_name,
	rt_not_saved_rndesc.program,
	rt_not_saved_rndesc.modified,
	Lrt_not_saved_rndesc._timestamp as 'last ok time',
	datediff(hour,Lrt_not_saved_rndesc._timestamp,getdate()) as 'hours not saved'
FROM rt_not_saved_rndesc 

left join c_controller on controller_id = c_controller.id

left join rt_not_saved_rndesc AS Lrt_not_saved_rndesc ON
(
(rt_not_saved_rndesc.controller_id = Lrt_not_saved_rndesc.controller_id)
AND
(rt_not_saved_rndesc.program = Lrt_not_saved_rndesc.program)

AND
(rt_not_saved_rndesc.rnDESC = 1) -- current file state
AND
(rt_not_saved_rndesc.modified = 1) --state change from not saved to saved 

AND
(Lrt_not_saved_rndesc.modified = 0)

)

WHERE

(rt_not_saved_rndesc.modified = 1)
AND
(rt_not_saved_rndesc.rnDESC = 1)
AND
((rt_not_saved_rndesc.program NOT LIKE '%Rsssssrr%') AND (rt_not_saved_rndesc.program NOT LIKE '%Lsssssrr%'))
ORDER by  'last change' desc

END