CREATE TABLE [dbo].[Users] (
    [ID]         INT        IDENTITY (1, 1) NOT NULL,
    [CDSID]      NCHAR (10) NOT NULL,
    [Voornaam]   NCHAR (25) NULL,
    [Achternaam] NCHAR (50) NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([ID] ASC)
);

