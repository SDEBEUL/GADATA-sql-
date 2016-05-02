

CREATE FUNCTION [C3G].[fn_robstate] 
	(
		@Sysstate int
	) 
RETURNS int 
AS 
BEGIN 
declare @Sysstateint int 
SET @SysstateInt = 0
--for controller disconnected 
IF (@sysstate  = -1)
BEGIN
  SET @SysstateInt = 0
  return @SysstateInt
END
 
--check system bit up 
IF (@sysstate & 262144 = 262144)
BEGIN
  SET @SysstateInt = 1
END
return @SysstateInt 
end