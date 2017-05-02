CREATE TABLE [C3G].[h_breakdown] (
    [id]               INT      IDENTITY (1, 1) NOT NULL,
    [controller_id]    INT      NULL,
    [EndOfBreakdown]   DATETIME NULL,
    [StartOfBreakdown] DATETIME NULL,
    [Trig_state]       INT      NULL,
    [Trig_id]          INT      NOT NULL,
    [Rt]               DATETIME NULL,
    [error_id]         INT      NULL,
    [RC_error_id]      INT      NULL,
    CONSTRAINT [FK_h_breakdown_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [C3G].[c_controller] ([id]),
    CONSTRAINT [FK_h_breakdown_L_error] FOREIGN KEY ([error_id]) REFERENCES [C3G].[L_error] ([id]),
    CONSTRAINT [FK_h_breakdown_L_error1] FOREIGN KEY ([RC_error_id]) REFERENCES [C3G].[L_error] ([id])
);
















GO
CREATE NONCLUSTERED INDEX [nci_h_breakdown]
    ON [C3G].[h_breakdown]([controller_id] ASC)
    INCLUDE([id], [EndOfBreakdown], [StartOfBreakdown], [Trig_state], [error_id], [RC_error_id]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_h_breakdown_23_1291660__K2_K3_K8_K9_1_4_5_7]
    ON [C3G].[h_breakdown]([controller_id] ASC, [EndOfBreakdown] ASC, [error_id] ASC, [RC_error_id] ASC)
    INCLUDE([Rt], [StartOfBreakdown], [Trig_state], [id]);


GO
CREATE STATISTICS [_dta_stat_1291660_8_9]
    ON [C3G].[h_breakdown]([error_id], [RC_error_id]);


GO
CREATE STATISTICS [_dta_stat_1291660_3_8_9]
    ON [C3G].[h_breakdown]([EndOfBreakdown], [error_id], [RC_error_id]);


GO
CREATE STATISTICS [_dta_stat_1291660_3_2_8]
    ON [C3G].[h_breakdown]([EndOfBreakdown], [controller_id], [error_id]);


GO
CREATE STATISTICS [_dta_stat_1291660_2_8_9_3]
    ON [C3G].[h_breakdown]([controller_id], [error_id], [RC_error_id], [EndOfBreakdown]);

