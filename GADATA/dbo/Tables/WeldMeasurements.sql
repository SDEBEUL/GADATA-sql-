CREATE TABLE [dbo].[WeldMeasurements] (
    [ID]           INT      IDENTITY (1, 1) NOT NULL,
    [Date]         DATETIME NOT NULL,
    [Shift]        CHAR (1) NOT NULL,
    [SpotId]       INT      NOT NULL,
    [NbrSplash]    SMALLINT NULL,
    [NbrWeld]      SMALLINT NULL,
    [NbrReweld]    SMALLINT NULL,
    [AvgEnergy]    REAL     NULL,
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
    CONSTRAINT [PK_Weldmeasurements] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_WeldMeasurements_Spot] FOREIGN KEY ([SpotId]) REFERENCES [dbo].[Spot] ([ID])
);



