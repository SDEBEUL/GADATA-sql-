
CREATE FUNCTION [dbo].[fn_volvoday] 
	(
		@InDate DATETIME,
		@InTime Time
	) 
RETURNS int 
AS 
BEGIN 
	declare @volvoday int 
	SET @volvoday = 0


declare @timestamp time

--voor vroegen en laten klopt de date time altijd dus std zetten we deze
SET @volvoday = DATEPART(WEEKDAY,@InDate)

--nacht
--voor nacht is er een issue na '00:00:00.0000001' tot '05:14:59.9999999' dan is het eigenlijk weekday - 1 
if ((@InTime > '00:00:00.00') AND (@InTime < '05:14:59.9999999'))
begin
SET @volvoday = (DATEPART(WEEKDAY,@InDate)-1)
end

--weekend
if 
((DATEPART(WEEKDAY,@InDate) = 6) AND (@InTime > '02:44:59.9999999')) 
OR 
(DATEPART(WEEKDAY,@InDate) = 7) 
OR
((DATEPART(WEEKDAY,@InDate) = 1) AND  (@InTime < '05:14:59.9999999'))
begin
SET @volvoday = DATEPART(WEEKDAY,@InDate)
end


return @volvoday 
end