CREATE TABLE [GLUE].[supervisorrapport_veiligheid] (
    [ID]                      INT          IDENTITY (1, 1) NOT NULL,
    [Datum]                   VARCHAR (50) NULL,
    [shift_veiligheid]        VARCHAR (50) NULL,
    [station_veiligheid]      VARCHAR (50) NULL,
    [omschrijving_veiligheid] VARCHAR (50) NULL,
    [Storingstijd_veiligheid] VARCHAR (50) NULL,
    [nog_aktie_veiligheid]    VARCHAR (50) NULL,
    [zone_veiligheid]         VARCHAR (50) NULL
);

