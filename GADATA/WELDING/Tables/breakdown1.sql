CREATE TABLE [WELDING].[breakdown1] (
    [TimerID]       INT            NULL,
    [timerfault]    NCHAR (50)     NULL,
    [starttime]     DATETIME       NULL,
    [Breakdowntime] TIME (7)       NULL,
    [WMComment]     NVARCHAR (MAX) NULL,
    CONSTRAINT [FK_breakdown_Timer] FOREIGN KEY ([TimerID]) REFERENCES [dbo].[Timer] ([ID])
);

