CREATE TABLE [EqUi].[UserPerformanceTrack] (
    [testtime]              DATETIME       NOT NULL,
    [session_id]            INT            NULL,
    [client_net_address]    VARCHAR (48)   NULL,
    [login_time]            DATETIME       NOT NULL,
    [host_name]             NVARCHAR (128) NULL,
    [client_interface_name] NVARCHAR (32)  NULL,
    [login_name]            NVARCHAR (128) NOT NULL,
    [status]                NVARCHAR (30)  NOT NULL,
    [cpu_time]              INT            NOT NULL,
    [memory_usage]          INT            NOT NULL,
    [reads]                 BIGINT         NOT NULL,
    [writes]                BIGINT         NOT NULL,
    [logical_reads]         BIGINT         NOT NULL,
    [db_name]               NVARCHAR (128) NULL
);

