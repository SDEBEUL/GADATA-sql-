CREATE TABLE [RobotGA].[L_timesync] (
    [id]           INT        IDENTITY (1, 1) NOT NULL,
    [Robot]        NCHAR (10) NULL,
    [_timestamp]   DATETIME   NULL,
    [Robottime]    DATETIME   NULL,
    [RobotAcktime] DATETIME   NULL,
    CONSTRAINT [PK_L_timesync] PRIMARY KEY CLUSTERED ([id] ASC)
);

