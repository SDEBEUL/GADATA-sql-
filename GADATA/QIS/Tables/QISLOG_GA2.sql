CREATE TABLE [QIS].[QISLOG_GA2] (
    [Timestamp]     DATETIME    NULL,
    [TimerName]     NCHAR (20)  NULL,
    [program]       INT         NULL,
    [parameter]     NCHAR (250) NULL,
    [bos6000Value]  INT         NULL,
    [RequiredValue] INT         NULL,
    [remark]        NCHAR (50)  NULL
);

