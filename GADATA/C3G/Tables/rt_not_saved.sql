CREATE TABLE [C3G].[rt_not_saved] (
    [id]            INT          IDENTITY (1, 1) NOT NULL,
    [controller_id] INT          NULL,
    [_timestamp]    DATETIME     NULL,
    [program]       VARCHAR (32) NULL,
    [modified]      BIT          NULL,
    CONSTRAINT [PK_rt_not_saved] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_not_saved_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [C3G].[c_controller] ([id])
);

