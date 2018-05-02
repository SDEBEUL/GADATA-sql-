CREATE TABLE [C4G].[h_breakdown] (
    [id]               INT      IDENTITY (1, 1) NOT NULL,
    [controller_id]    INT      NULL,
    [EndOfBreakdown]   DATETIME NULL,
    [StartOfBreakdown] DATETIME NULL,
    [Trig_state]       INT      NULL,
    [Trig_id]          INT      NOT NULL,
    [Rt]               DATETIME NULL,
    [error_id]         INT      NULL,
    [RC_error_id]      INT      NULL,
    CONSTRAINT [FK_h_breakdown_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [C4G].[c_controller] ([id])
);




GO
CREATE NONCLUSTERED INDEX [_dta_index_h_breakdown_23_2039118455__K4D_1_2_8]
    ON [C4G].[h_breakdown]([StartOfBreakdown] DESC)
    INCLUDE([controller_id], [error_id], [id]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_h_breakdown_23_2039118455__K3_K2_K8_K9_1_4_7]
    ON [C4G].[h_breakdown]([EndOfBreakdown] ASC, [controller_id] ASC, [error_id] ASC, [RC_error_id] ASC)
    INCLUDE([id], [Rt], [StartOfBreakdown]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_h_breakdown_23_2039118455__K3_1_2_4_7_8_9]
    ON [C4G].[h_breakdown]([EndOfBreakdown] ASC)
    INCLUDE([error_id], [id], [RC_error_id], [Rt], [StartOfBreakdown], [controller_id]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_h_breakdown_23_2039118455__K2_K3_K8_K9_1_4_7]
    ON [C4G].[h_breakdown]([controller_id] ASC, [EndOfBreakdown] ASC, [error_id] ASC, [RC_error_id] ASC)
    INCLUDE([Rt], [StartOfBreakdown], [id]);


GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_C4G_Resptime]
    ON [C4G].[h_breakdown]([controller_id] ASC, [error_id] ASC, [EndOfBreakdown] ASC, [Rt] ASC, [Trig_state] ASC, [id] ASC);


GO
CREATE STATISTICS [_dta_stat_2039118455_2_8_4]
    ON [C4G].[h_breakdown]([controller_id], [error_id], [StartOfBreakdown]);


GO
CREATE STATISTICS [_dta_stat_2039118455_8_9_3]
    ON [C4G].[h_breakdown]([error_id], [RC_error_id], [EndOfBreakdown]);


GO
CREATE STATISTICS [_dta_stat_2039118455_8_3_2_9]
    ON [C4G].[h_breakdown]([error_id], [EndOfBreakdown], [controller_id], [RC_error_id]);


GO
CREATE STATISTICS [_dta_stat_2039118455_2_8_9]
    ON [C4G].[h_breakdown]([controller_id], [error_id], [RC_error_id]);


GO
CREATE NONCLUSTERED INDEX [nci_c4gbreakdown]
    ON [C4G].[h_breakdown]([error_id] ASC)
    INCLUDE([id], [controller_id], [EndOfBreakdown], [StartOfBreakdown], [Rt]);

