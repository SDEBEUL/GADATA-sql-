CREATE TABLE [RobotGA].[L_robotpositionsOLD] (
    [ID]             INT          IDENTITY (1, 1) NOT NULL,
    [_timestamp]     DATETIME     NULL,
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

