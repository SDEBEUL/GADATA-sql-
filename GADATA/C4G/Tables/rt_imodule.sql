CREATE TABLE [C4G].[rt_imodule] (
    [id]              INT            IDENTITY (1, 1) NOT NULL,
    [controller_id]   INT            NULL,
    [c_string_map_id] INT            NULL,
    [_timestamp]      DATETIME       NULL,
    [value]           VARCHAR (2048) NULL,
    [idx1]            INT            NULL,
    [idx2]            INT            NULL,
    CONSTRAINT [PK_rt_imodule] PRIMARY KEY CLUSTERED ([id] ASC)
);

