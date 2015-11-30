

CREATE FUNCTION [volvo].[fn_usePloeg] 
	(
		@InShift varchar(2),
		@InDatetime datetime,
		@Inbit bit
	) 
RETURNS varchar(2)
AS 
BEGIN 
--If fucntion is of return input
if (@inbit = 0)
BEGIN
return @Inshift
END
 
-- return Ploeg for shift
RETURN 
(
SELECT TOP 1 L_timeline.PLOEG FROM GADATA.volvo.L_timeline
WHERE
@InDatetime BETWEEN L_timeline.starttime AND L_timeline.endtime
)
END