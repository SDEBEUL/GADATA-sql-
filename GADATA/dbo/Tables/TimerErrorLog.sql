﻿CREATE TABLE [dbo].[TimerErrorLog] (
    [ID]       INT      IDENTITY (1, 1) NOT NULL,
    [DateTime] DATETIME NOT NULL,
    [TimerID]  INT      NOT NULL,
    [ErrorID]  INT      NOT NULL,
    CONSTRAINT [PK_TimerErrorLog] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_TimerErrorLog_Timer] FOREIGN KEY ([TimerID]) REFERENCES [dbo].[Timer] ([ID]),
    CONSTRAINT [FK_TimerErrorLog_TimerErrorText] FOREIGN KEY ([ErrorID]) REFERENCES [dbo].[TimerErrorText] ([ID])
);

