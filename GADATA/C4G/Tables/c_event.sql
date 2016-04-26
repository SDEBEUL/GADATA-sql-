CREATE TABLE [C4G].[c_event] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [bit_id]         INT           NULL,
    [number]         INT           NULL,
    [rt_table]       VARCHAR (256) NULL,
    [rt_field]       VARCHAR (256) NULL,
    [rt_flags]       INT           NULL,
    [mon_attr]       INT           NULL,
    [_group]         INT           NULL,
    [trigger_cond]   INT           NULL,
    [trigger_action] INT           NULL,
    [trigger_adata]  INT           NULL,
    [trigger_mask]   INT           NULL,
    [trigger_value]  INT           NULL,
    [description]    VARCHAR (256) NULL,
    [keycode]        INT           NULL,
    CONSTRAINT [PK_c_event] PRIMARY KEY CLUSTERED ([id] ASC)
);

