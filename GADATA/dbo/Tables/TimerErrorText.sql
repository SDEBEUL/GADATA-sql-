CREATE TABLE [dbo].[TimerErrorText] (
    [ID]        INT         IDENTITY (1, 1) NOT NULL,
    [ErrorText] NCHAR (255) NOT NULL,
    CONSTRAINT [PK_TimerErrorText] PRIMARY KEY CLUSTERED ([ID] ASC)
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_TimerErrorText]
    ON [dbo].[TimerErrorText]([ID] ASC, [ErrorText] ASC);

