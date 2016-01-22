CREATE TABLE [GLUE].[OperatorActionInfo] (
    [ID]          INT           IDENTITY (1, 1) NOT NULL,
    [Description] VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_OperatorActionInfo] PRIMARY KEY CLUSTERED ([ID] ASC)
);

