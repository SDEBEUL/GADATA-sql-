CREATE TABLE [C3G].[h_alarm] (
    [id]             INT      IDENTITY (1, 1) NOT NULL,
    [controller_id]  INT      NULL,
    [_timestamp]     DATETIME NULL,
    [c_timestamp]    DATETIME NULL,
    [error_is_alarm] BIT      NULL,
    [error_id]       INT      NULL,
    [is_realtime]    BIT      NULL,
    CONSTRAINT [PK_h_alarm] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_h_alarm_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [C3G].[c_controller] ([id]),
    CONSTRAINT [FK_h_alarm_L_error] FOREIGN KEY ([error_id]) REFERENCES [C3G].[L_error] ([id])
);


GO
CREATE NONCLUSTERED INDEX [nci_halarm1]
    ON [C3G].[h_alarm]([_timestamp] ASC)
    INCLUDE([c_timestamp], [controller_id], [error_id]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_h_alarm_23_1940774567__K4_K2_K6_1]
    ON [C3G].[h_alarm]([c_timestamp] ASC, [controller_id] ASC, [error_id] ASC)
    INCLUDE([id]);


GO
CREATE NONCLUSTERED INDEX [<nci_equi_h_alarm2>]
    ON [C3G].[h_alarm]([controller_id] ASC, [c_timestamp] ASC)
    INCLUDE([error_id], [id]);


GO
CREATE NONCLUSTERED INDEX [<nci_errorview>]
    ON [C3G].[h_alarm]([error_is_alarm] ASC, [_timestamp] ASC, [c_timestamp] ASC)
    INCLUDE([controller_id], [error_id], [id]);


GO
CREATE NONCLUSTERED INDEX [c3g_nci_h_alarmEQUI]
    ON [C3G].[h_alarm]([c_timestamp] ASC)
    INCLUDE([controller_id], [error_id], [id]);


GO
CREATE STATISTICS [_dta_stat_1940774567_2_6]
    ON [C3G].[h_alarm]([controller_id], [error_id]);


GO
CREATE STATISTICS [_dta_stat_1940774567_2_4_6]
    ON [C3G].[h_alarm]([controller_id], [c_timestamp], [error_id]);


GO
CREATE STATISTICS [_dta_stat_1940774567_6_4]
    ON [C3G].[h_alarm]([error_id], [c_timestamp]);

