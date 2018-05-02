CREATE TABLE [NGAC].[XY_L_error] (
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
    CONSTRAINT [PK_XY_L_error] PRIMARY KEY CLUSTERED ([_id] ASC)
);

