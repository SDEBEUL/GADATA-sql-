CREATE TABLE [C3G].[rt_breakdown] (
    [id]               INT      IDENTITY (1, 1) NOT NULL,
    [controller_id]    INT      NULL,
    [EndOfBreakdown]   DATETIME NULL,
    [StartOfBreakdown] DATETIME NULL,
    [Trig_state]       INT      NULL,
    [Trig_id]          INT      NOT NULL,
    [Rt]               DATETIME NULL,
    [error_id]         INT      NULL,
    [RC_error_id]      INT      NULL,
    [Active_state]     INT      NULL
);

