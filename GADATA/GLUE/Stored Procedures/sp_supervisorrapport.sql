






CREATE PROCEDURE [GLUE].[sp_supervisorrapport]


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

@OKGA_P3 as varchar(250) = null,

@geplande_cijfers_WIP_GB as varchar(250) = null,

@geplande_cijfers_BB_available as varchar(250) = null,

@geplande_cijfers_BB_preorder as varchar(250) = null,

@geplande_cijfers_5ekraan as varchar(250) = null,

@OLGC as varchar(250) = null,

@Datum as varchar(250) = null

AS
BEGIN

---------------------------------------------------------------------------------------
if(@OKGA_P3 = 1)
BEGIN
INSERT INTO GLUE.supervisorrapport_arbeidsongevallen(Datum,shift_arbeidsongevallen, station_arbeidsongevallen, team_arbeidsongevallen, naam_arbeidsongevallen, omschrijving_arbeidsongevallen, Storingstijd_arbeidsongevallen, 
nog_aktie_arbeidsongevallen)
VALUES(@Datum, @shift_arbeidsongevallen, @station_arbeidsongevallen, @team_arbeidsongevallen, @naam_arbeidsongevallen, @omschrijving_arbeidsongevallen, @Storingstijd_arbeidsongevallen, 
@nog_aktie_arbeidsongevallen)
END

if(@geplande_cijfers_WIP_GB = 1)
BEGIN
INSERT INTO GLUE.supervisorrapport_kwaliteit(Datum,shift_kwaliteit, station_kwaliteit, omschrijving_kwaliteit, Storingstijd_kwaliteit, 
nog_aktie_kwaliteit)
VALUES(@Datum, @shift_kwaliteit, @station_kwaliteit, @omschrijving_kwaliteit, @Storingstijd_kwaliteit, 
@nog_aktie_kwaliteit)
END

if(@geplande_cijfers_BB_available = 1)
BEGIN
INSERT INTO GLUE.supervisorrapport_delivery(Datum,shift_delivery, station_delivery, omschrijving_delivery, Storingstijd_delivery, 
nog_aktie_delivery)
VALUES(@Datum, @shift_delivery, @station_delivery, @omschrijving_delivery, @Storingstijd_delivery, 
@nog_aktie_delivery)
END

if(@geplande_cijfers_BB_preorder = 1)
BEGIN
INSERT INTO GLUE.supervisorrapport_veiligheid(Datum,shift_veiligheid, station_veiligheid, omschrijving_veiligheid, Storingstijd_veiligheid, 
nog_aktie_veiligheid)
VALUES(@Datum, @shift_veiligheid, @station_veiligheid, @omschrijving_veiligheid, @Storingstijd_veiligheid, 
@nog_aktie_veiligheid)
END

if(@geplande_cijfers_5ekraan = 1)
BEGIN
INSERT INTO GLUE.supervisorrapport_medewerker(Datum,shift_medewerker, station_medewerker, omschrijving_medewerker, Storingstijd_medewerker, 
nog_aktie_medewerker)
VALUES(@Datum, @shift_medewerker, @station_medewerker, @omschrijving_medewerker, @Storingstijd_medewerker, 
@nog_aktie_medewerker)
END

END