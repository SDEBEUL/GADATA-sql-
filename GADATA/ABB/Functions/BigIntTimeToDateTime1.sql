CREATE FUNCTION [ABB].[BigIntTimeToDateTime1] (@biFileTime numeric(20))
RETURNS datetime AS 
BEGIN     
DECLARE @output AS datetime  
DECLARE @ms AS numeric(20)
DECLARE @min AS numeric(20)
DECLARE @day AS numeric(20)

IF @biFileTime IS NULL   
	BEGIN
	SET @output = NULL     
	END  
ELSE   

BEGIN      
-- remove difference between 1900 and 1601, then divide by 10,000 to get milliseconds        
SET @ms = (@biFileTime - convert(numeric(20),94354848000000000))/convert(numeric(10),10000)         
-- check that result is positive else return 1st Jan 1900 as the datetime        
IF @ms < 0        
	BEGIN      
	SET @output = CAST(0 AS datetime)          
	END        
ELSE     

BEGIN      
	-- calculate the minutes            
	SET @min = CAST(@ms/convert(numeric(10),60000) AS numeric(20))           
	-- calculate the days      
    
	SET @day = CAST(@min/convert(numeric(10),1440) AS numeric(20)) 
	-- starting from 0 (zero), add our days, minutes and milliseconds to get the datetime value.  
	--  NOTE - we use the mod operator to calculate the offsets of each time portion for the day.             
	--SET @output = DATEADD(ms, CAST(@ms%60000 AS numeric(20)), DATEADD(mi, CAST(@min%1440 AS numeric(20)), DATEADD(dd, @day, CAST(0 AS datetime))))  
     
END   
END    
RETURN @output
END