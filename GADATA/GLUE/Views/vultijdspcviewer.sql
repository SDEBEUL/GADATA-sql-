





CREATE VIEW [GLUE].[vultijdspcviewer]
AS
SELECT 
 rt.location
,rt.Controller
,rt.vultijd_s
,rt.tijdstip as time
,rt.Year
,rt.Week
,rt.Day
,ROUND(ref.avg,2) as 'RefAVG'
,ROUND(ref.Stdev,2) as 'RefSTDEC'
,ROUND(ref.LCL,2) as 'LCL'
,ROUND(ref.UCL,2) as 'UCL'
,ref.nDataPoints as 'RefDp'
,ref.SampleStart as 'RefSS'
FROM GADATA.GLUE.vultijd as rt 
--left join GADATA.volvo.L_timeline as lt on rt._timestamp between lt.starttime and lt.endtime
left join GLUE.VULTIJDreferentie as ref on ref.Controller = rt.Controller