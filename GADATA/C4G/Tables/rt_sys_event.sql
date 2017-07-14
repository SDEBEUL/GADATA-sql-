CREATE TABLE [C4G].[rt_sys_event] (
    [id]            INT      IDENTITY (1, 1) NOT NULL,
    [controller_id] INT      NULL,
    [_timestamp]    DATETIME NULL,
    [sys_state]     INT      NULL,
    [c_timestamp]   DATETIME NULL,
    CONSTRAINT [PK_rt_sys_event] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_sys_event_c_controller1] FOREIGN KEY ([controller_id]) REFERENCES [C4G].[c_controller] ([id])
);


GO
CREATE NONCLUSTERED INDEX [_dta_index_rt_sys_event_23_452769266__K3_1_2_4]
    ON [C4G].[rt_sys_event]([_timestamp] ASC)
    INCLUDE([controller_id], [id], [sys_state]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_rt_sys_event_23_452769266__K2_K3]
    ON [C4G].[rt_sys_event]([controller_id] ASC, [_timestamp] ASC);

