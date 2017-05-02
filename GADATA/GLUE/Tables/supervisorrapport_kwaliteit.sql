CREATE TABLE [GLUE].[supervisorrapport_kwaliteit] (
    [ID]                     INT          IDENTITY (1, 1) NOT NULL,
    [Datum]                  VARCHAR (50) NULL,
    [shift_kwaliteit]        VARCHAR (50) NULL,
    [station_kwaliteit]      VARCHAR (50) NULL,
    [omschrijving_kwaliteit] VARCHAR (50) NULL,
    [Storingstijd_kwaliteit] VARCHAR (50) NULL,
    [nog_aktie_kwaliteit]    VARCHAR (50) NULL,
    [zone_kwaliteit]         VARCHAR (50) NULL
);

