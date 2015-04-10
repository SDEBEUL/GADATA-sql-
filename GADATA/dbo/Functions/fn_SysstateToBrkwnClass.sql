

CREATE FUNCTION [dbo].[fn_SysstateToBrkwnClass] 
	(
		@Sysstate int
	) 
RETURNS varchar(30) 
AS 
BEGIN 
	declare @SysstateString varchar(30) 
	SET @SysstateString = ''


--connection 
IF (@sysstate & 262144 = 262144)
BEGIN
  SET @SysstateString = 'C: Connection '
END

--1 Fatal error
IF (@sysstate & 8388608 = 8388608)
BEGIN
  SET @SysstateString =  'C: Fatal '
END

--2 Remote
IF NOT (@sysstate & 16777216 = 16777216)
BEGIN
  SET @SysstateString =  'C: Manual '
END

-- Hold 
IF (@sysstate & 536870912 = 536870912)
BEGIN
  SET @SysstateString =  'C: Hold '
END

--8 System alarm
IF (@sysstate & 67108864 = 67108864)
BEGIN
  SET @SysstateString =  'C: SystemAlarm '
END

--safety gate 8
IF (@sysstate & 8 = 8)
BEGIN
  SET @SysstateString = 'C: SafetyGate '
END

--32 Application fault
IF (@sysstate & 64 = 64)
BEGIN
  SET @SysstateString = 'C: Application '
END





return @SysstateString 
end