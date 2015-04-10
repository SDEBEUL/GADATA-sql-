

CREATE FUNCTION [dbo].[fn_ShortSysstate] 
	(
		@Sysstate int
	) 
RETURNS int 
AS 
BEGIN 
	declare @Sysstateint int 
	SET @SysstateInt = 0


--1 Fatal error
IF  NOT (@sysstate & 8388608 = 8388608)
BEGIN
  SET @SysstateInt =  @SysstateInt + 1
END

--2 Remote
IF (@sysstate & 16777216 = 16777216)
BEGIN
  SET @SysstateInt =  @SysstateInt + 2
END

--4 Drive off 
IF NOT (@sysstate & 1073741824 = 1073741824)
BEGIN
  SET @SysstateInt =  @SysstateInt + 4
END

--8 System alarm
IF NOT (@sysstate & 67108864 = 67108864)
BEGIN
  SET @SysstateInt = @SysstateInt + 8
END

--16 holdable running 
IF (@sysstate & 4 = 4) 
BEGIN
  SET @SysstateInt =  @SysstateInt + 16
END

--32 Application fault
IF NOT (@sysstate & 64 = 64)
BEGIN
  SET @SysstateInt = @SysstateInt + 32
END

--64 power saving
IF NOT (@sysstate & 1 = 1)
BEGIN
  SET @SysstateInt = @SysstateInt + 64
END


return @SysstateInt 
end