CREATE TABLE [NGAC].[rt_event] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [c_event_id]      INT           NULL,
    [c_controller_id] INT           NULL,
    [_timestamp]      DATETIME      NULL,
    [abbDateTime]     DATETIME      NULL,
    [value]           VARCHAR (MAX) NULL,
    [isEvent]         BIT           NULL
);

