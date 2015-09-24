CREATE TABLE [dbo].[rt_alarm] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [controller_id]   INT           NULL,
    [_timestamp]      DATETIME      NULL,
    [error_timestamp] DATETIME      NULL,
    [error_number]    INT           NULL,
    [error_count]     INT           NULL,
    [error_severity]  INT           NULL,
    [error_text]      VARCHAR (256) NULL,
    [error_is_alarm]  BIT           NULL,
    [error_id]        INT           NULL,
    CONSTRAINT [PK_rt_alarm] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_alarm_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [dbo].[c_controller] ([id])
);


















GO

GO

GO

GO

GO

GO

GO

GO


