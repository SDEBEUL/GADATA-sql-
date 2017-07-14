



CREATE PROCEDURE [GLUE].[sp_supervisorrapport2]

@shift_arbeidsongevallen as varchar(250) = null,
@station_arbeidsongevallen as varchar(250) = null,
@team_arbeidsongevallen as varchar(250) = null,

@naam_arbeidsongevallen as varchar(250) = null,
@omschrijving_arbeidsongevallen as varchar(250) = null,
@Storingstijd_arbeidsongevallen as varchar(250) = null,

@nog_aktie_arbeidsongevallen as varchar(250) = null,
@shift_kwaliteit as varchar(250) = null,
@station_kwaliteit as varchar(250) = null,

@omschrijving_kwaliteit as varchar(250) = null,
@storingstijd_kwaliteit as varchar(250) = null,
@nog_aktie_kwaliteit as varchar(250) = null,

@shift_delivery as varchar(250) = null,

@station_delivery as varchar(250) = null,

@omschrijving_delivery as varchar(250) = null,
@storingstijd_delivery as varchar(250) = null,
@nog_aktie_delivery as varchar(250) = null,

@shift_veiligheid as varchar(250) = null,
@station_veiligheid as varchar(250) = null,
@omschrijving_veiligheid as varchar(250) = null,

@storingstijd_veiligheid as varchar(250) = null,
@nog_aktie_veiligheid as varchar(250) = null,
@shift_medewerker as varchar(250) = null,

@station_medewerker as varchar(250) = null,
@omschrijving_medewerker as varchar(250) = null,
@storingstijd_medewerker as varchar(250) = null,

@nog_aktie_medewerker as varchar(250) = null,

@Kolom_arbeidsongevallen_ingevuld as bit = 0,

@Kolom_kwaliteit_ingevuld as bit = 0,

@Kolom_delivery_ingevuld as bit = 0,

@Kolom_veiligheid_ingevuld as bit = 0,

@Kolom_medewerker_ingevuld as bit = 0,

@Zieken_A as varchar(250) = null,

@Zieken_B as varchar(250) = null,

@Zieken_C as varchar(250) = null,

@Zone as varchar(250) = null,

@Datum as varchar(250) = null,

@Veld_Zieken_A_ingevuld as bit = 0,

@Veld_Zieken_B_ingevuld as bit = 0,

@Veld_Zieken_C_ingevuld as bit = 0

AS
BEGIN

---------------------------------------------------------------------------------------
if(@Kolom_arbeidsongevallen_ingevuld = 1)
BEGIN

if (OBJECT_ID('#supervisorrapport_arbeidsongevallen') is not null) drop table #supervisorrapport_arbeidsongevallen

SELECT @Datum AS Datum, @shift_arbeidsongevallen AS shift_arbeidsongevallen, @station_arbeidsongevallen AS station_arbeidsongevallen, @team_arbeidsongevallen AS team_arbeidsongevallen, @naam_arbeidsongevallen AS naam_arbeidsongevallen, @omschrijving_arbeidsongevallen AS omschrijving_arbeidsongevallen, @Storingstijd_arbeidsongevallen AS Storingstijd_arbeidsongevallen, 
@nog_aktie_arbeidsongevallen AS nog_aktie_arbeidsongevallen, @Zone AS zone_arbeidsongevallen
INTO #supervisorrapport_arbeidsongevallen

INSERT INTO GLUE.supervisorrapport_arbeidsongevallen

SELECT 
R.Datum
,R.shift_arbeidsongevallen
,R.station_arbeidsongevallen
,R.team_arbeidsongevallen
,R.naam_arbeidsongevallen
,R.omschrijving_arbeidsongevallen
,R.Storingstijd_arbeidsongevallen
,R.nog_aktie_arbeidsongevallen
,R.zone_arbeidsongevallen
FROM #supervisorrapport_arbeidsongevallen as R 


