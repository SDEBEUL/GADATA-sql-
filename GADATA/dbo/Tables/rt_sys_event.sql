CREATE TABLE [dbo].[rt_sys_event] (
    [id]            INT      IDENTITY (1, 1) NOT NULL,
    [controller_id] INT      NULL,
    [_timestamp]    DATETIME NULL,
    [sys_state]     INT      NULL,
    CONSTRAINT [PK_rt_sys_event] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_sys_event_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [dbo].[c_controller] ([id])
);






GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_rt_sys_event]
    ON [dbo].[rt_sys_event]([controller_id] ASC, [_timestamp] ASC, [id] ASC, [sys_state] ASC);

