CREATE TABLE [EqUi].[c_LogClassRules] (
    [id]                  INT           IDENTITY (1, 1) NOT NULL,
    [c_logClassSystem_id] INT           NOT NULL,
    [coderangeStart]      INT           NULL,
    [coderangeEnd]        INT           NULL,
    [textSearch]          VARCHAR (255) NULL,
    [I_comment]           VARCHAR (255) NULL,
    [c_ClassificationId]  INT           NOT NULL,
    [c_SubgroupId]        INT           NOT NULL,
    CONSTRAINT [PK_c_LogClassRules] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_c_LogClassRules_c_Classification] FOREIGN KEY ([c_ClassificationId]) REFERENCES [Volvo].[c_Classification] ([id]),
    CONSTRAINT [FK_c_LogClassRules_c_logClassSystem] FOREIGN KEY ([c_logClassSystem_id]) REFERENCES [EqUi].[c_logClassSystem] ([id]),
    CONSTRAINT [FK_c_LogClassRules_c_Subgroup] FOREIGN KEY ([c_SubgroupId]) REFERENCES [Volvo].[c_Subgroup] ([id])
);

