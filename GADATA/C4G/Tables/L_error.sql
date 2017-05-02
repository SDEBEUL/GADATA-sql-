CREATE TABLE [C4G].[L_error] (
    [id]                 INT           IDENTITY (1, 1) NOT NULL,
    [error_number]       INT           NULL,
    [error_severity]     INT           NULL,
    [error_text]         VARCHAR (255) NULL,
    [Appl_id]            INT           NULL,
    [Subgroup_id]        INT           NULL,
    [c_ClassificationId] INT           NULL,
    [c_SubgroupId]       INT           NULL,
    [c_RuleId]           INT           NULL,
    CONSTRAINT [PK_L_alarm] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_L_error_c_Appl] FOREIGN KEY ([Appl_id]) REFERENCES [C4G].[c_Appl] ([id]),
    CONSTRAINT [FK_L_error_c_Classification] FOREIGN KEY ([c_ClassificationId]) REFERENCES [Volvo].[c_Classification] ([id]),
    CONSTRAINT [FK_L_error_c_Subgroup] FOREIGN KEY ([Subgroup_id]) REFERENCES [C4G].[c_Subgroup] ([id]),
    CONSTRAINT [FK_L_error_c_Subgroup1] FOREIGN KEY ([c_SubgroupId]) REFERENCES [Volvo].[c_Subgroup] ([id])
);
























































GO
CREATE NONCLUSTERED INDEX [idx_error_id]
    ON [C4G].[L_error]([id] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_C4G_L_error_ID2]
    ON [C4G].[L_error]([id] ASC, [Appl_id] ASC, [Subgroup_id] ASC, [error_number] ASC, [error_severity] ASC, [error_text] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_C4G_L_error_ID]
    ON [C4G].[L_error]([id] ASC, [error_number] ASC, [error_severity] ASC, [Appl_id] ASC, [Subgroup_id] ASC);


GO
CREATE NONCLUSTERED INDEX [nci_Le_2]
    ON [C4G].[L_error]([error_number] ASC, [error_severity] ASC, [error_text] ASC)
    INCLUDE([id]);


GO
CREATE NONCLUSTERED INDEX [nci_Le_1]
    ON [C4G].[L_error]([error_number] ASC, [error_severity] ASC, [error_text] ASC)
    INCLUDE([id]);


GO
CREATE STATISTICS [_dta_stat_212963885_9_8_4_2]
    ON [C4G].[L_error]([c_SubgroupId], [c_ClassificationId], [error_text], [error_number]);


GO
CREATE STATISTICS [_dta_stat_212963885_4_2_3_9_8]
    ON [C4G].[L_error]([error_text], [error_number], [error_severity], [c_SubgroupId], [c_ClassificationId]);


GO
CREATE STATISTICS [_dta_stat_212963885_1_9_8_4_2_3]
    ON [C4G].[L_error]([id], [c_SubgroupId], [c_ClassificationId], [error_text], [error_number], [error_severity]);

