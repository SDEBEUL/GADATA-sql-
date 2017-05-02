

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
INSERT INTO GLUE.supervisorrapport_arbeidsongevallen(Datum,shift_arbeidsongevallen, station_arbeidsongevallen, team_arbeidsongevallen, naam_arbeidsongevallen, omschrijving_arbeidsongevallen, Storingstijd_arbeidsongevallen, 
nog_aktie_arbeidsongevallen, Zone_arbeidsongevallen)
VALUES(@Datum, @shift_arbeidsongevallen, @station_arbeidsongevallen, @team_arbeidsongevallen, @naam_arbeidsongevallen, @omschrijving_arbeidsongevallen, @Storingstijd_arbeidsongevallen, 
@nog_aktie_arbeidsongevallen, @Zone)
END

if(@Kolom_kwaliteit_ingevuld = 1)
BEGIN
INSERT INTO GLUE.supervisorrapport_kwaliteit(Datum,shift_kwaliteit, station_kwaliteit, omschrijving_kwaliteit, Storingstijd_kwaliteit, 
nog_aktie_kwaliteit, Zone_kwaliteit)
VALUES(@Datum, @shift_kwaliteit, @station_kwaliteit, @omschrijving_kwaliteit, @Storingstijd_kwaliteit, 
@nog_aktie_kwaliteit, @Zone)
END

if(@Kolom_delivery_ingevuld = 1)
BEGIN
INSERT INTO GLUE.supervisorrapport_delivery(Datum,shift_delivery, station_delivery, omschrijving_delivery, Storingstijd_delivery, 
nog_aktie_delivery, Zone_delivery)
VALUES(@Datum, @shift_delivery, @station_delivery, @omschrijving_delivery, @Storingstijd_delivery, 
@nog_aktie_delivery, @Zone)
END

if(@Kolom_veiligheid_ingevuld = 1)
BEGIN
INSERT INTO GLUE.supervisorrapport_veiligheid(Datum,shift_veiligheid, station_veiligheid, omschrijving_veiligheid, Storingstijd_veiligheid, 
nog_aktie_veiligheid, Zone_veiligheid)
VALUES(@Datum, @shift_veiligheid, @station_veiligheid, @omschrijving_veiligheid, @Storingstijd_veiligheid, 
@nog_aktie_veiligheid, @Zone)
END

if(@Kolom_medewerker_ingevuld = 1)
BEGIN
INSERT INTO GLUE.supervisorrapport_medewerker(Datum,shift_medewerker, station_medewerker, omschrijving_medewerker, Storingstijd_medewerker, 
nog_aktie_medewerker, Zone_medewerker)
VALUES(@Datum, @shift_medewerker, @station_medewerker, @omschrijving_medewerker, @Storingstijd_medewerker, 
@nog_aktie_medewerker, @Zone)
END

if(@Veld_Zieken_A_ingevuld = 1)
BEGIN
INSERT INTO GLUE.supervisorrapport_zieken(Datum,shift,aantal_zieken, Zone)
VALUES(@Datum, 'A', @Zieken_A, @Zone)
END

if(@Veld_Zieken_B_ingevuld = 1)
BEGIN
INSERT INTO GLUE.supervisorrapport_zieken(Datum,shift,aantal_zieken, Zone)
VALUES(@Datum, 'B', @Zieken_B, @Zone)
END

if(@Veld_Zieken_C_ingevuld = 1)
BEGIN
INSERT INTO GLUE.supervisorrapport_zieken(Datum,shift,aantal_zieken, Zone)
VALUES(@Datum, 'C', @Zieken_C, @Zone)
END

END