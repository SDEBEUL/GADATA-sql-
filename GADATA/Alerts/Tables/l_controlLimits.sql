CREATE TABLE [Alerts].[l_controlLimits] (
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [c_trigger_id]  INT           NOT NULL,
    [isdead]        BIT           NOT NULL,
    [Createuser]    INT           NOT NULL,
    [CreateDate]    DATETIME      NOT NULL,
    [ChangeUser]    INT           NOT NULL,
    [ChangeDate]    DATETIME      NULL,
    [UpperLimit]    FLOAT (53)    NULL,
    [LowerLimit]    FLOAT (53)    NULL,
    [Comment]       VARCHAR (MAX) NULL,
    [alarmobject]   VARCHAR (MAX) NOT NULL,
    [l_variants_id] INT           NULL,
    CONSTRAINT [PK_l_controlLimits] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_l_controlLimits_c_triggers] FOREIGN KEY ([c_trigger_id]) REFERENCES [Alerts].[c_triggers] ([id]),
    CONSTRAINT [FK_l_controlLimits_L_users] FOREIGN KEY ([Createuser]) REFERENCES [Volvo].[L_users] ([id]),
    CONSTRAINT [FK_l_controlLimits_L_users1] FOREIGN KEY ([ChangeUser]) REFERENCES [Volvo].[L_users] ([id]),
    CONSTRAINT [FK_l_controlLimits_l_variants] FOREIGN KEY ([l_variants_id]) REFERENCES [Alerts].[l_variants] ([id])
);

