
CREATE FUNCTION [dbo].[fn_volvoshift] 
	(
		@InDate DATETIME,
		@InTime Time
	) 
RETURNS int 
AS 
BEGIN 
	declare @shift int 
	SET @shift = 0
--vroegen is shift 1
--laten is shift 2
--nacht is shift 3
--we is shift 4

declare @timestamp time

--vroegen
if (@InTime > '05:14:59.9999999') AND (@InTime < '13:29:59.9999999') 
begin
SET @shift = 1
end

--laten
if (@InTime > '13:29:59.9999999') AND (@InTime < '21:29:59.9999999') 
begin
SET @shift = 2
end

--nacht
if ((@InTime > '21:29:59.9999999') AND (@InTime < '23:59:59.9999999')) OR ((@InTime > '00:00:00.00') AND (@InTime < '05:14:59.9999999'))
begin
SET @shift = 3
end

--weekend
if 
((DATEPART(WEEKDAY,@InDate) = 6) AND (@InTime > '02:44:59.9999999')) 
OR 
(DATEPART(WEEKDAY,@InDate) = 7) 
OR
((DATEPART(WEEKDAY,@InDate) = 1) AND  (@InTime < '05:14:59.9999999'))
begin
SET @shift = 4
end


return @shift 
end