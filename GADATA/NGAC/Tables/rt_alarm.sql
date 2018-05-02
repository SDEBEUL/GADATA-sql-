CREATE TABLE [NGAC].[rt_alarm] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [controller_id]   INT           NULL,
    [_timestamp]      DATETIME      NULL,
    [error_timestamp] DATETIME      NULL,
    [sequenceNumber]  INT           NULL,
    [number]          INT           NULL,
    [categoryId]      INT           NULL,
    [title]           VARCHAR (MAX) NULL,
    [description]     VARCHAR (MAX) NULL,
    [consequences]    VARCHAR (MAX) NULL,
    [causes]          VARCHAR (MAX) NULL,
    [actions]         VARCHAR (MAX) NULL,
    [type]            VARCHAR (MAX) NULL,
    CONSTRAINT [PK_rt_alarm_1] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_alarm_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [NGAC].[c_controller] ([id])
);

