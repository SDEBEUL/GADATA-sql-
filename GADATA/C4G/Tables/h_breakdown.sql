CREATE TABLE [C4G].[h_breakdown] (
    [id]               INT      IDENTITY (1, 1) NOT NULL,
    [controller_id]    INT      NULL,
    [_timestamp]       DATETIME NULL,
    [sys_state]        INT      NULL,
    [sys_event_id]     INT      NULL,
    [h_alarm_id]       INT      NULL,
    [h_alarm_idRclass] INT      NULL,
    CONSTRAINT [PK_h_breakdown] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_h_breakdown_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [dbo].[c_controller] ([id]),
    CONSTRAINT [FK_h_breakdown_h_alarm] FOREIGN KEY ([h_alarm_id]) REFERENCES [C4G].[h_alarm] ([id])
);



