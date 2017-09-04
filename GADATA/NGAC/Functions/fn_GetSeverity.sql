

--Returns the category name
CREATE FUNCTION [NGAC].[fn_GetSeverity] 
	(
		@in varchar(max)
	) 
RETURNS int
AS 
BEGIN 

RETURN
  CASE 
     WHEN @in like  '%ERROR%' THEN 3
	 WHEN @in like '%WARNING%' THEN 2
     WHEN @in like '%INFO%' THEN 1
   ELSE 0
   END
END