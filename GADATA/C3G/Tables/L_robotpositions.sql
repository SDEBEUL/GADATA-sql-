CREATE TABLE [C3G].[L_robotpositions] (
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
CREATE NONCLUSTERED INDEX [_dta_index_L_robotpositions_23_1248632137__K4_K5_K6_K2_7_8_9_10_11_12]
    ON [C3G].[L_robotpositions]([controller_id] ASC, [Owner] ASC, [Pos] ASC, [_timestamp] ASC)
    INCLUDE([a], [e], [r], [X], [Y], [Z]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_L_robotpositions_23_1248632137__K4_K5_K6_K2_K3_7_8_9_10_11_12]
    ON [C3G].[L_robotpositions]([controller_id] ASC, [Owner] ASC, [Pos] ASC, [_timestamp] ASC, [file_timestamp] ASC)
    INCLUDE([a], [e], [r], [X], [Y], [Z]);


GO
CREATE STATISTICS [_dta_stat_1248632137_6_4_5_3_2]
    ON [C3G].[L_robotpositions]([Pos], [controller_id], [Owner], [file_timestamp], [_timestamp]);


GO
CREATE STATISTICS [_dta_stat_1248632137_4_3_5]
    ON [C3G].[L_robotpositions]([controller_id], [file_timestamp], [Owner]);


GO
CREATE STATISTICS [_dta_stat_1248632137_3_5_6]
    ON [C3G].[L_robotpositions]([file_timestamp], [Owner], [Pos]);


GO
CREATE STATISTICS [_dta_stat_1248632137_5_6]
    ON [C3G].[L_robotpositions]([Owner], [Pos]);

