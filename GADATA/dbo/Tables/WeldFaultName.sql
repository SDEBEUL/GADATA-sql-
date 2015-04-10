CREATE TABLE [dbo].[WeldFaultName] (
    [ID]            INT         IDENTITY (1, 1) NOT NULL,
    [WeldFaultName] NCHAR (100) NOT NULL,
    CONSTRAINT [PK_WeldFaultName] PRIMARY KEY CLUSTERED ([ID] ASC)
);

