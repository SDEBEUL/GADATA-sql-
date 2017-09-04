CREATE TABLE [GLUE].[supervisorrapport_arbeidsongevallen] (
    [ID]                             INT            IDENTITY (1, 1) NOT NULL,
    [Datum]                          VARCHAR (1000) NULL,
    [shift_arbeidsongevallen]        VARCHAR (1000) NULL,
    [station_arbeidsongevallen]      VARCHAR (1000) NULL,
    [team_arbeidsongevallen]         VARCHAR (1000) NULL,
    [naam_arbeidsongevallen]         VARCHAR (1000) NULL,
    [omschrijving_arbeidsongevallen] VARCHAR (1000) NULL,
    [Storingstijd_arbeidsongevallen] VARCHAR (1000) NULL,
    [nog_aktie_arbeidsongevallen]    VARCHAR (1000) NULL,
    [zone_arbeidsongevallen]         VARCHAR (1000) NULL
);



