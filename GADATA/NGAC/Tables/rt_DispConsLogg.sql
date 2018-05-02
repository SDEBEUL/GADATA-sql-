CREATE TABLE [NGAC].[rt_DispConsLogg] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [rt_csv_file_id] INT           NULL,
    [Date Time]      VARCHAR (MAX) NULL,
    [Vehirle_Nr]     VARCHAR (MAX) NULL,
    [Det_ID]         VARCHAR (MAX) NULL,
    [Proc]           VARCHAR (MAX) NULL,
    [Info]           VARCHAR (MAX) NULL,
    [LoggTyp]        VARCHAR (MAX) NULL,
    [BeadID]         VARCHAR (MAX) NULL,
    [MTR_Cons]       VARCHAR (MAX) NULL,
    [_timestamp]     DATETIME      NULL,
    CONSTRAINT [PK_rt_DispConsLogg] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_DispConsLogg_rt_csv_file] FOREIGN KEY ([rt_csv_file_id]) REFERENCES [NGAC].[rt_csv_file] ([id])
);



