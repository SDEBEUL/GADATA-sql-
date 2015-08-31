﻿CREATE TABLE [C4G].[rt_sys_event] (
    [id]            INT      IDENTITY (1, 1) NOT NULL,
    [controller_id] INT      NULL,
    [_timestamp]    DATETIME NULL,
    [sys_state]     INT      NULL,
    CONSTRAINT [PK_rt_sys_event] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_sys_event_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [C4G].[c_controller] ([id])
);

