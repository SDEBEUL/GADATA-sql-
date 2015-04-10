CREATE TABLE [RobotGA].[RobotLogText] (
    [ID]      INT         IDENTITY (1, 1) NOT NULL,
    [LogText] NCHAR (255) NULL,
    CONSTRAINT [PK_RobotLogText] PRIMARY KEY CLUSTERED ([ID] ASC)
);

