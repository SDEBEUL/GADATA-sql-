CREATE TABLE [ABB].[L_error] (
    [id]                 INT           IDENTITY (1, 1) NOT NULL,
    [error_number]       INT           NULL,
    [error_severity]     INT           NULL,
    [error_text]         VARCHAR (255) NULL,
    [Appl_id]            INT           NULL,
    [Subgroup_id]        INT           NULL,
    [category_id]        INT           NULL,
    [c_ClassificationId] INT           NULL,
    [c_SubgroupId]       INT           NULL,
    [c_RuleId]           INT           NULL,
    CONSTRAINT [PK_L_alarm] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_L_error_c_Appl] FOREIGN KEY ([Appl_id]) REFERENCES [ABB].[c_Appl] ([id]),
    CONSTRAINT [FK_L_error_c_category] FOREIGN KEY ([category_id]) REFERENCES [ABB].[c_category] ([id]),
    CONSTRAINT [FK_L_error_c_Subgroup] FOREIGN KEY ([Subgroup_id]) REFERENCES [ABB].[c_Subgroup] ([id])
);
































































GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_Category]
    ON [ABB].[L_error]([id] ASC, [category_id] ASC, [Appl_id] ASC, [Subgroup_id] ASC, [error_number] ASC, [error_severity] ASC, [error_text] ASC);


GO
