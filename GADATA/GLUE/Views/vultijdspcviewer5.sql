



CREATE VIEW [GLUE].[vultijdspcviewer5]
AS
SELECT 
 rt.location
,rt.Controller
,rt.gemiddelde_vultijd_s
,rt.time
,rt.Year
,rt.Week
,rt.Day
,ROUND(ref.avg,2) as 'RefAVG'
,ROUND(ref.Stdev,2) as 'RefSTDEC'
,ref.UCLnumber as 'UCLnumber'
,ROUND(ref.UCL3,2) as 'UCL3'
,ROUND(ref.UCL4,2) as 'UCL4'
,ROUND(ref.UCL5,2) as 'UCL5'
,ROUND(ref.UCLx,2) as 'UCLx'
,ref.nDataPoints as 'RefDp'
,ref.SampleStart as 'RefSS'
FROM GADATA.GLUE.vultijd_gemiddelde_mediaan as rt 
--left join GADATA.volvo.L_timeline as lt on rt._timestamp between lt.starttime and lt.endtime
left join GLUE.VULTIJDreferentie3 as ref on ref.Controller = rt.Controller