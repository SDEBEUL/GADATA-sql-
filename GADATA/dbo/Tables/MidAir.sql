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




GO
CREATE NONCLUSTERED INDEX [nci_midair2]
    ON [dbo].[MidAir]([SpotId] ASC)
    INCLUDE([DateTime], [ResisActual], [ResisRef]);


GO
CREATE NONCLUSTERED INDEX [nci_midair]
    ON [dbo].[MidAir]([SpotId] ASC)
    INCLUDE([DateTime], [ElectrodeNo]);

