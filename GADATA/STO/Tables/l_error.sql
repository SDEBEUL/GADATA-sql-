CREATE TABLE [STO].[l_error] (
    [id]                 INT           IDENTITY (1, 1) NOT NULL,
    [SUBOBJECT]          VARCHAR (50)  NULL,
    [ALARMSEVERITY]      CHAR (1)      NULL,
    [ALARMCOMMENT]       VARCHAR (MAX) NULL,
    [c_ClassificationID] INT           NULL,
    [c_SubgroupId]       INT           NULL,
    [c_RuleID]           INT           NULL,
    CONSTRAINT [PK_l_error_1] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_l_error_c_Classification] FOREIGN KEY ([c_ClassificationID]) REFERENCES [Volvo].[c_Classification] ([id]),
    CONSTRAINT [FK_l_error_c_Subgroup] FOREIGN KEY ([c_SubgroupId]) REFERENCES [Volvo].[c_Subgroup] ([id])
);

