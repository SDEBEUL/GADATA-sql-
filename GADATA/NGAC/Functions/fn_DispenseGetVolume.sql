


--Returns the category name
CREATE FUNCTION [NGAC].[fn_DispenseGetVolume] 
	(
		@in varchar(max)
	) 
RETURNS float
AS 
BEGIN 
--get material consumption from string.
/*
For complete cycle 9.900 CM?
Material consumption during purge 6.400 CM?
Material consumption 2.300 CM?
*/
if @in like '%CM?%'
BEGIN
	DECLARE @temp as varchar(max)
	set @temp = @in
	set @temp = REPLACE(@temp,'For complete cycle ','')
	set @temp = REPLACE(@temp,'Material consumption during purge ','')
	set @temp = REPLACE(@temp,'Material consumption ','')
	set @temp = REPLACE(@temp,' CM?','')
	return cast(@temp as float)
END 
	return null
END