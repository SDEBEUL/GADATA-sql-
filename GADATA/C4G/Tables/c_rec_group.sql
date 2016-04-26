CREATE TABLE [C4G].[c_rec_group] (
    [id]                 INT           IDENTITY (1, 1) NOT NULL,
    [bit_id]             INT           NULL,
    [model_code]         INT           NULL,
    [_update]            INT           NULL,
    [rt_rec_group_table] VARCHAR (256) NULL,
    [rt_rec_data_table]  VARCHAR (256) NULL,
    [_group]             INT           NULL,
    [periodic_schedule]  INT           NULL,
    [min_time]           INT           NULL,
    [max_time]           INT           NULL,
    [comment]            VARCHAR (256) NULL,
    [keycode]            INT           NULL,
    CONSTRAINT [PK_c_rec_data] PRIMARY KEY CLUSTERED ([id] ASC)
);

