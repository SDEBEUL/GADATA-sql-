CREATE TABLE [GLUE].[supervisorrapport_delivery] (
    [ID]                    INT          IDENTITY (1, 1) NOT NULL,
    [Datum]                 VARCHAR (50) NULL,
    [shift_delivery]        VARCHAR (50) NULL,
    [station_delivery]      VARCHAR (50) NULL,
    [omschrijving_delivery] VARCHAR (50) NULL,
    [Storingstijd_delivery] VARCHAR (50) NULL,
    [nog_aktie_delivery]    VARCHAR (50) NULL,
    [zone_delivery]         VARCHAR (50) NULL
);

