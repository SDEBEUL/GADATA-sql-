CREATE TABLE [EqUi].[l_dummyLogClassResult] (
    [id]                  INT           NOT NULL,
    [code]                INT           NULL,
    [text]                VARCHAR (MAX) NULL,
    [c_logcClassRules_id] INT           NULL,
    [c_Classification_id] INT           NULL,
    [c_Subgroup_id]       INT           NULL,
    CONSTRAINT [PK_l_dummyLogClassResult] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_l_dummyLogClassResult_c_Classification] FOREIGN KEY ([c_Classification_id]) REFERENCES [Volvo].[c_Classification] ([id]),
    CONSTRAINT [FK_l_dummyLogClassResult_c_Subgroup] FOREIGN KEY ([c_Subgroup_id]) REFERENCES [Volvo].[c_Subgroup] ([id])
);

