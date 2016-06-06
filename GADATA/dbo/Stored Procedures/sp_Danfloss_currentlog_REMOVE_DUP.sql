


CREATE PROCEDURE [dbo].[sp_Danfloss_currentlog_REMOVE_DUP]
AS
BEGIN
DELETE GADATA.dbo.rt_Danfloss_currentlog
--select lx.*
FROM GADATA.dbo.rt_Danfloss_currentlog as lx 
LEFT OUTER JOIN (
   SELECT 
   MIN(l.id) as 'id' 
   ,L._timestamp
   ,L._equipment
   ,L._current
   FROM  GADATA.dbo.rt_Danfloss_currentlog as l  
   GROUP BY    
    L._timestamp
   ,L._equipment
   ,L._current
) as KeepRows ON
   lx.Id = KeepRows.Id
WHERE
   KeepRows.Id IS NULL
END