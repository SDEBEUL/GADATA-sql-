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
CREATE NONCLUSTERED INDEX [_dta_index_L_robotpositions_23_376244991__K4_K5_K6_K2_7_8_9_10_11_12]
    ON [C4G].[L_robotpositions]([controller_id] ASC, [Owner] ASC, [Pos] ASC, [_timestamp] ASC)
    INCLUDE([a], [e], [r], [X], [Y], [Z]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_L_robotpositions_23_376244991__K4_K5_K6_K2_K3_7_8_9_10_11_12]
    ON [C4G].[L_robotpositions]([controller_id] ASC, [Owner] ASC, [Pos] ASC, [_timestamp] ASC, [file_timestamp] ASC)
    INCLUDE([a], [e], [r], [X], [Y], [Z]);


GO
CREATE STATISTICS [_dta_stat_376244991_4_5_6_3]
    ON [C4G].[L_robotpositions]([controller_id], [Owner], [Pos], [file_timestamp]);


GO
CREATE STATISTICS [_dta_stat_376244991_3_6_5]
    ON [C4G].[L_robotpositions]([file_timestamp], [Pos], [Owner]);


GO
CREATE STATISTICS [_dta_stat_376244991_3_4_5]
    ON [C4G].[L_robotpositions]([file_timestamp], [controller_id], [Owner]);


GO
CREATE STATISTICS [_dta_stat_376244991_4_3_6]
    ON [C4G].[L_robotpositions]([controller_id], [file_timestamp], [Pos]);


GO
CREATE STATISTICS [_dta_stat_376244991_4_6]
    ON [C4G].[L_robotpositions]([controller_id], [Pos]);


GO
CREATE STATISTICS [_dta_stat_376244991_6_5]
    ON [C4G].[L_robotpositions]([Pos], [Owner]);

