CREATE TABLE [PJV].[L_GIT] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [_timestamp]     DATETIME      NULL,
    [code]           INT           NULL,
    [rev_created]    INT           NULL,
    [RobotProgramId] INT           NULL,
    [filename]       VARCHAR (250) NULL,
    CONSTRAINT [PK_L_GIT] PRIMARY KEY CLUSTERED ([id] ASC)
);

