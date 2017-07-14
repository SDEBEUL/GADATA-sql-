CREATE TABLE [dbo].[WeldMeasurements] (
    [ID]           INT      IDENTITY (1, 1) NOT NULL,
    [Date]         DATE     NOT NULL,
    [Shift]        CHAR (1) NOT NULL,
    [SpotId]       INT      NOT NULL,
    [NbrSplash]    SMALLINT CONSTRAINT [DF_WeldMeasurements_NbrSplash] DEFAULT ((0)) NULL,
    [NbrWeld]      SMALLINT CONSTRAINT [DF_WeldMeasurements_NbrWeld] DEFAULT ((0)) NULL,
    [NbrReweld]    SMALLINT CONSTRAINT [DF_WeldMeasurements_NbrReweld] DEFAULT ((0)) NULL,
    [AvgEnergy]    REAL     CONSTRAINT [DF_WeldMeasurements_AvgEnergy] DEFAULT ((0)) NULL,
    [StdEnergy]    REAL     NULL,
    [AvgPSF]       REAL     NULL,
    [StdPSF]       REAL     NULL,
    [AvgOhm]       REAL     NULL,
    [StdOhm]       REAL     NULL,
    [AvgUIP]       REAL     NULL,
    [StdUIP]       REAL     NULL,
    [AvgWeldTIme]  REAL     NULL,
    [StdWeldTIme]  REAL     NULL,
    [L_TimelineID] INT      NULL,
    CONSTRAINT [PK_Splash] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_WeldMeasurements_Spot] FOREIGN KEY ([SpotId]) REFERENCES [dbo].[Spot] ([ID])
);

