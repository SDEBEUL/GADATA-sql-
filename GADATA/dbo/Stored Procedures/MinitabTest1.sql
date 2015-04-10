CREATE PROCEDURE [dbo].[MinitabTest1]
   @Robot as varchar(30) = '%22040R10%'
   ,@Appl as varchar(30) = 'HAND%'
   ,@Subgroup as varchar(30) = '%'
AS
BEGIN

SELECT
L_Nextgen.cnBD
from L_Nextgen
where 
L_Nextgen.controller_name LIKE @robot
and
L_Nextgen.appl LIKE @APPL
AND
L_Nextgen.subgroup LIKE @Subgroup

order by controller_name, appl ,subgroup, year, week, day, shift desc


END