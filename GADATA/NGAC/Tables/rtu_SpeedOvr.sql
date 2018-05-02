CREATE TABLE [NGAC].[rtu_SpeedOvr] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [c_variable_id]   INT           NULL,
    [c_controller_id] INT           NULL,
    [_timestamp]      DATETIME      NULL,
    [value]           VARCHAR (MAX) NULL,
    [isEvent]         BIT           NULL,
    [abbDateTime]     DATETIME      NULL
);

