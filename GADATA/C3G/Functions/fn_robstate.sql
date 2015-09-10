

CREATE FUNCTION [C3G].[fn_robstate] 
	(
		@Sysstate int
	) 
RETURNS int 
AS 
BEGIN 
	declare @Sysstateint int 
SET @SysstateInt = 0
IF (@sysstate & 262144 = 262144)
BEGIN
  SET @SysstateInt = 1
END
return @SysstateInt 
end