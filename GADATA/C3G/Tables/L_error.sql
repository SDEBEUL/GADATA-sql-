CREATE TABLE [C3G].[L_error] (
    [id]                 INT           IDENTITY (1, 1) NOT NULL,
    [error_number]       INT           NULL,
    [error_severity]     INT           NULL,
    [error_text]         VARCHAR (255) NULL,
    [c_ClassificationId] INT           NULL,
    [c_SubgroupId]       INT           NULL,
    [c_RuleId]           INT           NULL,
    CONSTRAINT [PK_L_alarm] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_L_error_c_Classification] FOREIGN KEY ([c_ClassificationId]) REFERENCES [Volvo].[c_Classification] ([id]),
    CONSTRAINT [FK_L_error_c_Subgroup1] FOREIGN KEY ([c_SubgroupId]) REFERENCES [Volvo].[c_Subgroup] ([id])
);




GO
CREATE NONCLUSTERED INDEX [_dta_index_L_error_23_1908774453__K1_K3_K7_K8_2_4]
    ON [C3G].[L_error]([id] ASC, [error_severity] ASC, [c_ClassificationId] ASC, [c_SubgroupId] ASC)
    INCLUDE([error_number], [error_text]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_L_error_23_1908774453__K1_K7_K8_2_3_4]
    ON [C3G].[L_error]([id] ASC, [c_ClassificationId] ASC, [c_SubgroupId] ASC)
    INCLUDE([error_number], [error_severity], [error_text]);


GO
CREATE STATISTICS [_dta_stat_1908774453_3_7_1_8]
    ON [C3G].[L_error]([error_severity], [c_ClassificationId], [id], [c_SubgroupId]);


GO
CREATE STATISTICS [_dta_stat_1908774453_3_8_1]
    ON [C3G].[L_error]([error_severity], [c_SubgroupId], [id]);


GO
CREATE STATISTICS [_dta_stat_1908774453_2_3_1]
    ON [C3G].[L_error]([error_number], [error_severity], [id]);


GO
CREATE STATISTICS [_dta_stat_1908774453_8_1]
    ON [C3G].[L_error]([c_SubgroupId], [id]);


GO
CREATE STATISTICS [_dta_stat_1908774453_7_1_8]
    ON [C3G].[L_error]([c_ClassificationId], [id], [c_SubgroupId]);


GO
CREATE STATISTICS [_dta_stat_1908774453_8_7]
    ON [C3G].[L_error]([c_SubgroupId], [c_ClassificationId]);


GO
CREATE STATISTICS [_dta_stat_1908774453_2_1]
    ON [C3G].[L_error]([error_number], [id]);

