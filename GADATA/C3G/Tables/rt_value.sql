CREATE TABLE [C3G].[rt_value] (
    [id]            INT            IDENTITY (1, 1) NOT NULL,
    [controller_id] INT            NULL,
    [_timestamp]    DATETIME       NULL,
    [value]         VARCHAR (2048) NULL,
    [variable_id]   INT            NULL,
    [idx1]          INT            NULL,
    [idx2]          INT            NULL,
    [datatype]      INT            NULL,
    CONSTRAINT [PK_rt_value] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_value_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [C3G].[c_controller] ([id]),
    CONSTRAINT [FK_rt_value_c_variable] FOREIGN KEY ([variable_id]) REFERENCES [C3G].[c_variable] ([id])
);

