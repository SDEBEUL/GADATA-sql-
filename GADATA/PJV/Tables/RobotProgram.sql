CREATE TABLE [PJV].[RobotProgram] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [p_name]         VARCHAR (50)  NULL,
    [isDead]         INT           NULL,
    [_timestamp]     DATETIME      NULL,
    [_lasttimestamp] DATETIME      NULL,
    [filename]       VARCHAR (50)  NULL,
    [robotDetailId]  INT           NULL,
    [size]           INT           NULL,
    [fileDateTime]   DATETIME      NULL,
    [fullFilename]   VARCHAR (MAX) NULL,
    [MD5]            VARCHAR (32)  NULL,
    [rev_created]    INT           NULL,
    [rev_modified]   INT           NULL,
    CONSTRAINT [PK_RobotProgram] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_RobotProgram_RobotDetail] FOREIGN KEY ([robotDetailId]) REFERENCES [PJV].[RobotDetail] ([id])
);

