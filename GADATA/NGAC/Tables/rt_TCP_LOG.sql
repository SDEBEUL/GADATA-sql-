CREATE TABLE [NGAC].[rt_TCP_LOG] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [rt_csv_file_id] INT           NULL,
    [Date Time]      DATETIME      NULL,
    [Tool Name]      VARCHAR (MAX) NULL,
    [SetUp No]       INT           NULL,
    [Tool Diff X]    FLOAT (53)    NULL,
    [Tool Diff Y]    FLOAT (53)    NULL,
    [Tool Diff Z]    FLOAT (53)    NULL,
    [Tool Tol X]     FLOAT (53)    NULL,
    [Tool Tol Y]     FLOAT (53)    NULL,
    [Tool Tol Z]     FLOAT (53)    NULL,
    [Old TCP X]      FLOAT (53)    NULL,
    [Old TCP Y]      FLOAT (53)    NULL,
    [Old TCP Z]      FLOAT (53)    NULL,
    [New TCP X]      FLOAT (53)    NULL,
    [New TCP Y]      FLOAT (53)    NULL,
    [New TCP Z]      FLOAT (53)    NULL,
    [Action]         VARCHAR (MAX) NULL,
    [_timestamp]     DATETIME      NULL,
    CONSTRAINT [PK_rt_TCP_LOG] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_TCP_LOG_rt_csv_file] FOREIGN KEY ([rt_csv_file_id]) REFERENCES [NGAC].[rt_csv_file] ([id])
);



