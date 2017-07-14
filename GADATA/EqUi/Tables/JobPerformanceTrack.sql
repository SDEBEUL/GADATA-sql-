CREATE TABLE [EqUi].[JobPerformanceTrack] (
    [testtime]  DATETIME  NOT NULL,
    [name]      [sysname] NOT NULL,
    [step_id]   INT       NOT NULL,
    [step_name] [sysname] NOT NULL,
    [avgExec]   INT       NULL,
    [MaxExec]   INT       NULL,
    [MinExec]   INT       NULL
);

