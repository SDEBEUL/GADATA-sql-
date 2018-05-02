CREATE TABLE [C4G].[rt_production] (
    [id]            INT      IDENTITY (1, 1) NOT NULL,
    [controller_id] INT      NULL,
    [_timestamp]    DATETIME NULL,
    [model]         INT      NULL,
    [cycle_time]    INT      NULL,
    [timer_index]   INT      NULL,
    CONSTRAINT [PK_rt_production] PRIMARY KEY CLUSTERED ([id] ASC)
);



