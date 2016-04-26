CREATE TABLE [C3G].[rt_sys_event] (
    [id]            INT      IDENTITY (1, 1) NOT NULL,
    [controller_id] INT      NULL,
    [_timestamp]    DATETIME NULL,
    [sys_state]     INT      NULL,
    [c_timestamp]   DATETIME NULL,
    CONSTRAINT [PK_rt_sys_event] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_sys_event_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [C3G].[c_controller2] ([id])
);








GO
CREATE NONCLUSTERED INDEX [nci_rt_sysevent_tis]
    ON [C3G].[rt_sys_event]([_timestamp] ASC)
    INCLUDE([id], [controller_id], [sys_state]);

