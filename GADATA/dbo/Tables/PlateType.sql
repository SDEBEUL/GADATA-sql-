CREATE TABLE [dbo].[PlateType] (
    [ID]        INT        IDENTITY (1, 1) NOT NULL,
    [Thickness] REAL       NOT NULL,
    [Material]  NCHAR (50) NOT NULL,
    [Coating]   NCHAR (50) NOT NULL,
    CONSTRAINT [PK_PlateType] PRIMARY KEY CLUSTERED ([ID] ASC)
);

