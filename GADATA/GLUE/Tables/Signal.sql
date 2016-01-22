CREATE TABLE [GLUE].[Signal] (
    [ID]         INT           IDENTITY (1, 1) NOT NULL,
    [SignalName] VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Signal] PRIMARY KEY CLUSTERED ([ID] ASC)
);

