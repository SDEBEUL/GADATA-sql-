CREATE TABLE [dbo].[ExpulsionData] (
    [ID]              INT          IDENTITY (1, 1) NOT NULL,
    [SpotId]          INT          NULL,
    [DateTime]        DATETIME     NULL,
    [ShiftId]         INT          NULL,
    [Wear]            SMALLINT     NULL,
    [Tipdresscounter] SMALLINT     NULL,
    [PartIdent]       VARCHAR (15) NULL,
    [WeldTime]        SMALLINT     NULL,
    [Energy]          SMALLINT     NULL,
    [UIP]             SMALLINT     NULL,
    [PSF]             SMALLINT     NULL,
    [ExpulsionTime]   SMALLINT     NULL,
    [Resistance]      SMALLINT     NULL,
    CONSTRAINT [PK_ExpulsionData] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_ExpulsionData_L_timeline] FOREIGN KEY ([ShiftId]) REFERENCES [Volvo].[L_timeline] ([id]),
    CONSTRAINT [FK_ExpulsionData_Spot] FOREIGN KEY ([SpotId]) REFERENCES [dbo].[Spot] ([ID])
);

