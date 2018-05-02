CREATE TABLE [dbo].[TimerDataChange] (
    [ID]          INT        IDENTITY (1, 1) NOT NULL,
    [TimerID]     INT        NOT NULL,
    [DateTime]    DATETIME   NOT NULL,
    [ParameterID] INT        NOT NULL,
    [OldValue]    NCHAR (50) NOT NULL,
    [NewValue]    NCHAR (50) NOT NULL,
    [UserID]      INT        NOT NULL,
    [Electrode]   SMALLINT   NULL,
    CONSTRAINT [PK_TimerDataChangetemp] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_TimerDataChange_Timer1] FOREIGN KEY ([TimerID]) REFERENCES [dbo].[Timer] ([ID]),
    CONSTRAINT [FK_TimerDataChange_TimerParameterName1] FOREIGN KEY ([ParameterID]) REFERENCES [dbo].[TimerParameterName] ([ID]),
    CONSTRAINT [FK_TimerDataChange_Users1] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([ID])
);



