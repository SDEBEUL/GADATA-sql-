CREATE FUNCTION [ABB].[SplitString] (@input varchar(1000), @delimiter varchar(5), @part int)
RETURNS varchar(1000) AS 
BEGIN     
DECLARE @output AS varchar(1000)     
BEGIN    
 SET @output = parsename(replace(RTRIM(LTRIM(@input)),' ','.'),@part)  
END 
RETURN @output
END