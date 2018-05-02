CREATE TABLE [WELDING].[Breakdown] (
    [ID]            INT            IDENTITY (1, 1) NOT NULL,
    [TimerID]       INT            NULL,
    [TimerFault]    NCHAR (100)    NULL,
    [Starttime]     DATETIME       NULL,
    [Breakdowntime] TIME (7)       NULL,
    [WMComment]     NVARCHAR (MAX) NULL
);

