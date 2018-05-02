CREATE TABLE [NGAC].[L_error] (
    [_id]                INT           IDENTITY (1, 1) NOT NULL,
    [Number]             INT           NULL,
    [Title]              VARCHAR (MAX) NULL,
    [CategoryId]         INT           NULL,
    [l_description_id]   INT           NULL,
    [l_consequences_id]  INT           NULL,
    [l_causes_id]        INT           NULL,
    [l_actions_id]       INT           NULL,
    [l_type_id]          INT           NULL,
    [c_ClassificationId] INT           NULL,
    [c_SubgroupId]       INT           NULL,
    [c_RuleId]           INT           NULL,
    [CleanTitle]         VARCHAR (MAX) NULL,
    [ClassCalculated]    BIT           NULL,
    CONSTRAINT [PK_L_error] PRIMARY KEY CLUSTERED ([_id] ASC),
    CONSTRAINT [FK_L_error_c_Classification] FOREIGN KEY ([c_ClassificationId]) REFERENCES [Volvo].[c_Classification] ([id]),
    CONSTRAINT [FK_L_error_c_Subgroup] FOREIGN KEY ([c_SubgroupId]) REFERENCES [Volvo].[c_Subgroup] ([id]),
    CONSTRAINT [FK_L_error_L_actions] FOREIGN KEY ([l_actions_id]) REFERENCES [NGAC].[L_actions] ([id]),
    CONSTRAINT [FK_L_error_L_causes] FOREIGN KEY ([l_causes_id]) REFERENCES [NGAC].[L_causes] ([id]),
    CONSTRAINT [FK_L_error_L_consequences] FOREIGN KEY ([l_consequences_id]) REFERENCES [NGAC].[L_consequences] ([id]),
    CONSTRAINT [FK_L_error_L_description] FOREIGN KEY ([l_description_id]) REFERENCES [NGAC].[L_description] ([id]),
    CONSTRAINT [FK_L_error_L_type] FOREIGN KEY ([l_type_id]) REFERENCES [NGAC].[L_type] ([id])
);




GO



GO



GO


