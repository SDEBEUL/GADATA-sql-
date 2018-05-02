CREATE TABLE [NGAC].[rt_SpotErr] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [rt_csv_file_id] INT           NULL,
    [Date Time]      VARCHAR (MAX) NULL,
    [AlarmNo]        VARCHAR (MAX) NULL,
    [Txt 1]          VARCHAR (MAX) NULL,
    [Txt 2]          VARCHAR (MAX) NULL,
    [Txt 3]          VARCHAR (MAX) NULL,
    [Txt 4]          VARCHAR (MAX) NULL,
    [Txt 5]          VARCHAR (MAX) NULL,
    [Txt 6]          VARCHAR (MAX) NULL,
    [Txt 7]          VARCHAR (MAX) NULL,
    [Txt 8]          VARCHAR (MAX) NULL,
    [Txt 9]          VARCHAR (MAX) NULL,
    [Txt 10]         VARCHAR (MAX) NULL,
    [Txt 11]         VARCHAR (MAX) NULL,
    [Action]         VARCHAR (MAX) NULL,
    [_timestamp]     DATETIME      NULL,
    CONSTRAINT [PK_rt_SpotErr] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_SpotErr_rt_csv_file] FOREIGN KEY ([rt_csv_file_id]) REFERENCES [NGAC].[rt_csv_file] ([id])
);



