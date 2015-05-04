--converted to work with numeric20 as a 64 bit unsinged int and numeric 10 as the 32 bit int

CREATE FUNCTION [ABB].[CombineToBigint1] (@HiINT numeric(10), @lowINT numeric(10))
RETURNS numeric(20) AS 
BEGIN     
DECLARE @output AS numeric(20)     
BEGIN      
SET @output =  (convert( numeric(20),@HiINT)*(power(convert(numeric(20),2),convert( numeric(20),(32)))) + convert(numeric(20),@lowINT))  
  
END 
RETURN @output
END