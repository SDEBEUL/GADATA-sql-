CREATE TABLE [dbo].[TimerParameters] (
    [ID]              INT  IDENTITY (1, 1) NOT NULL,
    [ParameterNameID] INT  NOT NULL,
    [TimerID]         INT  NOT NULL,
    [Value]           REAL NOT NULL,
    CONSTRAINT [PK_TimerParameters] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_TimerParameters_Timer] FOREIGN KEY ([TimerID]) REFERENCES [dbo].[Timer] ([ID]),
    CONSTRAINT [FK_TimerParameters_TimerParameterName] FOREIGN KEY ([ParameterNameID]) REFERENCES [dbo].[TimerParameterName] ([ID])
);

