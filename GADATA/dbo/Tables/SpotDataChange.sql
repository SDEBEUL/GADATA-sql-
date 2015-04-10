CREATE TABLE [dbo].[SpotDataChange] (
    [ID]          INT      IDENTITY (1, 1) NOT NULL,
    [SpotID]      INT      NOT NULL,
    [DateTime]    DATETIME NOT NULL,
    [ParameterID] INT      NOT NULL,
    [OldValue]    REAL     NOT NULL,
    [NewValue]    REAL     NOT NULL,
    [UserID]      INT      NOT NULL,
    CONSTRAINT [PK_SpotDataChange] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_SpotDataChange_Spot] FOREIGN KEY ([SpotID]) REFERENCES [dbo].[Spot] ([ID]),
    CONSTRAINT [FK_SpotDataChange_TimerParameterName] FOREIGN KEY ([ParameterID]) REFERENCES [dbo].[TimerParameterName] ([ID]),
    CONSTRAINT [FK_SpotDataChange_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([ID])
);

