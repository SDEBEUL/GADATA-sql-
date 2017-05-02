CREATE TABLE [GLUE].[supervisorrapport_arbeidsongevallen] (
    [ID]                             INT          IDENTITY (1, 1) NOT NULL,
    [Datum]                          VARCHAR (50) NULL,
    [shift_arbeidsongevallen]        VARCHAR (50) NULL,
    [station_arbeidsongevallen]      VARCHAR (50) NULL,
    [team_arbeidsongevallen]         VARCHAR (50) NULL,
    [naam_arbeidsongevallen]         VARCHAR (50) NULL,
    [omschrijving_arbeidsongevallen] VARCHAR (50) NULL,
    [Storingstijd_arbeidsongevallen] VARCHAR (50) NULL,
    [nog_aktie_arbeidsongevallen]    VARCHAR (50) NULL,
    [zone_arbeidsongevallen]         VARCHAR (50) NULL
);

