CREATE TABLE [GLUE].[supervisorrapport_kwaliteit] (
    [ID]                     INT            IDENTITY (1, 1) NOT NULL,
    [Datum]                  VARCHAR (1000) NULL,
    [shift_kwaliteit]        VARCHAR (1000) NULL,
    [station_kwaliteit]      VARCHAR (1000) NULL,
    [omschrijving_kwaliteit] VARCHAR (1000) NULL,
    [Storingstijd_kwaliteit] VARCHAR (1000) NULL,
    [nog_aktie_kwaliteit]    VARCHAR (1000) NULL,
    [zone_kwaliteit]         VARCHAR (1000) NULL
);



