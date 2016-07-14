






CREATE VIEW [GLUE].[vultijdspcviewer2]
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
,ROUND(ref.UCL1,2) as 'UCL1'
,ROUND(ref.UCL2,2) as 'UCL2'
,ROUND(ref.UCL3,2) as 'UCL3'
,ROUND(ref.UCL4,2) as 'UCL4'
,ROUND(ref.UCL5,2) as 'UCL5'
,ref.nDataPoints as 'RefDp'
,ref.SampleStart as 'RefSS'
FROM GADATA.GLUE.vultijd as rt 
--left join GADATA.volvo.L_timeline as lt on rt._timestamp between lt.starttime and lt.endtime
left join GLUE.VULTIJDreferentie2 as ref on ref.Controller = rt.Controller