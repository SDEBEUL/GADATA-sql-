CREATE TABLE [RobotGA].[L_robotpositions] (
    [ID]             INT          IDENTITY (1, 1) NOT NULL,
    [_timestamp]     DATETIME     CONSTRAINT [DF_L_robotpositions] DEFAULT (getdate()) NULL,
    [file_timestamp] DATETIME     NULL,
    [controller_id]  INT          NULL,
    [Owner]          VARCHAR (50) NULL,
    [Pos]            VARCHAR (50) NULL,
    [X]              REAL         NULL,
    [Y]              REAL         NULL,
    [Z]              REAL         NULL,
    [a]              REAL         NULL,
    [e]              REAL         NULL,
    [r]              REAL         NULL,
    [ax7]            REAL         NULL,
    [ax8]            REAL         NULL,
    [Cnfg]           VARCHAR (20) NULL,
    CONSTRAINT [PK_L_robotpositions] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IndexTableUniqueRows]
    ON [RobotGA].[L_robotpositions]([controller_id] ASC, [Owner] ASC, [Pos] ASC, [X] ASC, [Y] ASC, [Z] ASC, [a] ASC, [e] ASC, [r] ASC, [ax7] ASC, [ax8] ASC) WITH (IGNORE_DUP_KEY = ON);

