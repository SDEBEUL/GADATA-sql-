



CREATE FUNCTION [C4G].[fn_decodeSysstate] 
	(
		@Sysstate int
	) 
RETURNS varchar(30) 
AS 
BEGIN 
	declare @SysstateString varchar(30) 
	SET @SysstateString = ''

	
-- -1 disconnected 
IF (@sysstate  = -1)
BEGIN
  SET @SysstateString =  'Disconnected '
  return @SysstateString 
END
--1 connection 
IF (@sysstate & 262144 = 262144)
BEGIN
  SET @SysstateString =  @SysstateString +'connection '
END

--1 Fatal error
IF (@sysstate & 8388608 = 8388608)
BEGIN
  SET @SysstateString =  @SysstateString +'Fatal '
END

--2 Remote
IF NOT (@sysstate & 16777216 = 16777216)
BEGIN
  SET @SysstateString =  @SysstateString + 'Manual '
END

--4 Drive off 
IF NOT (@sysstate & 1073741824 = 1073741824)
BEGIN
  SET @SysstateString =  @SysstateString + 'Ready '
END


-- Running state ---------------------------------------------------------
--16 holdable running 
IF (@sysstate & 4 = 4) AND (@sysstate & 16777216 = 16777216)
BEGIN
  SET @SysstateString =  'Run '
END
---------------------------------------------------------

--optional state ---------------------------------------------------------

--8 System alarm
IF (@sysstate & 67108864 = 67108864)
BEGIN
  SET @SysstateString = @SysstateString + 'Alarm '
END

--32 Application fault
IF (@sysstate & 64 = 64)
BEGIN
  SET @SysstateString = @SysstateString + 'Appl '
END

--64 power saving
IF (@sysstate & 1 = 1)
BEGIN
  SET @SysstateString = @SysstateString + 'Idle '
END
---------------------------------------------------------

--test for safety gate 8
IF (@sysstate & 8 = 8)
BEGIN
  SET @SysstateString = @SysstateString + '(SS) '
END


--test for HOLD 536870912
IF (@sysstate & 536870912 = 536870912)
BEGIN
  SET @SysstateString = @SysstateString + 'H '
END

/*
--1 connection 
IF (@sysstate & 262144 = 262144)
BEGIN
  SET @SysstateString =  'Disconnected '
END
*/
return @SysstateString 
end