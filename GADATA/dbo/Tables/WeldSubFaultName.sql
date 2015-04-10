CREATE TABLE [dbo].[WeldSubFaultName] (
    [ID]               INT         IDENTITY (1, 1) NOT NULL,
    [WeldSubFaultName] NCHAR (100) NOT NULL,
    CONSTRAINT [PK_WeldSubFaultName] PRIMARY KEY CLUSTERED ([ID] ASC)
);

