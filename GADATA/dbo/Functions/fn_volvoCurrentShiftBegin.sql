
CREATE FUNCTION [dbo].[fn_volvoCurrentShiftBegin] 
	(
		@InDate DATETIME,
		@InTime Time
	) 
RETURNS datetime 
AS 
BEGIN 
	declare @shiftbegin datetime 
	SET @shiftbegin = '1900-01-01 00:00:00' 
--vroegen is shift 1
--laten is shift 2
--nacht is shift 3
--we is shift 4

declare @timestamp time


--vroegen maandag tot donderdag
if (((@InTime > '05:14:59.9999999') AND (@InTime < '13:29:59.9999999') ) AND (DATEPART(WEEKDAY,@InDate) <> 5))
begin
SET @shiftbegin =    DATEADD(dd, 0, DATEDIFF(dd, 0, @InDate)) +  '1900-01-01 05:15:00' 
end

--vroegen vrijdag
if (((@InTime > '05:14:59.9999999') AND (@InTime < '12:14:59.9999999') ) AND (DATEPART(WEEKDAY,@InDate) = 5))
begin
SET @shiftbegin =    DATEADD(dd, 0, DATEDIFF(dd, 0, @InDate)) +  '1900-01-01 05:15:00' 
end



--laten maandag to donderdag
if (((@InTime > '13:29:59.9999999') AND (@InTime < '21:29:59.9999999') AND (DATEPART(WEEKDAY,@InDate) <> 5)))
begin
SET @shiftbegin =    DATEADD(dd, 0, DATEDIFF(dd, 0, @InDate)) +  '1900-01-01 13:30:00' 
end

--laten vrijdag
if (((@InTime > '12:14:59.9999999') AND (@InTime < '18:59:59.9999999') AND (DATEPART(WEEKDAY,@InDate) = 5)))
begin
SET @shiftbegin =    DATEADD(dd, 0, DATEDIFF(dd, 0, @InDate)) +  '1900-01-01 12:15:00' 
end



--nacht maandag tot donderdag 
if 
(
(@InTime > '21:29:59.9999999') AND (@InTime < '23:59:59.9999999') AND (DATEPART(WEEKDAY,@InDate) <> 5)
OR 
(@InTime > '00:00:00.00')      AND (@InTime < '05:14:59.9999999') AND (DATEPART(WEEKDAY,@InDate) <> 5)
)

begin
SET @shiftbegin =    DATEADD(dd, 0, DATEDIFF(dd, 0, @InDate)) +  '1900-01-01 21:30:00' 
end

--nacht vrijdag 
if 
(
(@InTime > '18:59:59.9999999') AND (@InTime < '23:59:59.9999999') AND (DATEPART(WEEKDAY,@InDate) = 5)
OR 
(@InTime > '00:00:00.00')      AND (@InTime < '03:44:59.9999999') AND (DATEPART(WEEKDAY,@InDate) = 5)
)

begin
SET @shiftbegin =    DATEADD(dd, 0, DATEDIFF(dd, 0, @InDate)) +  '1900-01-01 19:00:00' 
end

--weekend
if 
((DATEPART(WEEKDAY,@InDate) = 6) AND (@InTime > '02:44:59.9999999')) 
OR 
(DATEPART(WEEKDAY,@InDate) = 7) 
OR
((DATEPART(WEEKDAY,@InDate) = 1) AND  (@InTime < '05:14:59.9999999'))
begin
SET @shiftbegin =    DATEADD(dd, 0, DATEDIFF(dd, 0, @InDate)) +  '1900-01-01 03:45:00' 
end


return @shiftbegin 
end