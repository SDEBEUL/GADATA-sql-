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
CREATE UNIQUE NONCLUSTERED INDEX [NCI_C4G_Resptime]
    ON [C4G].[h_breakdown]([controller_id] ASC, [error_id] ASC, [EndOfBreakdown] ASC, [Rt] ASC, [Trig_state] ASC, [id] ASC);


GO
CREATE NONCLUSTERED INDEX [_dta_index_h_breakdown_23_2039118455__K2_K3_K8_K9_1_4_7]
    ON [C4G].[h_breakdown]([controller_id] ASC, [EndOfBreakdown] ASC, [error_id] ASC, [RC_error_id] ASC)
    INCLUDE([id], [Rt], [StartOfBreakdown]);


GO
CREATE STATISTICS [_dta_stat_2039118455_8_3_2_9]
    ON [C4G].[h_breakdown]([error_id], [EndOfBreakdown], [controller_id], [RC_error_id]);


GO
CREATE STATISTICS [_dta_stat_2039118455_2_8_9]
    ON [C4G].[h_breakdown]([controller_id], [error_id], [RC_error_id]);

