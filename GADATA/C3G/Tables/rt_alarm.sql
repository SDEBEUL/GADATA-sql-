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
    CONSTRAINT [FK_rt_alarm_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [C3G].[c_controller] ([id])
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


CREATE TRIGGER [c3g].[Trig_rt_alarm] ON [GADATA].[c3g].[rt_alarm] AFTER INSERT 
AS
IF ((SELECT TRIGGER_NESTLEVEL()) < 2)
BEGIN
 exec GADATA.C3G.sp_update_L
END
GO
DISABLE TRIGGER [C3G].[Trig_rt_alarm]
    ON [C3G].[rt_alarm];