--this will filter out unique results
LEFT join GADATA.GLUE.supervisorrapport_arbeidsongevallen AS H on  
(
(R.Datum  = H.Datum)
AND
(R.shift_arbeidsongevallen = H.shift_arbeidsongevallen)
AND
(R.station_arbeidsongevallen = H.station_arbeidsongevallen) --was losing data because of this (controle side clock resolution = 1s so errors in the same S only 1 would pass. 
AND
(R.team_arbeidsongevallen = H.team_arbeidsongevallen)
AND
(R.naam_arbeidsongevallen = H.naam_arbeidsongevallen)
AND
(R.omschrijving_arbeidsongevallen = H.omschrijving_arbeidsongevallen)
AND
(R.Storingstijd_arbeidsongevallen = H.Storingstijd_arbeidsongevallen)
AND
(R.nog_aktie_arbeidsongevallen = H.nog_aktie_arbeidsongevallen)
AND
(R.zone_arbeidsongevallen = H.zone_arbeidsongevallen)
)
where (H.id IS NULL) 

END

if(@Kolom_kwaliteit_ingevuld = 1)
BEGIN

if (OBJECT_ID('#supervisorrapport_kwaliteit') is not null) drop table #supervisorrapport_kwaliteit

SELECT @Datum AS Datum, @shift_kwaliteit AS shift_kwaliteit, @station_kwaliteit AS station_kwaliteit, @omschrijving_kwaliteit AS omschrijving_kwaliteit, @Storingstijd_kwaliteit AS Storingstijd_kwaliteit, 
@nog_aktie_kwaliteit AS nog_aktie_kwaliteit, @Zone AS zone_kwaliteit
INTO #supervisorrapport_kwaliteit

INSERT INTO GLUE.supervisorrapport_kwaliteit

SELECT 
R.Datum
,R.shift_kwaliteit
,R.station_kwaliteit
,R.omschrijving_kwaliteit
,R.Storingstijd_kwaliteit
,R.nog_aktie_kwaliteit
,R.zone_kwaliteit
FROM #supervisorrapport_kwaliteit as R 


--this will filter out unique results
LEFT join GADATA.GLUE.supervisorrapport_kwaliteit AS H on  
(
(R.Datum  = H.Datum)
AND
(R.shift_kwaliteit = H.shift_kwaliteit)
AND
(R.station_kwaliteit = H.station_kwaliteit) --was losing data because of this (controle side clock resolution = 1s so errors in the same S only 1 would pass. 
AND

(R.omschrijving_kwaliteit = H.omschrijving_kwaliteit)
AND
(R.Storingstijd_kwaliteit = H.Storingstijd_kwaliteit)
AND
(R.nog_aktie_kwaliteit = H.nog_aktie_kwaliteit)
AND
(R.zone_kwaliteit = H.zone_kwaliteit)
)
where (H.id IS NULL) 

END

if(@Kolom_delivery_ingevuld = 1)
BEGIN
if (OBJECT_ID('#supervisorrapport_delivery') is not null) drop table #supervisorrapport_delivery

SELECT @Datum AS Datum, @shift_delivery AS shift_delivery, @station_delivery AS station_delivery, @omschrijving_delivery AS omschrijving_delivery, @Storingstijd_delivery AS Storingstijd_delivery, 
@nog_aktie_delivery AS nog_aktie_delivery, @Zone AS zone_delivery
INTO #supervisorrapport_delivery

INSERT INTO GLUE.supervisorrapport_delivery

SELECT 
R.Datum
,R.shift_delivery
,R.station_delivery
,R.omschrijving_delivery
,R.Storingstijd_delivery
,R.nog_aktie_delivery
,R.zone_delivery
FROM #supervisorrapport_delivery as R 


--this will filter out unique results
LEFT join GADATA.GLUE.supervisorrapport_delivery AS H on  
(
(R.Datum  = H.Datum)
AND
(R.shift_delivery = H.shift_delivery)
AND
(R.station_delivery = H.station_delivery) --was losing data because of this (controle side clock resolution = 1s so errors in the same S only 1 would pass. 
AND

(R.omschrijving_delivery = H.omschrijving_delivery)
AND
(R.Storingstijd_delivery = H.Storingstijd_delivery)
AND
(R.nog_aktie_delivery = H.nog_aktie_delivery)
AND
(R.zone_delivery = H.zone_delivery)
)
where (H.id IS NULL) 
END

if(@Kolom_veiligheid_ingevuld = 1)
BEGIN
if (OBJECT_ID('#supervisorrapport_veiligheid') is not null) drop table #supervisorrapport_veiligheid

SELECT @Datum AS Datum, @shift_veiligheid AS shift_veiligheid, @station_veiligheid AS station_veiligheid, @omschrijving_veiligheid AS omschrijving_veiligheid, @Storingstijd_veiligheid AS Storingstijd_veiligheid, 
@nog_aktie_veiligheid AS nog_aktie_veiligheid, @Zone AS zone_veiligheid
INTO #supervisorrapport_veiligheid

INSERT INTO GLUE.supervisorrapport_veiligheid

SELECT 
R.Datum
,R.shift_veiligheid
,R.station_veiligheid
,R.omschrijving_veiligheid
,R.Storingstijd_veiligheid
,R.nog_aktie_veiligheid
,R.zone_veiligheid
FROM #supervisorrapport_veiligheid as R 


--this will filter out unique results
LEFT join GADATA.GLUE.supervisorrapport_veiligheid AS H on  
(
(R.Datum  = H.Datum)
AND
(R.shift_veiligheid = H.shift_veiligheid)
AND
(R.station_veiligheid = H.station_veiligheid) --was losing data because of this (controle side clock resolution = 1s so errors in the same S only 1 would pass. 
AND

(R.omschrijving_veiligheid = H.omschrijving_veiligheid)
AND
(R.Storingstijd_veiligheid = H.Storingstijd_veiligheid)
AND
(R.nog_aktie_veiligheid = H.nog_aktie_veiligheid)
AND
(R.zone_veiligheid = H.zone_veiligheid)
)
where (H.id IS NULL) 
END

if(@Kolom_medewerker_ingevuld = 1)
BEGIN
if (OBJECT_ID('#supervisorrapport_medewerker') is not null) drop table #supervisorrapport_medewerker

SELECT @Datum AS Datum, @shift_medewerker AS shift_medewerker, @station_medewerker AS station_medewerker, @omschrijving_medewerker AS omschrijving_medewerker, @Storingstijd_medewerker AS Storingstijd_medewerker, 
@nog_aktie_medewerker AS nog_aktie_medewerker, @Zone AS zone_medewerker
INTO #supervisorrapport_medewerker

INSERT INTO GLUE.supervisorrapport_medewerker

SELECT 
R.Datum
,R.shift_medewerker
,R.station_medewerker
,R.omschrijving_medewerker
,R.Storingstijd_medewerker
,R.nog_aktie_medewerker
,R.zone_medewerker
FROM #supervisorrapport_medewerker as R 


--this will filter out unique results
LEFT join GADATA.GLUE.supervisorrapport_medewerker AS H on  
(
(R.Datum  = H.Datum)
AND
(R.shift_medewerker = H.shift_medewerker)
AND
(R.station_medewerker = H.station_medewerker) --was losing data because of this (controle side clock resolution = 1s so errors in the same S only 1 would pass. 
AND

(R.omschrijving_medewerker = H.omschrijving_medewerker)
AND
(R.Storingstijd_medewerker = H.Storingstijd_medewerker)
AND
(R.nog_aktie_medewerker = H.nog_aktie_medewerker)
AND
(R.zone_medewerker = H.zone_medewerker)
)
where (H.id IS NULL) 
END

if(@Veld_Zieken_A_ingevuld = 1)
BEGIN
if (OBJECT_ID('#supervisorrapport_zieken_A') is not null) drop table #supervisorrapport_zieken_A

SELECT @Datum AS Datum, 'A' AS shift, @Zieken_A AS aantal_zieken, @Zone AS Zone
INTO #supervisorrapport_zieken_A

INSERT INTO GLUE.supervisorrapport_zieken

SELECT 
R.Datum
,R.shift
,R.aantal_zieken
,R.Zone
FROM #supervisorrapport_zieken_A as R

LEFT join GADATA.GLUE.supervisorrapport_zieken AS H on  
(
(R.Datum  = H.Datum)
AND
(R.shift = H.shift)
AND
(R.aantal_zieken = H.aantal_zieken) --was losing data because of this (controle side clock resolution = 1s so errors in the same S only 1 would pass. 
AND
(R.Zone = H.Zone)
)
where (H.id IS NULL) 
END

if(@Veld_Zieken_B_ingevuld = 1)
BEGIN

if (OBJECT_ID('#supervisorrapport_zieken_B') is not null) drop table #supervisorrapport_zieken_B

SELECT @Datum AS Datum, 'B' AS shift, @Zieken_B AS aantal_zieken, @Zone AS Zone
INTO #supervisorrapport_zieken_B

INSERT INTO GLUE.supervisorrapport_zieken

SELECT 
R.Datum
,R.shift
,R.aantal_zieken
,R.Zone
FROM #supervisorrapport_zieken_B as R

LEFT join GADATA.GLUE.supervisorrapport_zieken AS H on  
(
(R.Datum  = H.Datum)
AND
(R.shift = H.shift)
AND
(R.aantal_zieken = H.aantal_zieken) --was losing data because of this (controle side clock resolution = 1s so errors in the same S only 1 would pass. 
AND
(R.Zone = H.Zone)
)
where (H.id IS NULL) 
END

if(@Veld_Zieken_C_ingevuld = 1)
BEGIN

if (OBJECT_ID('#supervisorrapport_zieken_C') is not null) drop table #supervisorrapport_zieken_C

SELECT @Datum AS Datum, 'C' AS shift, @Zieken_C AS aantal_zieken, @Zone AS Zone
INTO #supervisorrapport_zieken_C

INSERT INTO GLUE.supervisorrapport_zieken

SELECT 
R.Datum
,R.shift
,R.aantal_zieken
,R.Zone
FROM #supervisorrapport_zieken_C as R

LEFT join GADATA.GLUE.supervisorrapport_zieken AS H on  
(
(R.Datum  = H.Datum)
AND
(R.shift = H.shift)
AND
(R.aantal_zieken = H.aantal_zieken) --was losing data because of this (controle side clock resolution = 1s so errors in the same S only 1 would pass. 
AND
(R.Zone = H.Zone)
)
where (H.id IS NULL) 
END

END