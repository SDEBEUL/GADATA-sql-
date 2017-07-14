CREATE TABLE [C3G].[rt_toollog] (
    [ID]             INT      IDENTITY (1, 1) NOT NULL,
    [tool_timestamp] DATETIME NULL,
    [tool_id]        TINYINT  NULL,
    [Dmeas]          REAL     NULL,
    [Dsetup]         REAL     NULL,
    [ToolX]          REAL     NULL,
    [Tooly]          REAL     NULL,
    [ToolZ]          REAL     NULL,
    [ToolA]          REAL     NULL,
    [ToolE]          REAL     NULL,
    [ToolR]          REAL     NULL,
    [controller_id]  INT      NULL,
    [Longcheck]      BIT      NULL,
    [TcpUpdate]      BIT      NULL,
    CONSTRAINT [PK_rt_toollog] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [_dta_index_rt_toollog_23_1216632023__K12_K2_3_4_5_13_14]
    ON [C3G].[rt_toollog]([controller_id] ASC, [tool_timestamp] ASC)
    INCLUDE([Dmeas], [Dsetup], [Longcheck], [TcpUpdate], [tool_id]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_rt_toollog_23_1216632023__K2_1_3_4_5_12_13_14]
    ON [C3G].[rt_toollog]([tool_timestamp] ASC)
    INCLUDE([controller_id], [Dmeas], [Dsetup], [ID], [Longcheck], [TcpUpdate], [tool_id]);


GO
CREATE NONCLUSTERED INDEX [nci_tool_id_Dsetup_controller_id]
    ON [C3G].[rt_toollog]([Longcheck] ASC, [tool_timestamp] ASC)
    INCLUDE([controller_id], [Dsetup], [tool_id]);


GO
CREATE NONCLUSTERED INDEX [nci_c3g_rt_toollog__tool_timesamp__longcheck]
    ON [C3G].[rt_toollog]([tool_timestamp] ASC, [Longcheck] ASC)
    INCLUDE([controller_id], [tool_id]);


GO
CREATE STATISTICS [_dta_stat_1216632023_2_12]
    ON [C3G].[rt_toollog]([tool_timestamp], [controller_id]);

