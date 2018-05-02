CREATE TABLE [WELDING].[Qcontrol] (
    [ID]                    INT      IDENTITY (1, 1) NOT NULL,
    [SpotID]                INT      NULL,
    [TimerID]               INT      NULL,
    [uit adaptief]          BIT      NULL,
    [ColdWeldReport]        BIT      NULL,
    [ReduceWeldingTime]     BIT      NULL,
    [ReduceCurrent]         BIT      NULL,
    [SBCUAlert]             BIT      NULL,
    [EnergyDrop]            BIT      NULL,
    [LastInspectionDate]    DATETIME NULL,
    [InspectionDate]        DATETIME NULL,
    [WeldCounterFromLastUL] INT      NULL,
    CONSTRAINT [PK_Qcontrol] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_Qcontrol_Spot1] FOREIGN KEY ([SpotID]) REFERENCES [dbo].[Spot] ([ID])
);

