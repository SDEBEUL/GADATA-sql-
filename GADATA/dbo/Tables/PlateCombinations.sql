CREATE TABLE [dbo].[PlateCombinations] (
    [ID]       INT IDENTITY (1, 1) NOT NULL,
    [Plate1ID] INT NULL,
    [Plate2ID] INT NULL,
    [Plate3ID] INT NULL,
    [Plate4ID] INT NULL,
    CONSTRAINT [PK_PlateCombinations] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_PlateCombinations_PlateType] FOREIGN KEY ([Plate1ID]) REFERENCES [dbo].[PlateType] ([ID]),
    CONSTRAINT [FK_PlateCombinations_PlateType1] FOREIGN KEY ([Plate2ID]) REFERENCES [dbo].[PlateType] ([ID]),
    CONSTRAINT [FK_PlateCombinations_PlateType2] FOREIGN KEY ([Plate3ID]) REFERENCES [dbo].[PlateType] ([ID]),
    CONSTRAINT [FK_PlateCombinations_PlateType3] FOREIGN KEY ([Plate4ID]) REFERENCES [dbo].[PlateType] ([ID])
);

