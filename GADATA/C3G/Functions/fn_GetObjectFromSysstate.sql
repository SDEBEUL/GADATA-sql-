


CREATE FUNCTION [C3G].[fn_GetObjectFromSysstate] 
	(
		@Sysstate int
	) 
RETURNS varchar(25) 
AS 
BEGIN 

declare @Result varchar(25)

SET @Result = 
(
select top 1 ca.APPL from GADATA.C3G.c_LogClassRules as lr 
left join GADATA.C3G.c_Appl as ca on ca.id = lr.Appl_id
where @Sysstate BETWEEN lr.Err_start and lr.Err_end 
)
return @Result 
end