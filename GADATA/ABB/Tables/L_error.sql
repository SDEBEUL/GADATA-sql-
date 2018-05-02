CREATE TABLE [ABB].[L_error] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [error_number]   INT           NULL,
    [error_severity] INT           NULL,
    [error_text]     VARCHAR (255) NULL,
    [Appl_id]        INT           NULL,
    [Subgroup_id]    INT           NULL,
    [category_id]    INT           NULL,
    CONSTRAINT [PK_L_alarm] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_L_error_c_category] FOREIGN KEY ([category_id]) REFERENCES [ABB].[c_category] ([id])
);






GO



GO



GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_Category]
    ON [ABB].[L_error]([id] ASC, [category_id] ASC, [Appl_id] ASC, [Subgroup_id] ASC, [error_number] ASC, [error_severity] ASC, [error_text] ASC);


GO



GO



GO
CREATE STATISTICS [_dta_stat_1469248289_2_3_8_1]
    ON [ABB].[L_error]([error_number], [error_severity], [category_id], [id]);


GO



GO
CREATE STATISTICS [_dta_stat_1469248289_8_2]
    ON [ABB].[L_error]([category_id], [error_number]);

