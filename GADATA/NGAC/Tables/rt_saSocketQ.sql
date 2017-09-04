CREATE TABLE [NGAC].[rt_saSocketQ] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [_timestamp]      DATETIME      NULL,
    [c_controller_id] INT           NULL,
    [_index]          INT           NULL,
    [value]           VARCHAR (MAX) NULL
);

