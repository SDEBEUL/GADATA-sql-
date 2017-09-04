
CREATE FUNCTION [NGAC].[DistanceBetweenPoints](@x1 float,@y1 float,@z1 float,@x2 float,@y2 float,@z2 float) RETURNS float
AS
BEGIN
DECLARE @distance float
set @distance = ROUND(SQRT(POWER(@x2-@x1,2)+POWER(@y2-@y1,2)+POWER(@z2-@z1,2)),2)
RETURN @distance
END