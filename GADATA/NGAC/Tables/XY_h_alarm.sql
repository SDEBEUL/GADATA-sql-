CREATE TABLE [NGAC].[XY_h_alarm] (
    [id]              INT      IDENTITY (1, 1) NOT NULL,
    [controller_id]   INT      NULL,
    [_timestamp]      DATETIME NULL,
    [error_timestamp] DATETIME NULL,
    [SequenceNumber]  INT      NULL,
    [L_error_id]      INT      NULL,
    [CategoryId]      INT      NULL,
    CONSTRAINT [PK_xy_h_alarm_1] PRIMARY KEY CLUSTERED ([id] ASC)
);

