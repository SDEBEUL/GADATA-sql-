CREATE TABLE [dbo].[TimerDataChange] (
    [ID]          INT      IDENTITY (1, 1) NOT NULL,
    [TimerID]     INT      NOT NULL,
    [DateTime]    DATETIME NOT NULL,
    [ParameterID] INT      NOT NULL,
    [OldValue]    REAL     NOT NULL,
    [NewValue]    REAL     NOT NULL,
    [UserID]      INT      NOT NULL,
    [Electrode]   SMALLINT NULL,
    CONSTRAINT [PK_TimerDataChange] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_TimerDataChange_Timer] FOREIGN KEY ([TimerID]) REFERENCES [dbo].[Timer] ([ID]),
    CONSTRAINT [FK_TimerDataChange_TimerParameterName] FOREIGN KEY ([ParameterID]) REFERENCES [dbo].[TimerParameterName] ([ID]),
    CONSTRAINT [FK_TimerDataChange_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([ID])
);

