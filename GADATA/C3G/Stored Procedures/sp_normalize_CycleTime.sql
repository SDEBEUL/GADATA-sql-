
CREATE PROCEDURE [C3G].[sp_normalize_CycleTime]
AS
BEGIN
UPDATE GADATA.C3G.rt_CycleTime
SET
   GADATA.C3G.rt_CycleTime._timeMS = GADATA.volvo.fn_GetNumberOfbits(rt.value,1,20)
,  GADATA.C3G.rt_CycleTime.plcOrder = GADATA.volvo.fn_GetNumberOfbits(rt.value,21,7) 
,  GADATA.C3G.rt_CycleTime.segment = GADATA.volvo.fn_GetNumberOfbits(rt.value,28,4)
FROM GADATA.C3G.rt_CycleTime as rt
where rt._timeMS is null
END