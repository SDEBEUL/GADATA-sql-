CREATE TABLE [NGAC].[rt_ErrDispLog] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [rt_csv_file_id] INT           NULL,
    [Date Time]      DATETIME      NULL,
    [AlarmNo]        INT           NULL,
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
    CONSTRAINT [PK_rt_ErrDispLog] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_ErrDispLog_rt_csv_file] FOREIGN KEY ([rt_csv_file_id]) REFERENCES [NGAC].[rt_csv_file] ([id])
);




GO
CREATE NONCLUSTERED INDEX [_dta_index_rt_ErrDispLog_23_467441385__K3_K2_K1_4_5_6_7_8_9_10_11_12_13_14_15_16]
    ON [NGAC].[rt_ErrDispLog]([Date Time] ASC, [rt_csv_file_id] ASC, [id] ASC)
    INCLUDE([Txt 1], [Txt 10], [Txt 11], [Txt 2], [Txt 3], [Txt 4], [Txt 5], [Txt 6], [Txt 7], [Txt 8], [Txt 9], [Action], [AlarmNo]);


GO
CREATE STATISTICS [_dta_stat_467441385_2_3_1]
    ON [NGAC].[rt_ErrDispLog]([rt_csv_file_id], [Date Time], [id]);


GO
CREATE STATISTICS [_dta_stat_467441385_3_1]
    ON [NGAC].[rt_ErrDispLog]([Date Time], [id]);

