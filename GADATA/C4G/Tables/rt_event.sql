CREATE TABLE [C4G].[rt_event] (
    [id]            INT      IDENTITY (1, 1) NOT NULL,
    [controller_id] INT      NULL,
    [event_id]      INT      NULL,
    [_timestamp]    DATETIME NULL,
    [event_number]  INT      NULL,
    [model]         INT      NULL,
    CONSTRAINT [PK_rt_event] PRIMARY KEY CLUSTERED ([id] ASC)
);

