CREATE TABLE [C3G].[h_alarm] (
    [id]             INT      IDENTITY (1, 1) NOT NULL,
    [controller_id]  INT      NULL,
    [_timestamp]     DATETIME NULL,
    [c_timestamp]    DATETIME NULL,
    [error_is_alarm] BIT      NULL,
    [error_id]       INT      NULL,
    [is_realtime]    BIT      NULL,
    CONSTRAINT [PK_h_alarm] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_h_alarm_L_error] FOREIGN KEY ([error_id]) REFERENCES [C3G].[L_error] ([id])
);










GO
CREATE NONCLUSTERED INDEX [nci_h_alarm]
    ON [C3G].[h_alarm]([controller_id] ASC, [_timestamp] ASC)
    INCLUDE([c_timestamp], [error_id]);

