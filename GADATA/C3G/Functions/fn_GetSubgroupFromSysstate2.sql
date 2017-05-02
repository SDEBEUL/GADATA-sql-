


CREATE FUNCTION [C3G].[fn_GetSubgroupFromSysstate2] 
	(
		@Sysstate int
	) 
RETURNS varchar(25) 
AS 
BEGIN 

declare @Result varchar(25)

SET @Result = 
(
SELECT 'Operational**' WHERE 
(GADATA.C3G.[fn_ShortSysstate](@Sysstate) LIKE '%(SS)%')
OR
(GADATA.C3G.[fn_ShortSysstate](@Sysstate) LIKE '%Maint%')
)
return @Result 
end