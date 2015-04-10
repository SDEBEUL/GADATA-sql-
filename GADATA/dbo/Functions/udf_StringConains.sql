

CREATE FUNCTION dbo.udf_StringConains
(@instr VARCHAR(256)
,@Search VARCHAR(256)
)
RETURNS int

AS
BEGIN
DECLARE @result int



IF  CHARINDEX(@Search, @instr ) > 0     
set @result = 1
ELSE    
set @result = 0

RETURN ISNULL(@result,0)

END