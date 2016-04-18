

CREATE PROCEDURE [C3G].[sp_rt_toollog_REMOVE_DUP]
AS
BEGIN
DELETE GADATA.C3G.rt_toollog 
--select lx.*
FROM GADATA.C3G.rt_toollog as lx 
LEFT OUTER JOIN (
   SELECT 
   MIN(l.id) as 'id' 
   ,L.tool_timestamp
   ,L.controller_id
   ,L.tool_id
   FROM  GADATA.C3G.rt_toollog as l  
   GROUP BY    
    L.tool_timestamp
   ,L.controller_id
   ,L.tool_id
) as KeepRows ON
   lx.Id = KeepRows.Id
WHERE
   KeepRows.Id IS NULL
END