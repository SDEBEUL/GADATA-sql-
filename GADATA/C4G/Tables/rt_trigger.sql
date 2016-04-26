CREATE TABLE [C4G].[rt_trigger] (
    [id]            INT      IDENTITY (1, 1) NOT NULL,
    [controller_id] INT      NULL,
    [trigger_id]    INT      NULL,
    [_timestamp]    DATETIME NULL,
    [source]        INT      NULL,
    [assoc_id]      INT      NULL,
    CONSTRAINT [PK_rt_trigger] PRIMARY KEY CLUSTERED ([id] ASC)
);

