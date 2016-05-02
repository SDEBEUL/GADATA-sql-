

CREATE FUNCTION [C3G].[fn_decodeSysstate] 
	(
		@Sysstate int
	) 
RETURNS varchar(30) 
AS 
BEGIN 
	declare @SysstateString varchar(50) 
	SET @SysstateString = ''

	
--Connection ---------------------------------------------------------
--=-1 connection lost to robot
IF (@sysstate = -1)
BEGIN
  SET @SysstateString =  'Disconnected '
  return @SysstateString 
END

--=1 Controller side not running
IF (@sysstate  = 1)
BEGIN
  SET @SysstateString =  'Controller Watchdog '
  return @SysstateString 
END


--Running state ---------------------------------------------------------
--not bit 31 (drive-on)
--    bit 7  (no appl fault)
--not bit 27 (system alarm)
IF (NOT @sysstate & 1073741824 = 1073741824) AND (@sysstate & 64 = 64) AND (not @sysstate & 67108864 = 67108864)
BEGIN
  SET @SysstateString =  'Run '
END
-- bit 19 (system up from controller side)
IF (@sysstate & 262144 = 262144)
BEGIN
 SET @SysstateString =   ' ##Run## '
 --return @SysstateString 
END
---------------------------------------------------------


--geeft problemen ... raar snap het niet
--controler 'mode' ---------------------------------------------------------
-- bit 14 AUTO-Remote
/*
IF (@sysstate & 8192 = 8192)
BEGIN
 SET @SysstateString =  @SysstateString +'T3 |'
END
*/
-- bit 15 AUTO-local
IF (@sysstate & 16384 = 16384)
BEGIN
 SET @SysstateString =  @SysstateString +'T2 |'
END

--bit 16 PROG -- for some reason does not work...
--IF (@sysstate & 262144 = 262144)
-- dan maar niet locaal en niet remote voor T
IF (not (@sysstate & 16384 = 16384) AND not  (@sysstate & 8192 = 8192))
BEGIN
 SET @SysstateString =  @SysstateString +'T1 |'
END
---------------------------------------------------------
/*

--controler 'mode' ---------------------------------------------------------
-- bit 25 Remote
IF (@sysstate & 16777216 = 16777216)
BEGIN
 SET @SysstateString =  @SysstateString +'R-'
END

-- bit 28 Prog
IF (@sysstate & 134217728 = 134217728)
BEGIN
 SET @SysstateString =  @SysstateString +'Prog |'
END

--bit 29 AUTO(local or Remote)
IF (@sysstate & 268435456 = 268435456)
BEGIN
 SET @SysstateString =  @SysstateString +'Auto |'
END
---------------------------------------------------------
*/
--optional state ---------------------------------------------------------

--bit 1 power saving
IF (@sysstate & 1 = 1)
BEGIN
  SET @SysstateString = @SysstateString + 'Idle '
END

--bit 4 safety gate or Estop
IF (@sysstate & 8 = 8)
BEGIN
  SET @SysstateString = @SysstateString + '(SS) '
END

--bit 5 Remote user connected
IF (@sysstate & 16 = 16)
BEGIN
  SET @SysstateString = @SysstateString + 'Pc '
END

--bit 6 maint from plc
IF (@sysstate & 32 = 32)
BEGIN
  SET @SysstateString = @SysstateString + 'Maint '
END

--not bit 7 Application fault
IF NOT (@sysstate & 64 = 64)
BEGIN
  SET @SysstateString = @SysstateString + 'Appl '
END

--bit 8 not $Gen 100
IF (@sysstate & 128 = 128)
BEGIN
  SET @SysstateString = @SysstateString + 'Slow '
END

--bit 10 top on cabinet
IF NOT (@sysstate & 512 = 512)
BEGIN
  SET @SysstateString = @SysstateString + 'TpOff '
END
--bit 27 System alarm
IF (@sysstate & 67108864 = 67108864)
BEGIN
  SET @SysstateString = @SysstateString + 'Alarm '
END

-- bit 30 HOLD
IF (@sysstate & 536870912 = 536870912)
BEGIN
  SET @SysstateString = @SysstateString + 'Hold '
END

-- bit 31 DriveOff
IF (@sysstate & 1073741824 = 1073741824)
BEGIN
  SET @SysstateString = @SysstateString + 'DriveOff '
END
---------------------------------------------------------

return @SysstateString 
end