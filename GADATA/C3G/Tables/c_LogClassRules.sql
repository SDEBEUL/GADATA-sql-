CREATE TABLE [C3G].[c_LogClassRules] (
    [id]                 INT           IDENTITY (1, 1) NOT NULL,
    [Err_start]          INT           NULL,
    [Err_end]            INT           NULL,
    [Err_text]           VARCHAR (255) NULL,
    [I_comment]          VARCHAR (255) NULL,
    [c_ClassificationId] INT           NULL,
    [c_SubgroupId]       INT           NULL,
    CONSTRAINT [PK_c_LogClassRules] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_c_LogClassRules_c_Classification] FOREIGN KEY ([c_ClassificationId]) REFERENCES [Volvo].[c_Classification] ([id]),
    CONSTRAINT [FK_c_LogClassRules_c_Subgroup1] FOREIGN KEY ([c_SubgroupId]) REFERENCES [Volvo].[c_Subgroup] ([id])
);



