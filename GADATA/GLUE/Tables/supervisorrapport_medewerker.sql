CREATE TABLE [GLUE].[supervisorrapport_medewerker] (
    [ID]                      INT          IDENTITY (1, 1) NOT NULL,
    [Datum]                   VARCHAR (50) NULL,
    [shift_medewerker]        VARCHAR (50) NULL,
    [station_medewerker]      VARCHAR (50) NULL,
    [omschrijving_medewerker] VARCHAR (50) NULL,
    [Storingstijd_medewerker] VARCHAR (50) NULL,
    [nog_aktie_medewerker]    VARCHAR (50) NULL,
    [zone_medewerker]         VARCHAR (50) NULL
);

