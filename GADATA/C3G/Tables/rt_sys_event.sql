CREATE TABLE [C3G].[rt_sys_event] (
    [id]            INT      IDENTITY (1, 1) NOT NULL,
    [controller_id] INT      NULL,
    [_timestamp]    DATETIME NULL,
    [sys_state]     INT      NULL,
    [c_timestamp]   DATETIME NULL,
    CONSTRAINT [PK_rt_sys_event] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_sys_event_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [C3G].[c_controller] ([id])
);


GO
CREATE NONCLUSTERED INDEX [nci_sysEvent1]
    ON [C3G].[rt_sys_event]([_timestamp] ASC)
    INCLUDE([c_timestamp], [controller_id], [id], [sys_state]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_rt_sys_event_23_1492772971__K2_K3_4]
    ON [C3G].[rt_sys_event]([controller_id] ASC, [_timestamp] ASC)
    INCLUDE([sys_state]);


GO
CREATE NONCLUSTERED INDEX [nci_rt_sysevent_tis]
    ON [C3G].[rt_sys_event]([_timestamp] ASC)
    INCLUDE([controller_id], [id], [sys_state]);

