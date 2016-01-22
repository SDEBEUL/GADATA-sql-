
CREATE PROCEDURE [C3G].[sp_normalize_GunCylinder]
AS
BEGIN
UPDATE GADATA.C3G.rt_GunCylinder
SET
 CloseToSemi = GADATA.volvo.fn_GetNumberOfbits(rt.value,3,14)
,SemiToOpen = GADATA.volvo.fn_GetNumberOfbits(rt.value,17,14)
,Tool_id = GADATA.volvo.fn_GetNumberOfbits(rt.value,1,2) +1
FROM GADATA.C3G.rt_GunCylinder as rt
where rt.Tool_id is null
END