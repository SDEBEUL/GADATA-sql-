

CREATE FUNCTION [C3G].[fts_Downtime] 
	(
		@EndOfBreakDown DATETIME
		,@StartOfBreakDown DATETIME
	) 
RETURNS DATETIME
AS 
BEGIN 
declare @outDt DATETIME 

IF (DATEDIFF(second,@StartOfBreakDown,(@EndOfBreakDown- '1900-01-01 00:03:00')) < 0)
BEGIN
 SET @outDt = @EndOfBreakDown - @StartOfBreakDown 
END 

ELSE
BEGIN
SET @outDt = (@EndOfBreakDown - '1900-01-01 00:03:00') - @StartOfBreakDown
END
return @outDt 
end