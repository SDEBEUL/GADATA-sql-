--Returns the category name
CREATE FUNCTION [NGAC].[fn_GetCategory] 
	(
		@CategoryId int
	) 
RETURNS Varchar(50) 
AS 
BEGIN 

RETURN
  CASE 
     WHEN @CategoryId =  0 THEN 'Common'
     WHEN @CategoryId = 1 THEN 'Operational'
     WHEN @CategoryId =  2 THEN 'System'
     WHEN @CategoryId = 3 THEN 'Hardware'
     WHEN @CategoryId =  4 THEN 'Program'
     WHEN @CategoryId = 5 THEN 'Motion'
     WHEN @CategoryId =  6 THEN 'Operator'
     WHEN @CategoryId = 7 THEN 'IOCommunication'
     WHEN @CategoryId =  8 THEN 'User'
    -- WHEN @CategoryId = 9 THEN 'Does not exis'
     WHEN @CategoryId =  10 THEN 'Internal'
     WHEN @CategoryId = 11 THEN 'Process'
     WHEN @CategoryId =  12 THEN 'Configuration'
     WHEN @CategoryId = 13 THEN 'Paint'
     WHEN @CategoryId = 14 THEN 'Picker'
   ELSE 'Undefined'
   END
END