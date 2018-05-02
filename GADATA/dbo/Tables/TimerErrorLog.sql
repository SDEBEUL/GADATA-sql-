CREATE TABLE [dbo].[TimerErrorLog] (
    [ID]       INT      IDENTITY (1, 1) NOT NULL,
    [DateTime] DATETIME NOT NULL,
    [TimerID]  INT      NOT NULL,
    [ErrorID]  INT      NOT NULL,
    [Error2ID] INT      NULL,
    CONSTRAINT [PK_TimerErrorLog] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_TimerErrorLog_Timer] FOREIGN KEY ([TimerID]) REFERENCES [dbo].[Timer] ([ID]),
    CONSTRAINT [FK_TimerErrorLog_TimerErrorText] FOREIGN KEY ([ErrorID]) REFERENCES [dbo].[TimerErrorText] ([ID])
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_TimerErrorLog]
    ON [dbo].[TimerErrorLog]([TimerID] ASC, [ErrorID] ASC, [ID] ASC);

