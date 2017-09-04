CREATE FUNCTION [NGAC].[TrimEmptylines](@str VARCHAR(MAX)) RETURNS VARCHAR(MAX)
AS
BEGIN
BEGIN
  SET @STR =  replace(@str,'      ' , '') --Abb f up 1
  SET @STR =  replace(@str,'   ', '') --stupid f up 2
  SET @STR =  replace(@str, char(10) + char(13), '') --normal empty line

END

RETURN @str
END