










CREATE PROCEDURE [GLUE].[sp_vultijd2]

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
						SELECT DateTime,controller,vultijd_ms FROM
		(Select *,DATEDIFF(ms,house2.DateTime,house2.LEADDATE) as vultijd_ms
		FROM(
				  select *, LEAD(DateTime,1) OVER (PARTITION BY controller ORDER BY DateTime ASC) AS LEADDATE, LEAD(Str1,1) OVER (PARTITION BY controller ORDER BY DateTime ASC) AS LEADTEST1, LEAD(Str2,1) OVER (PARTITION BY controller ORDER BY DateTime ASC) AS LEADTEST2
		  FROM
    (

		SELECT *, LAG(Str1,1) OVER (PARTITION BY G.controller ORDER BY DateTime ASC) AS LAG1_1 ,LAG(Str1,2)OVER (PARTITION BY G.controller ORDER BY DateTime ASC) AS LAG1_2 ,LAG(Str1,3)OVER (PARTITION BY G.controller ORDER BY DateTime ASC) AS LAG1_3,LEAD(Str1,1) OVER (PARTITION BY G.controller ORDER BY DateTime ASC) AS LEAD1_1 ,LEAD(Str1,2)OVER (PARTITION BY G.controller ORDER BY DateTime ASC) AS LEAD1_2 ,LEAD(Str1,3)OVER (PARTITION BY G.controller ORDER BY DateTime ASC) AS LEAD1_3
	, ROW_NUMBER() OVER (PARTITION BY G.controller ORDER BY DateTime ASC) AS rnDESC 
	FROM GADATA.GLUE.vultijd_data2 as G
	--ORDER BY controller
	--where controller='22030SH04'

	) as house

		where Str1=1 AND Str2=0 AND house.LAG1_1=0 AND house.LAG1_2=0 AND house.LAG1_3=0

		OR Str1=1 AND Str2=1 AND house.LEAD1_1=0 AND house.LEAD1_2=0 AND house.LEAD1_3=0) as house2



		where Str1=1 AND Str2=0 AND LEADTEST1=1 AND LEADTEST2=1 ) as house3
		
		where house3.vultijd_ms < 100000 --als groter dan 100 treed er nosense op dus uitfilteren, zie printscreens	
  ) as R1

  left join GADATA.GLUE.Controller as L1 on 
  LTRIM(RTRIM(R1.controller)) = LTRIM(RTRIM(L1.Name))

  where 
(L1.id IS NULL)



---------------------------------------------------------------------------------------
Print'--step to normalize the rt_alarm dataset. gets the normalized id. and put it in a temp table'
---------------------------------------------------------------------------------------

if (OBJECT_ID('#vultijden_normalized2') is not null) drop table #vultijden_normalized2 /* als de tijdelijke tabel nog in de database zit, verwijder deze */
SELECT 
R.DateTime as 'DatumTijd',
L.ID as 'Controller_id',
R.vultijd_ms

INTO #vultijden_normalized2

FROM (
		SELECT DateTime,controller,vultijd_ms FROM
		(Select *,DATEDIFF(ms,house2.DateTime,house2.LEADDATE) as vultijd_ms
		FROM(
				  select *, LEAD(DateTime,1) OVER (PARTITION BY controller ORDER BY DateTime ASC) AS LEADDATE, LEAD(Str1,1) OVER (PARTITION BY controller ORDER BY DateTime ASC) AS LEADTEST1, LEAD(Str2,1) OVER (PARTITION BY controller ORDER BY DateTime ASC) AS LEADTEST2
		  FROM
    (

		SELECT *, LAG(Str1,1) OVER (PARTITION BY G.controller ORDER BY DateTime ASC) AS LAG1_1 ,LAG(Str1,2)OVER (PARTITION BY G.controller ORDER BY DateTime ASC) AS LAG1_2 ,LAG(Str1,3)OVER (PARTITION BY G.controller ORDER BY DateTime ASC) AS LAG1_3,LEAD(Str1,1) OVER (PARTITION BY G.controller ORDER BY DateTime ASC) AS LEAD1_1 ,LEAD(Str1,2)OVER (PARTITION BY G.controller ORDER BY DateTime ASC) AS LEAD1_2 ,LEAD(Str1,3)OVER (PARTITION BY G.controller ORDER BY DateTime ASC) AS LEAD1_3
	, ROW_NUMBER() OVER (PARTITION BY G.controller ORDER BY DateTime ASC) AS rnDESC 
	FROM GADATA.GLUE.vultijd_data2 as G
	--ORDER BY controller
	--where controller='22030SH04'

	) as house

		where Str1=1 AND Str2=0 AND house.LAG1_1=0 AND house.LAG1_2=0 AND house.LAG1_3=0

		OR Str1=1 AND Str2=1 AND house.LEAD1_1=0 AND house.LEAD1_2=0 AND house.LEAD1_3=0) as house2



		where Str1=1 AND Str2=0 AND LEADTEST1=1 AND LEADTEST2=1 ) as house3
		
		where house3.vultijd_ms < 100000 --als groter dan 100 treed er nosense op dus uitfilteren, zie printscreens	
  ) as R

--join controller_id
join GADATA.GLUE.Controller as L on /*  alleen de gemeenschappelijke pakken (=inner join) */
LTRIM(RTRIM(R.controller)) = LTRIM(RTRIM(L.Name))
/* steek in de 1ste kolom de controller ID die overeenkomt met het ID nummer van de controller in tabel controller */

---------------------------------------------------------------------------------------

Select top 10000 * from #vultijden_normalized2
--order by [Signal_id] desc


---------------------------------------------------------------------------------------
Print'--Cross compare and put into Hystorian if needed'
---------------------------------------------------------------------------------------
INSERT INTO GADATA.GLUE.vultijden
SELECT 
R.DatumTijd
,R.Controller_id
,R.vultijd_ms
FROM #vultijden_normalized2 as R 

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

DELETE FROM [GLUE].[vultijd_data2] --where GLUE.vultijd_data.ID <= (select max(id) from #vultijden_normalized)  /*als data eraan toegevoegd, verwijder deze terug */

--****************************************************************************************************************--
END