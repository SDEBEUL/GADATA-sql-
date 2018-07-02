CREATE TABLE [EqUi].[c_logClassSystem] (
    [id]               INT           IDENTITY (1, 1) NOT NULL,
    [c_datasource_id]  INT           NOT NULL,
    [Name]             VARCHAR (50)  NOT NULL,
    [Description]      VARCHAR (MAX) NULL,
    [SelectStatement]  VARCHAR (MAX) NOT NULL,
    [UpdateStatement]  VARCHAR (MAX) NULL,
    [RunRuleStatement] VARCHAR (MAX) NULL,
    CONSTRAINT [PK_c_logClassSystem] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_c_logClassSystem_c_datasource] FOREIGN KEY ([c_datasource_id]) REFERENCES [EqUi].[c_datasource] ([Id])
);

