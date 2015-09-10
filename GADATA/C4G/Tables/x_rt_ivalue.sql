CREATE TABLE [C4G].[x_rt_ivalue] (
    [id]            INT      IDENTITY (1, 1) NOT NULL,
    [controller_id] INT      NULL,
    [_timestamp]    DATETIME NULL,
    [ivalue]        INT      NULL,
    [variable_id]   INT      NULL,
    CONSTRAINT [PK_x_rt_ivalue] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_x_rt_ivalue_c_variable] FOREIGN KEY ([variable_id]) REFERENCES [C4G].[c_variable] ([id])
);

