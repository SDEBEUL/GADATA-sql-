





CREATE PROCEDURE [GLUE].[sp_vultijd]

AS
--USE GADATA
---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------
BEGIN
--****************************************************************************************************************--
---------------------------------------------------------------------------------------------------------------------
--In this part we will compare the error text data from rt_alarm with the L_<logtext> tables.
--This is the first part in normalizing the db. (store each text / error type once)
/*Normaliseren= opslaan in kleinere tabellen en verwijzen naar de ID*/
print '--*****************************************************************************--'
Print '--Running GLUE.sp_vultijd'
print '--*****************************************************************************--'
---------------------------------------------------------------------------------------------------------------------
--****************************************************************************************************************--

---------------------------------------------------------------------------------------
Print'--add new controllers to table'
---------------------------------------------------------------------------------------

  INSERT INTO GADATA.GLUE.Controller
  SELECT DISTINCT R1.controller
  FROM  (
 SELECT house.DateTime,house.controller,DATEDIFF(ms,house.DateTime,house.LEAD) as vultijd_ms
  FROM
  (
  SELECT *,LEAD(DateTime,2) OVER (ORDER BY DateTime) AS LEAD FROM GADATA.GLUE.vultijd_data
  WHERE Str3=1 
  ) as house
  where Str1=1
  ) as R1

  left join GADATA.GLUE.Controller as L1 on 
  LTRIM(RTRIM(R1.controller)) = LTRIM(RTRIM(L1.Name))

  where 
(L1.id IS NULL)



---------------------------------------------------------------------------------------
Print'--step to normalize the rt_alarm dataset. gets the normalized id. and put it in a temp table'
---------------------------------------------------------------------------------------

if (OBJECT_ID('#vultijden_normalized') is not null) drop table #vultijden_normalized /* als de tijdelijke tabel nog in de database zit, verwijder deze */
SELECT 
R.DateTime as 'DatumTijd',
L.ID as 'Controller_id',
R.vultijd_ms

INTO #vultijden_normalized

FROM (
 SELECT house.DateTime,house.controller,DATEDIFF(ms,house.DateTime,house.LEAD) as vultijd_ms
  FROM
  (
  SELECT *,LEAD(DateTime,2) OVER (ORDER BY DateTime) AS LEAD FROM GADATA.GLUE.vultijd_data
  WHERE Str3=1 
  ) as house
  where Str1=1
  ) as R

--join controller_id
join GADATA.GLUE.Controller as L on /*  alleen de gemeenschappelijke pakken (=inner join) */
LTRIM(RTRIM(R.controller)) = LTRIM(RTRIM(L.Name))
/* steek in de 1ste kolom de controller ID die overeenkomt met het ID nummer van de controller in tabel controller */

---------------------------------------------------------------------------------------

--Select top 10000 * from #vultijden_normalized
--order by [Signal_id] desc


---------------------------------------------------------------------------------------
Print'--Cross compare and put into Hystorian if needed'
---------------------------------------------------------------------------------------
INSERT INTO GADATA.GLUE.vultijden
SELECT 
R.DatumTijd
,R.Controller_id
,R.vultijd_ms
FROM #vultijden_normalized as R 

--this will filter out unique results
LEFT join GADATA.GLUE.vultijden AS H on   --show also compare the logtekst here.... 
(
(R.controller_id  = H.Controller_id)
AND
(R.DatumTijd = H.c_timestamp) --was losing data because of this (controle side clock resolution = 1s so errors in the same S only 1 would pass. 
AND
(R.vultijd_ms = H.vultijd_ms)
)

/*nieuwe waarden van de linker tabel #GLUE_rt_alarm_normalized toevoegen aan h_operator(GLUE)*/
where (H.id IS NULL)  /*als in de lijn nog niets ingevuld is*/


-- delete rt data where logtype =1
---------------------------------------------------------------------------------------
Print'--delete data'
---------------------------------------------------------------------------------------

DELETE FROM [GLUE].[vultijd_data] --where GLUE.vultijd_data.ID <= (select max(id) from #vultijden_normalized)  /*als data eraan toegevoegd, verwijder deze terug */

--****************************************************************************************************************--
END