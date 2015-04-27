CREATE TABLE [ABB].[c_LogClassRules] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [Appl_id]     INT           NULL,
    [Subgroup_id] INT           NULL,
    [Err_start]   INT           NULL,
    [Err_end]     INT           NULL,
    [Err_text]    VARCHAR (255) NULL,
    CONSTRAINT [PK_c_LogClassRules] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_c_LogClassRules_c_Appl] FOREIGN KEY ([Appl_id]) REFERENCES [ABB].[c_Appl] ([id]),
    CONSTRAINT [FK_c_LogClassRules_c_Subgroup] FOREIGN KEY ([Subgroup_id]) REFERENCES [ABB].[c_Subgroup] ([id])
);

