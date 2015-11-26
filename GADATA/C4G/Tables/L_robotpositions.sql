CREATE TABLE [C4G].[L_robotpositions] (
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

CREATE TRIGGER [C4G].[C4G_L_robotpositions_remove_dup] ON [GADATA].[C4G].[L_robotpositions] for insert, update, delete
AS
IF ((SELECT TRIGGER_NESTLEVEL()) < 4)
BEGIN
 EXEC [C4g].[sp_L_Robotpositions_REMOVE_DUP]
END