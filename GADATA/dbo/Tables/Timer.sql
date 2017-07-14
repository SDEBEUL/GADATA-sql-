CREATE TABLE [dbo].[Timer] (
    [ID]    INT        IDENTITY (1, 1) NOT NULL,
    [Name]  NCHAR (15) NULL,
    [NptId] INT        NULL,
    [Robot] NCHAR (10) NULL,
    CONSTRAINT [PK_Timer] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_Timer_NPT] FOREIGN KEY ([NptId]) REFERENCES [dbo].[NPT] ([ID])
);

