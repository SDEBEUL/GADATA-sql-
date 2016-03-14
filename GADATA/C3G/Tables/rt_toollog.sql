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

