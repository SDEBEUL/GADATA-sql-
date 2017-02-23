



CREATE PROCEDURE [QUISS].[sp_QUISS_data]

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
Print '--Running GLUE.sp_QUISS_data'
print '--*****************************************************************************--'
---------------------------------------------------------------------------------------------------------------------
--****************************************************************************************************************--

---------------------------------------------------------------------------------------
Print'--add new controllers to table'
---------------------------------------------------------------------------------------

INSERT INTO GADATA.QUISS.Controller
SELECT  distinct      /*DISTINCT = De afzonderlijke locaties selecteren*/
 R1.Controller as 'Controller'  
From GADATA.QUISS.data as R1

Left join GADATA.QUISS.Controller as L1 on /* All the matching rows from both tables + non matching rows from rt_data (the left table) als er een nieuwe controller in rt_table staat, zal dit command ze in controller ook toevoegen*/
LTRIM(RTRIM(R1.Controller)) = LTRIM(RTRIM(L1.Name)) /* LTRIM and RTRIM linkse en rechtse spaties verwijderen/ invoegen in L1 naam*/

/*Hieruit worden alle gemeenschappelijke en niet gemeenschappelijke van rt_data verkregen (TOT) */

where 
(L1.id IS NULL)  /* Enkel de rijen waar het L1.id nul is worden de TOT controllers geinsert in de tabel / toevoegen waar er nog geen Controller ID staat = L1.ID IS NULL en waar het van de controllerlog komt logtype=2*/

/* dit komt neer op het eraan toevoegen van de nieuwe controllers */
---------------------------------------------------------------------------------------
Print'--add new Pieces to table'
---------------------------------------------------------------------------------------


INSERT INTO GADATA.QUISS.Stuk
SELECT  distinct      /*DISTINCT = De afzonderlijke locaties selecteren*/
R1.Stuk as 'Stuk'  
From GADATA.QUISS.data as R1

Left join GADATA.QUISS.Stuk as L1 on /* All the matching rows from both tables + non matching rows from rt_data (the left table) als er een nieuwe controller in rt_table staat, zal dit command ze in controller ook toevoegen*/
LTRIM(RTRIM(R1.Stuk)) = LTRIM(RTRIM(L1.Name)) /* LTRIM and RTRIM linkse en rechtse spaties verwijderen/ invoegen in L1 naam*/

where 
(L1.id IS NULL)

Print'--add new foutdirectory to table'
---------------------------------------------------------------------------------------


INSERT INTO GADATA.QUISS.foutdirectory
SELECT  distinct      /*DISTINCT = De afzonderlijke locaties selecteren*/
R1.foutdirectory as 'foutdirectory'  
From GADATA.QUISS.data as R1

Left join GADATA.QUISS.foutdirectory as L1 on /* All the matching rows from both tables + non matching rows from rt_data (the left table) als er een nieuwe controller in rt_table staat, zal dit command ze in controller ook toevoegen*/
LTRIM(RTRIM(R1.foutdirectory)) = LTRIM(RTRIM(L1.Name)) /* LTRIM and RTRIM linkse en rechtse spaties verwijderen/ invoegen in L1 naam*/

where 
(L1.id IS NULL)



---------------------------------------------------------------------------------------
Print'--step to normalize the rt_alarm dataset. gets the normalized id. and put it in a temp table'
---------------------------------------------------------------------------------------

if (OBJECT_ID('#QUISS_data_normalized') is not null) drop table #QUISS_data_normalized /* als de tijdelijke tabel nog in de database zit, verwijder deze */
SELECT 
--R.Location as 'tmp_contr'
R.DateTime as 'DatumTijd',
L.ID as 'Controller_id'
--,R.Str2 as 'tmp_User_id'
,L1.ID as 'Stuk_id'
--,R.str4 as 'tmp_OperatorActionInfo_id'
,L2.ID as 'foutdirectory_id'
,R.fouttoestand as 'fouttoestand'
,R.bodynummer as 'bodynummer'



INTO #QUISS_data_normalized

FROM GADATA.QUISS.data as R 

--join controller_id
join GADATA.QUISS.Controller as L on /*  alleen de gemeenschappelijke pakken (=inner join) */
LTRIM(RTRIM(R.Controller)) = LTRIM(RTRIM(L.Name))
/* steek in de 1ste kolom de controller ID die overeenkomt met het ID nummer van de controller in tabel controller */

-- join User_id
join GADATA.QUISS.Stuk as L1 on
LTRIM(RTRIM(R.Stuk)) = LTRIM(RTRIM(L1.Name))
/* steek in de 1ste kolom de user ID  die overeenkomt met het ID nummer van de user in tabel users */

-- join OperatorActionInfo_id
join GADATA.QUISS.foutdirectory as L2 on
LTRIM(RTRIM(R.foutdirectory)) = LTRIM(RTRIM(L2.Name))
/* steek in de 1ste kolom de action ID  die overeenkomt met het ID nummer van de action in tabel operatoractioninfo */

---------------------------------------------------------------------------------------

Select top 10000 * from #QUISS_data_normalized
--order by [Signal_id] desc


---------------------------------------------------------------------------------------
Print'--Cross compare and put into Hystorian if needed'
---------------------------------------------------------------------------------------
INSERT INTO GADATA.QUISS.alarm
SELECT 
R.DatumTijd
,R.Controller_id
,R.Stuk_id
,R.foutdirectory_id
,R.fouttoestand
,R.bodynummer
FROM #QUISS_data_normalized as R 


--this will filter out unique results
LEFT join GADATA.QUISS.alarm AS H on   --show also compare the logtekst here.... 
(
(R.controller_id  = H.Controller_id)
AND
(R.DatumTijd = H.c_timestamp) --was losing data because of this (controle side clock resolution = 1s so errors in the same S only 1 would pass. 
AND
(R.Stuk_id = H.Stuk_id)
AND
(R.foutdirectory_id = H.foutdirectory_id)
AND
(R.bodynummer = H.bodynummer)
)

/*nieuwe waarden van de linker tabel #GLUE_rt_alarm_normalized toevoegen aan h_operator(GLUE)*/
where (H.id IS NULL)  /*als in de lijn nog niets ingevuld is*/


DELETE FROM [QUISS].[data]  /*als data eraan toegevoegd, verwijder deze terug */

--****************************************************************************************************************--
END