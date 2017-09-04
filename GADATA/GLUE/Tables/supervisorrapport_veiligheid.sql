CREATE TABLE [GLUE].[supervisorrapport_veiligheid] (
    [ID]                      INT            IDENTITY (1, 1) NOT NULL,
    [Datum]                   VARCHAR (1000) NULL,
    [shift_veiligheid]        VARCHAR (1000) NULL,
    [station_veiligheid]      VARCHAR (1000) NULL,
    [omschrijving_veiligheid] VARCHAR (1000) NULL,
    [Storingstijd_veiligheid] VARCHAR (1000) NULL,
    [nog_aktie_veiligheid]    VARCHAR (1000) NULL,
    [zone_veiligheid]         VARCHAR (1000) NULL
);



