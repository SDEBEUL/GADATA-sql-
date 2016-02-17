

CREATE FUNCTION [dbo].[fn_QinfoFormatString] 
	(
		@In varchar(2000)
	) 
RETURNS varchar(2000) 
AS 
BEGIN 
declare @result varchar(2000) 
SET @result = REPLACE(@in,'.','.'+char(13)+char(10)) --add charage return and newline on every point 
SET @result = REPLACE(@in,',',','+char(13)+char(10)) --add charage return and newline on every point 
return @result 
end