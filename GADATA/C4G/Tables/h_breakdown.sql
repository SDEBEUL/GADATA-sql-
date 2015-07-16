CREATE TABLE [C4G].[h_breakdown] (
    [id]               INT      IDENTITY (1, 1) NOT NULL,
    [controller_id]    INT      NULL,
    [EndOfBreakdown]   DATETIME NULL,
    [StartOfBreakdown] DATETIME NULL,
    [Trig_state]       INT      NULL,
    [Trig_id]          INT      NOT NULL,
    [Rt]               DATETIME NULL,
    [error_id]         INT      NULL,
    [RC_error_id]      INT      NULL
);








GO
CREATE UNIQUE NONCLUSTERED INDEX [NCI_C4G_Resptime]
    ON [C4G].[h_breakdown]([controller_id] ASC, [error_id] ASC, [EndOfBreakdown] ASC, [Rt] ASC, [Trig_state] ASC, [id] ASC);

