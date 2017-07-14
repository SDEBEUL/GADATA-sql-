CREATE TABLE [C4G].[rt_Uvalue] (
    [id]            INT            IDENTITY (1, 1) NOT NULL,
    [controller_id] INT            NULL,
    [_timestamp]    DATETIME       NULL,
    [value]         VARCHAR (2048) NULL,
    [variable_id]   INT            NULL,
    CONSTRAINT [PK_rt_Uvalue] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_Uvalue_c_controller1] FOREIGN KEY ([controller_id]) REFERENCES [C4G].[c_controller] ([id]),
    CONSTRAINT [FK_rt_Uvalue_c_variable] FOREIGN KEY ([variable_id]) REFERENCES [C4G].[c_variable] ([id])
);

