CREATE TABLE [dbo].[MidAir] (
    [ID]             INT      IDENTITY (1, 1) NOT NULL,
    [DateTime]       DATETIME NULL,
    [SpotId]         INT      NOT NULL,
    [ResisActual]    SMALLINT NULL,
    [ResisRef]       SMALLINT NULL,
    [ElectrodeNo]    TINYINT  NULL,
    [EnergyActual]   SMALLINT NULL,
    [WeldTimeActual] SMALLINT NULL,
    [Iactual2]       REAL     NULL,
    CONSTRAINT [PK_MidAir2] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_MidAir_Spot] FOREIGN KEY ([SpotId]) REFERENCES [dbo].[Spot] ([ID])
);

