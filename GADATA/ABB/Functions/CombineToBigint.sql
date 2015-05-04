CREATE FUNCTION [ABB].[CombineToBigint] (@HiINT int, @lowINT int)
RETURNS bigint AS 
BEGIN     
DECLARE @output AS bigint     
BEGIN      
SET @output =  ((convert(bigint,@HiINT)*(power(convert(bigint,2),convert(bigint,(32))))-1) +@lowINT)  
  
END 
RETURN @output
END