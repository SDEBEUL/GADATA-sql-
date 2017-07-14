CREATE TABLE [dbo].[PlateType] (
    [ID]         INT  IDENTITY (1, 1) NOT NULL,
    [Thickness]  REAL NOT NULL,
    [MaterialID] INT  NOT NULL,
    [CoatingID]  INT  NOT NULL,
    CONSTRAINT [PK_PlateType] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_PlateType_PlateCoating] FOREIGN KEY ([CoatingID]) REFERENCES [dbo].[PlateCoating] ([ID]),
    CONSTRAINT [FK_PlateType_PlateMaterial] FOREIGN KEY ([MaterialID]) REFERENCES [dbo].[PlateMaterial] ([ID])
);

