CREATE TABLE [NGAC].[rt_DispSysLogg] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [rt_csv_file_id] INT           NULL,
    [Date Time]      VARCHAR (MAX) NULL,
    [Vehirle_Nr]     VARCHAR (MAX) NULL,
    [Det_ID]         VARCHAR (MAX) NULL,
    [Proc]           VARCHAR (MAX) NULL,
    [Info]           VARCHAR (MAX) NULL,
    [LoggTyp]        VARCHAR (MAX) NULL,
    [RobTarget]      VARCHAR (MAX) NULL,
    [BeadID]         VARCHAR (MAX) NULL,
    [MTR_Cons]       VARCHAR (MAX) NULL,
    [FuncTime]       VARCHAR (MAX) NULL,
    [Txt 10]         VARCHAR (MAX) NULL,
    [Txt 11]         VARCHAR (MAX) NULL,
    [Txt 12]         VARCHAR (MAX) NULL,
    [Action]         VARCHAR (MAX) NULL,
    [_timestamp]     DATETIME      NULL,
    CONSTRAINT [PK_rt_DispSysLogg] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_DispSysLogg_rt_csv_file] FOREIGN KEY ([rt_csv_file_id]) REFERENCES [NGAC].[rt_csv_file] ([id])
);



