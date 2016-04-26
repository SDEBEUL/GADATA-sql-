CREATE TABLE [C3G].[rt_alarm] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [controller_id]   INT           NULL,
    [_timestamp]      DATETIME      NULL,
    [error_timestamp] DATETIME      NULL,
    [error_number]    INT           NULL,
    [error_count]     INT           NULL,
    [error_severity]  INT           NULL,
    [error_text]      VARCHAR (256) NULL,
    [error_is_alarm]  BIT           NULL,
    CONSTRAINT [PK_rt_alarm] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_alarm_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [C3G].[c_controller2] ([id])
);






























GO

GO

GO

GO

GO

GO

GO

GO

GO

GO

GO

GO

GO

GO


