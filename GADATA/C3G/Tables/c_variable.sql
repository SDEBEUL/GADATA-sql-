CREATE TABLE [C3G].[c_variable] (
    [id]               INT           IDENTITY (1, 1) NOT NULL,
    [bit_id]           INT           NULL,
    [name]             VARCHAR (256) NULL,
    [update_rate]      INT           NULL,
    [in_sys_state]     INT           NULL,
    [_update]          INT           NULL,
    [rt_table]         VARCHAR (256) NULL,
    [rt_field]         VARCHAR (256) NULL,
    [svr_vs_clnt]      INT           NULL,
    [mon_attr]         INT           NULL,
    [_operator]        INT           NULL,
    [_group]           INT           NULL,
    [trigger_cond]     INT           NULL,
    [trigger_action]   INT           NULL,
    [trigger_adata]    INT           NULL,
    [trigger_mask]     INT           NULL,
    [trigger_value]    INT           NULL,
    [trigger_desc]     VARCHAR (256) NULL,
    [usage]            INT           NULL,
    [rt_flags]         INT           NULL,
    [description]      VARCHAR (256) NULL,
    [keycode]          INT           NULL,
    [trigger_interval] INT           NULL,
    CONSTRAINT [PK_c_variable] PRIMARY KEY CLUSTERED ([id] ASC)
);



