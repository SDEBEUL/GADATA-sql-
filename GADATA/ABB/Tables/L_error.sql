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
    CONSTRAINT [FK_L_error_c_Appl1] FOREIGN KEY ([Appl_id]) REFERENCES [ABB].[c_Appl] ([id]),
    CONSTRAINT [FK_L_error_c_category] FOREIGN KEY ([category_id]) REFERENCES [ABB].[c_category] ([id]),
    CONSTRAINT [FK_L_error_c_Subgroup1] FOREIGN KEY ([Subgroup_id]) REFERENCES [ABB].[c_Subgroup] ([id])
);




GO
CREATE NONCLUSTERED INDEX [_dta_index_L_error_23_1469248289__K8_K1_K9_K10_K2_K3_4]
    ON [ABB].[L_error]([category_id] ASC, [id] ASC, [c_ClassificationId] ASC, [c_SubgroupId] ASC, [error_number] ASC, [error_severity] ASC)
    INCLUDE([error_text]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_L_error_23_1469248289__K1_K9_K10_K8_K2_K3_4]
    ON [ABB].[L_error]([id] ASC, [c_ClassificationId] ASC, [c_SubgroupId] ASC, [category_id] ASC, [error_number] ASC, [error_severity] ASC)
    INCLUDE([error_text]);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_Category]
    ON [ABB].[L_error]([id] ASC, [category_id] ASC, [Appl_id] ASC, [Subgroup_id] ASC, [error_number] ASC, [error_severity] ASC, [error_text] ASC);


GO
CREATE STATISTICS [_dta_stat_1469248289_9_8_10]
    ON [ABB].[L_error]([c_ClassificationId], [category_id], [c_SubgroupId]);


GO
CREATE STATISTICS [_dta_stat_1469248289_8_9_1_10_2_3]
    ON [ABB].[L_error]([category_id], [c_ClassificationId], [id], [c_SubgroupId], [error_number], [error_severity]);


GO
CREATE STATISTICS [_dta_stat_1469248289_2_3_8_1]
    ON [ABB].[L_error]([error_number], [error_severity], [category_id], [id]);


GO
CREATE STATISTICS [_dta_stat_1469248289_10_8_1]
    ON [ABB].[L_error]([c_SubgroupId], [category_id], [id]);


GO
CREATE STATISTICS [_dta_stat_1469248289_8_2]
    ON [ABB].[L_error]([category_id], [error_number]);

