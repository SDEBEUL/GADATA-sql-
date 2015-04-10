CREATE TABLE [dbo].[UltralogStations] (
    [ID]   INT        IDENTITY (1, 1) NOT NULL,
    [Name] NCHAR (50) NOT NULL,
    CONSTRAINT [PK_UltralogStations] PRIMARY KEY CLUSTERED ([ID] ASC)
);

