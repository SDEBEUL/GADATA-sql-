CREATE TABLE [dbo].[rt_alarmbackup] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [controller_id]   INT           NULL,
    [_timestamp]      DATETIME      NULL,
    [error_timestamp] DATETIME      NULL,
    [error_number]    INT           NULL,
    [error_count]     INT           NULL,
    [error_severity]  INT           NULL,
    [error_text]      VARCHAR (256) NULL,
    [error_is_alarm]  BIT           NULL,
    [error_id]        INT           NULL
);

