CREATE TABLE [RobotGA].[RobotClass] (
    [ID]   INT         IDENTITY (1, 1) NOT NULL,
    [type] NCHAR (255) NULL,
    CONSTRAINT [PK_RobotClass] PRIMARY KEY CLUSTERED ([ID] ASC)
);

