CREATE TABLE [LAUNCH].[TearDownTest] (
    [ID]                 INT        IDENTITY (1, 1) NOT NULL,
    [Date]               DATE       NOT NULL,
    [SpotID]             INT        NOT NULL,
    [TearDownStatus]     NCHAR (30) NULL,
    [TearDownNugget]     REAL       NULL,
    [TearDownEvaluation] NCHAR (30) NULL,
    [NuggetDemand]       REAL       NULL,
    CONSTRAINT [PK_TearDownTest] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_TearDownTest_Spot] FOREIGN KEY ([SpotID]) REFERENCES [dbo].[Spot] ([ID])
);

