CREATE TABLE [Volvo].[L_ActivityLog] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [_timestamp] DATETIME      NULL,
    [login]      VARCHAR (255) NULL,
    [Hostname]   VARCHAR (255) NULL,
    [CPUtime]    INT           NULL,
    [DiskIo]     INT           NULL,
    [NRows]      INT           NULL,
    [Request]    VARCHAR (255) NULL,
    CONSTRAINT [PK_L_ActivityLog] PRIMARY KEY CLUSTERED ([id] ASC)
);

