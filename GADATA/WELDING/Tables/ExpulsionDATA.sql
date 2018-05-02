CREATE TABLE [WELDING].[ExpulsionDATA] (
    [ID]              INT          IDENTITY (1, 1) NOT NULL,
    [SpotId]          INT          NULL,
    [DateTime]        DATETIME     NULL,
    [Wear]            SMALLINT     NULL,
    [Tipdresscounter] SMALLINT     NULL,
    [PartIdent]       VARCHAR (15) NULL,
    [WeldTime]        SMALLINT     NULL,
    [Energy]          SMALLINT     NULL,
    [UIP]             SMALLINT     NULL,
    [PSF]             SMALLINT     NULL,
    [ExpulsionTime]   SMALLINT     NULL,
    [Resistance]      SMALLINT     NULL,
    CONSTRAINT [FK_ExpulsionDATA_Spot] FOREIGN KEY ([SpotId]) REFERENCES [dbo].[Spot] ([ID])
);

