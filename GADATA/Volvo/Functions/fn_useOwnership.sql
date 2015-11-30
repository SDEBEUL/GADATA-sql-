

CREATE FUNCTION [volvo].[fn_useOwnership] 
	(
		@InLocation varchar(256),
		@InController_name varchar(256),
		@Inbit bit
	) 
RETURNS varchar(256)
AS 
BEGIN 
--If fucntion is of return input
if (@inbit = 0)
BEGIN
return @Inlocation
END
 
-- return Ownership for location
RETURN (SELECT ISNULL(Robots.ownership,@InLocation) FROM GADATA.Volvo.Robots WHERE Robots.controller_name = @InController_name)
END