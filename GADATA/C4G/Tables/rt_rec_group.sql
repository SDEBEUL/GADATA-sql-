CREATE TABLE [C4G].[rt_rec_group] (
    [id]             INT      IDENTITY (1, 1) NOT NULL,
    [controller_id]  INT      NULL,
    [c_rec_group_id] INT      NULL,
    [_timestamp]     DATETIME NULL,
    [status]         INT      NULL,
    [model_code]     INT      NULL,
    [time_taken]     INT      NULL,
    CONSTRAINT [PK_rt_rec_group] PRIMARY KEY CLUSTERED ([id] ASC)
);

