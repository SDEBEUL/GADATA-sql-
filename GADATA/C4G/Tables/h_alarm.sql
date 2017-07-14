CREATE TABLE [C4G].[h_alarm] (
    [id]             INT      IDENTITY (1, 1) NOT NULL,
    [controller_id]  INT      NULL,
    [_timestamp]     DATETIME NULL,
    [c_timestamp]    DATETIME NULL,
    [error_is_alarm] BIT      NULL,
    [error_id]       INT      NULL,
    [is_realtime]    BIT      NULL,
    CONSTRAINT [PK_h_alarm] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_h_alarm_c_controller1] FOREIGN KEY ([controller_id]) REFERENCES [C4G].[c_controller] ([id]),
    CONSTRAINT [FK_h_alarm_L_error] FOREIGN KEY ([controller_id]) REFERENCES [C4G].[L_error] ([id])
);


GO
CREATE NONCLUSTERED INDEX [_dta_index_h_alarm_23_180963771__K4_K6_K2_1]
    ON [C4G].[h_alarm]([c_timestamp] ASC, [error_id] ASC, [controller_id] ASC)
    INCLUDE([id]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_h_alarm_23_180963771__K4_K2_K6_1]
    ON [C4G].[h_alarm]([c_timestamp] ASC, [controller_id] ASC, [error_id] ASC)
    INCLUDE([id]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_h_alarm_23_180963771__K2_K4_K6_1]
    ON [C4G].[h_alarm]([controller_id] ASC, [c_timestamp] ASC, [error_id] ASC)
    INCLUDE([id]);


GO
CREATE NONCLUSTERED INDEX [<nciErroStats,c4g,>]
    ON [C4G].[h_alarm]([controller_id] ASC, [_timestamp] ASC)
    INCLUDE([id]);


GO
CREATE NONCLUSTERED INDEX [NCI_h_alarm_controller_id-Error_is_alarm]
    ON [C4G].[h_alarm]([controller_id] ASC, [error_is_alarm] ASC)
    INCLUDE([_timestamp], [c_timestamp], [error_id], [id]);


GO
CREATE NONCLUSTERED INDEX [nci_IsAlarm]
    ON [C4G].[h_alarm]([error_is_alarm] ASC)
    INCLUDE([_timestamp], [c_timestamp], [controller_id], [error_id], [id]);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_C4G_h_alarm_Error2]
    ON [C4G].[h_alarm]([id] ASC, [error_is_alarm] ASC, [error_id] ASC, [controller_id] ASC, [_timestamp] ASC, [c_timestamp] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_C4G_h_alarm_Error]
    ON [C4G].[h_alarm]([id] ASC, [controller_id] ASC, [_timestamp] ASC, [error_is_alarm] ASC, [error_id] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_controller_id]
    ON [C4G].[h_alarm]([controller_id] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_error_id]
    ON [C4G].[h_alarm]([error_id] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_timestamp]
    ON [C4G].[h_alarm]([_timestamp] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_h_alarm]
    ON [C4G].[h_alarm]([id] ASC);


GO
CREATE STATISTICS [_dta_stat_180963771_4_2_6]
    ON [C4G].[h_alarm]([c_timestamp], [controller_id], [error_id]);


GO
CREATE STATISTICS [_dta_stat_180963771_2_6]
    ON [C4G].[h_alarm]([controller_id], [error_id]);


GO
CREATE STATISTICS [_dta_stat_180963771_4_6]
    ON [C4G].[h_alarm]([c_timestamp], [error_id]);

