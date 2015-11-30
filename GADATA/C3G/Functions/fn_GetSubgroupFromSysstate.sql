


CREATE FUNCTION [C3G].[fn_GetSubgroupFromSysstate] 
	(
		@Sysstate int
	) 
RETURNS varchar(25) 
AS 
BEGIN 

declare @Result varchar(25)

SET @Result = 
(
select top 1 cS.subgroup from GADATA.C3G.c_LogClassRules as lr 
left join GADATA.C3G.c_Subgroup as cS on cS.id = lr.Subgroup_id
where @Sysstate BETWEEN lr.Err_start and lr.Err_end 
)
return @Result 
end