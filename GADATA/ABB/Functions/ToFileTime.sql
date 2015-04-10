CREATE FUNCTION abb.ToFileTime
(
	@date datetime,
	@timezone int
)
RETURNS bigint
AS
BEGIN
	-- "Constants"
	declare @ticksPerHour bigint; set @ticksPerHour = power(10, 7) * cast(3600 as bigint);
	declare @ticksPerDay bigint; set @ticksPerDay = @ticksPerHour * 24;
		
	-- Result: (ticks at midnight Jan 1 1901 + ticks since then - timezone shift)
	RETURN 94354848000000000 + (cast(@date as float) * @ticksPerDay) - (@timezone * @ticksPerHour);
END