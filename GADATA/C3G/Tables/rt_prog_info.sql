CREATE TABLE [C3G].[rt_prog_info] (
    [id]            INT          IDENTITY (1, 1) NOT NULL,
    [controller_id] INT          NULL,
    [_timestamp]    DATETIME     NULL,
    [program]       VARCHAR (32) NULL,
    [attributes]    INT          NULL,
    [code_size]     INT          NULL,
    [code_time]     INT          NULL,
    [var_time]      INT          NULL,
    CONSTRAINT [PK_rt_prog_info] PRIMARY KEY CLUSTERED ([id] ASC)
);

