CREATE TABLE [ABB].[c_LogClassRules] (
    [id]                 INT           IDENTITY (1, 1) NOT NULL,
    [Appl_id]            INT           NULL,
    [Subgroup_id]        INT           NULL,
    [Err_start]          INT           NULL,
    [Err_end]            INT           NULL,
    [Err_text]           VARCHAR (255) NULL,
    [F_error_text]       BIT           CONSTRAINT [DF_c_LogClassRules_F_error_text] DEFAULT ((1)) NULL,
    [F_cause_text]       BIT           CONSTRAINT [DF_c_LogClassRules_F_cause_text] DEFAULT ((0)) NULL,
    [F_remedy_text]      BIT           CONSTRAINT [DF_c_LogClassRules_F_remedy_text] DEFAULT ((0)) NULL,
    [I_comment]          VARCHAR (255) NULL,
    [c_ClassificationId] INT           NULL,
    [c_SubgroupId]       INT           NULL,
    CONSTRAINT [PK_c_LogClassRules] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_c_LogClassRules_c_Appl] FOREIGN KEY ([Appl_id]) REFERENCES [ABB].[c_Appl] ([id]),
    CONSTRAINT [FK_c_LogClassRules_c_Subgroup] FOREIGN KEY ([Subgroup_id]) REFERENCES [ABB].[c_Subgroup] ([id])
);






GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'if true the Err_text field value will try to match in L_error.text ', @level0type = N'SCHEMA', @level0name = N'ABB', @level1type = N'TABLE', @level1name = N'c_LogClassRules', @level2type = N'COLUMN', @level2name = N'F_error_text';

