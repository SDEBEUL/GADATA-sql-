CREATE TABLE [C4G].[L_error] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [error_number]   INT           NULL,
    [error_severity] INT           NULL,
    [error_text]     VARCHAR (255) NULL,
    [Appl_id]        INT           NULL,
    [Subgroup_id]    INT           NULL,
    CONSTRAINT [PK_L_alarm] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_L_error_c_Appl] FOREIGN KEY ([Appl_id]) REFERENCES [C4G].[c_Appl] ([id]),
    CONSTRAINT [FK_L_error_c_Subgroup] FOREIGN KEY ([Subgroup_id]) REFERENCES [C4G].[c_Subgroup] ([id])
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
CREATE TRIGGER [C4G].[C4G_L_error_Apply_appl_subgroups] ON [GADATA].[C4G].[L_error] AFTER INSERT 
AS
IF ((SELECT TRIGGER_NESTLEVEL()) < 4)
BEGIN
 EXEC GADATA.C4G.sp_UPDATE_abb_APPL_Subgroup
END