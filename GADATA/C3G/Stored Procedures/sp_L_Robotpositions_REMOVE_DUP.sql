
CREATE PROCEDURE [C3G].[sp_L_Robotpositions_REMOVE_DUP]
AS
BEGIN
DELETE GADATA.C3G.L_robotpositions 
--select lx.*
FROM GADATA.C3G.L_robotpositions as lx 
LEFT OUTER JOIN (
   SELECT 
   MIN(l.id) as 'id' 
   --,L.file_timestamp
   ,L.controller_id
   ,L.Owner
   ,L.Pos
   ,L.x
   ,l.y
   ,L.z
   ,L.a
   ,L.e
   ,L.r
   ,L.ax7
   ,L.ax8
   ,L.Cnfg 
   FROM  GADATA.C3G.L_robotpositions as l  
   GROUP BY    
    --L.file_timestamp
    L.controller_id
   ,L.Owner
   ,L.Pos
   ,L.x
   ,l.y
   ,L.z
   ,L.a
   ,L.e
   ,L.r
   ,L.ax7
   ,L.ax8
   ,L.Cnfg 
) as KeepRows ON
   lx.Id = KeepRows.Id
WHERE
   KeepRows.Id IS NULL
END