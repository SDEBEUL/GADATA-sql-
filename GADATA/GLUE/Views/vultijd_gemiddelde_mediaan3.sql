









CREATE VIEW [GLUE].[vultijd_gemiddelde_mediaan3]
AS
 
select DISTINCT
D.location
,R.Controller
,  cast(R.tijdstip as date) as time
, CAST(ROUND(avg(R.vultijd_ms) OVER (PARTITION BY  cast(R.tijdstip as date), R.Controller)/1000.0,5) AS DECIMAL(6,3)) as gemiddelde_vultijd_s
, T.Vyear AS 'Year'
, T.Vweek AS 'Week'
, T.Vday AS 'Day'
 from  GLUE.vultijd as R
     LEFT OUTER JOIN
VOLVO.L_timeline AS T ON 
cast(T.starttime as date) = cast(R.tijdstip as date)
left join glue.c_controller as D on D.controller_name=R.Controller