CREATE TABLE [dbo].[PlateCoating] (
    [ID]    INT        IDENTITY (1, 1) NOT NULL,
    [Name]  NCHAR (50) NOT NULL,
    [Name2] NCHAR (50) NULL,
    CONSTRAINT [PK_PlateCoating] PRIMARY KEY CLUSTERED ([ID] ASC)
);

