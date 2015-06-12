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

CREATE TRIGGER [dbo].Trig_rt_alarm ON [GADATA].[dbo].rt_alarm AFTER INSERT 
AS
IF ((SELECT TRIGGER_NESTLEVEL()) < 2)
BEGIN
 exec [volvo].[spmonitor]
END
GO
DISABLE TRIGGER [dbo].[Trig_rt_alarm]
    ON [dbo].[rt_alarm];

