CREATE TABLE [C4G].[x_rt_rvalue] (
    [id]            INT        IDENTITY (1, 1) NOT NULL,
    [controller_id] INT        NULL,
    [_timestamp]    DATETIME   NULL,
    [rvalue]        FLOAT (53) NULL,
    [variable_id]   INT        NULL,
    CONSTRAINT [PK_x_rt_rvalue] PRIMARY KEY CLUSTERED ([id] ASC)
);

