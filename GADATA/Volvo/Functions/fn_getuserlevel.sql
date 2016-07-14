


CREATE FUNCTION [Volvo].[fn_getuserlevel] (@User varchar(255)) 
RETURNS int
AS 
BEGIN 
DECLARE @usercount as int 

SET @usercount = (SELECT count(u.cds) from GADATA.volvo.Users as u where @user like '%'+u.cds+'%' )
 if @usercount = 0
	BEGIN
	 RETURN 0
	END

RETURN (SELECT min(u.Ulevel) from GADATA.volvo.Users as u where @user like '%'+u.cds+'%' )
END