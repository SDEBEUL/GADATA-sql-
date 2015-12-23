


CREATE FUNCTION [Volvo].[fn_GetNumberOfbits] 
	(
		@In int,
		@StartBit int,
		@Nbits int
	) 
RETURNS int
AS 
BEGIN
DECLARE @result as int
DECLARE @i as int
set @i = 0
Set @result = 0


WHILE @i < @nbits
BEGIN
	IF ( (@In & POWER(2,@i-1+@StartBit)) = (Power(2,@i-1+@StartBit)) )
		BEGIN
		 SET @Result = @Result + POWER(2,@i) 
		END
SET @i = @i+1
END
RETURN @result
END