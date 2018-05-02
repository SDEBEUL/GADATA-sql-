CREATE TABLE [PJV].[RobotRoutine] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [s_name]         VARCHAR (MAX) NULL,
    [programLine]    INT           NULL,
    [_timestamp]     DATETIME      NULL,
    [_lasttimestamp] DATETIME      NULL,
    [isDead]         INT           NULL,
    [RobotProgramId] INT           NULL,
    [rev_created]    INT           NULL,
    [rev_modified]   INT           NULL,
    CONSTRAINT [PK_RobotRoutine] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_RobotRoutine_RobotProgram] FOREIGN KEY ([RobotProgramId]) REFERENCES [PJV].[RobotProgram] ([id])
);

