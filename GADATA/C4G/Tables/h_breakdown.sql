CREATE TABLE [C4G].[h_breakdown] (
    [id]               INT      IDENTITY (1, 1) NOT NULL,
    [controller_id]    INT      NULL,
    [_timestamp]       DATETIME NULL,
    [sys_state]        INT      NULL,
    [sys_event_id]     INT      NULL,
    [h_alarm_id]       INT      NULL,
    [h_alarm_idRclass] INT      NULL,
    CONSTRAINT [PK_h_breakdown] PRIMARY KEY CLUSTERED ([id] ASC)
);

