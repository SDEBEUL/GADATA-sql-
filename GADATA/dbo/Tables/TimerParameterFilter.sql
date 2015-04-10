CREATE TABLE [dbo].[TimerParameterFilter] (
    [ID]   INT        IDENTITY (1, 1) NOT NULL,
    [Name] NCHAR (64) NOT NULL,
    CONSTRAINT [PK_TimerParameterFilter] PRIMARY KEY CLUSTERED ([ID] ASC)
);

