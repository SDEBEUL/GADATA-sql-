CREATE TABLE [GLUE].[FaultInfo] (
    [ID]          INT           IDENTITY (1, 1) NOT NULL,
    [El_Ident]    VARCHAR (10)  NULL,
    [Priority]    VARCHAR (10)  NULL,
    [Description] VARCHAR (100) NULL,
    CONSTRAINT [PK_FaultInfo_1] PRIMARY KEY CLUSTERED ([ID] ASC)
);

