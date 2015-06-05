CREATE TABLE [C4G].[h_alarm] (
    [id]             INT      IDENTITY (1, 1) NOT NULL,
    [controller_id]  INT      NULL,
    [_timestamp]     DATETIME NULL,
    [c_timestamp]    DATETIME NULL,
    [error_is_alarm] BIT      NULL,
    [error_id]       INT      NULL,
    [is_realtime]    BIT      NULL,
    [restart_id]     INT      NULL,
    CONSTRAINT [PK_h_alarm] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_h_alarm_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [dbo].[c_controller] ([id]),
    CONSTRAINT [FK_h_alarm_L_error] FOREIGN KEY ([controller_id]) REFERENCES [C4G].[L_error] ([id])
);




GO
CREATE NONCLUSTERED INDEX [IX_h_alarm]
    ON [C4G].[h_alarm]([id] ASC);

