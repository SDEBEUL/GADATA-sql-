CREATE TABLE [dbo].[TipWear] (
    [ID]       INT        IDENTITY (1, 1) NOT NULL,
    [TimerID]  INT        NOT NULL,
    [DateTime] DATETIME   NOT NULL,
    [wear]     FLOAT (53) NULL,
    CONSTRAINT [PK_TipWear] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_TipWear_Timer] FOREIGN KEY ([TimerID]) REFERENCES [dbo].[Timer] ([ID])
);

