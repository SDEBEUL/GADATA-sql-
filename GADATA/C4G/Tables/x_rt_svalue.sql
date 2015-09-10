CREATE TABLE [C4G].[x_rt_svalue] (
    [id]            INT            IDENTITY (1, 1) NOT NULL,
    [controller_id] INT            NULL,
    [_timestamp]    DATETIME       NULL,
    [svalue]        VARCHAR (2048) NULL,
    [variable_id]   INT            NULL,
    CONSTRAINT [PK_x_rt_svalue] PRIMARY KEY CLUSTERED ([id] ASC)
);

