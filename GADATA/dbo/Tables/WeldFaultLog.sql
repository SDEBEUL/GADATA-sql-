CREATE TABLE [dbo].[WeldFaultLog] (
    [ID]                INT           IDENTITY (1, 1) NOT NULL,
    [DateTime]          DATETIME      NOT NULL,
    [SpotID]            INT           NOT NULL,
    [WeldFaultID]       INT           NOT NULL,
    [WeldSubFaultID]    INT           NOT NULL,
    [Wear]              SMALLINT      NOT NULL,
    [Filter]            BIT           CONSTRAINT [DF_WeldFaultLog_Filter] DEFAULT ((1)) NOT NULL,
    [WeldMasterComment] VARCHAR (250) NULL,
    CONSTRAINT [PK_WeldFaultLog] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_WeldFaultLog_Spot] FOREIGN KEY ([SpotID]) REFERENCES [dbo].[Spot] ([ID]),
    CONSTRAINT [FK_WeldFaultLog_WeldFaultName] FOREIGN KEY ([WeldFaultID]) REFERENCES [dbo].[WeldFaultName] ([ID]),
    CONSTRAINT [FK_WeldFaultLog_WeldSubFaultName] FOREIGN KEY ([WeldSubFaultID]) REFERENCES [dbo].[WeldSubFaultName] ([ID])
);

