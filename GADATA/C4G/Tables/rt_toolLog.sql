CREATE TABLE [C4G].[rt_toolLog] (
    [id]            INT            IDENTITY (1, 1) NOT NULL,
    [controller_id] INT            NULL,
    [_timestamp]    DATETIME       NULL,
    [value]         VARCHAR (2048) NULL,
    [variable_id]   INT            NULL,
    CONSTRAINT [PK_rt_toolLog] PRIMARY KEY CLUSTERED ([id] ASC)
);

