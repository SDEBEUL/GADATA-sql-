CREATE TABLE [NGAC].[rt_DispMaterialConsv] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [rt_csv_file_id] INT           NULL,
    [Date Time]      VARCHAR (MAX) NULL,
    [Alarm Nr]       VARCHAR (MAX) NULL,
    [Txt1]           VARCHAR (MAX) NULL,
    [Txt2]           VARCHAR (MAX) NULL,
    [Txt3]           VARCHAR (MAX) NULL,
    [Txt4]           VARCHAR (MAX) NULL,
    [Txt5]           VARCHAR (MAX) NULL,
    [Txt6]           VARCHAR (MAX) NULL,
    [Txt7]           VARCHAR (MAX) NULL,
    [Txt8]           VARCHAR (MAX) NULL,
    [Txt9]           VARCHAR (MAX) NULL,
    [Txt10]          VARCHAR (MAX) NULL,
    [Txt11]          VARCHAR (MAX) NULL,
    [_timestamp]     DATETIME      NULL,
    CONSTRAINT [PK_rt_DispMaterialConsv] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_DispMaterialConsv_rt_csv_file] FOREIGN KEY ([rt_csv_file_id]) REFERENCES [NGAC].[rt_csv_file] ([id])
);



