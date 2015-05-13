

CREATE FUNCTION ABB.GetConfigBit (@varname varchar(50) )
RETURNS bit
AS
BEGIN
DECLARE @i  bit
SET @i = (SELECT top 1 _value FROM GADATA.abb.c_config where _varname = @varname)
IF @i is null
SET @i = 0
RETURN (@i)
END