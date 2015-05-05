CREATE FUNCTION [ABB].[BigIntTimeToDateTime1] (@biFileTime numeric(20)) --resolution set at 1 second to try and deal with overflow 
RETURNS datetime AS 
BEGIN     
DECLARE @output AS datetime  
DECLARE @s AS bigint 
DECLARE @min AS int
DECLARE @day AS int 

IF @biFileTime IS NULL   
	BEGIN
	SET @output = NULL     
	END  
ELSE   

BEGIN  
--this function will conver MFT to DT 
--MFT => a 64-bit value representing the number of 100-nanosecond intervals since January 1, 1601 (UTC).
--
-- remove difference between 1900 and 1601
--because of the different time formats MFT time starts in the the year 1601 and SQL DATETIME in year 1900
-- then divide by 10,00000 to get seconds               

SET @s = (@biFileTime - 94354848000000000)/10000000
-- check that result is positive else return 1st Jan 1900 as the datetime    (should not be possible cause the 64 bit int is UNSINGED)

IF @s < 0        
	BEGIN      
	SET @output = CAST(0 AS datetime)          
	END        
ELSE     

BEGIN      
	-- calculate the minutes            
	SET @min = CAST(@s/60 AS int)    
	-- calculate the days          
	SET @day = CAST(@min/1440 AS int) 
	-- starting from 0 (zero), add our days, minutes and seconds to get the datetime value.  
	--  NOTE - we use the mod operator to calculate the offsets of each time portion for the day.             
	SET @output = DATEADD(s, CAST(@s%60 AS int), 
					DATEADD(mi, CAST(@min%1440 AS int), 
						DATEADD(dd, @day, CAST(0 AS datetime))
						)
						 )  			 	
END   
END    
RETURN @output
END