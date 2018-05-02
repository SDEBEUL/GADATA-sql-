CREATE TABLE [NGAC].[c_pjv_action] (
    [id]               INT           IDENTITY (1, 1) NOT NULL,
    [enable_bit]       INT           NULL,
    [_group]           INT           NULL,
    [ordinal]          INT           NULL,
    [action_enum]      INT           NULL,
    [action_data_1]    VARCHAR (250) NULL,
    [action_data_2]    VARCHAR (250) NULL,
    [action_data_3]    VARCHAR (250) NULL,
    [ignore_mask]      INT           NULL,
    [min_interval]     INT           NULL,
    [delayed_count]    INT           NULL,
    [delayed_interval] INT           NULL,
    [poll_rate]        INT           NULL,
    [flags]            INT           NULL,
    [comment]          VARCHAR (250) NULL,
    CONSTRAINT [PK_c_pjv] PRIMARY KEY CLUSTERED ([id] ASC)
);

