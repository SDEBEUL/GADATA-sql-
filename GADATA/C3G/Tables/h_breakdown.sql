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
    CONSTRAINT [FK_h_breakdown_L_error] FOREIGN KEY ([error_id]) REFERENCES [C3G].[L_error] ([id]),
    CONSTRAINT [FK_h_breakdown_L_error1] FOREIGN KEY ([RC_error_id]) REFERENCES [C3G].[L_error] ([id])
);

