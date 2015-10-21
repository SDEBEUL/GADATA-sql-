


CREATE FUNCTION [c4g].[fn_robstate] 
	(
		@Sysstate int
	) 
RETURNS int 
AS 
BEGIN 
	declare @Sysstateint int 
	SET @SysstateInt = 0



IF 
( --remote
(@sysstate & 16777216 = 16777216)  
--AND --rsss running
--(@sysstate & 4 = 4)
AND NOT --safety stop
(@sysstate & 8 = 8)
AND NOT --drive off 
(@sysstate & 1073741824 = 1073741824)
AND NOT --not in application fault
(@sysstate & 64 = 64)
AND NOT --not in system fault. (added this because to catch hardware errors)
(@sysstate & 67108864 = 67108864)
AND NOT --not hold from TP. (added this because id did not catch level 4 non appl bassed errors)
(@sysstate & 131072 = 131072)
)

BEGIN
  SET @SysstateInt = 2
END

return @SysstateInt 
end