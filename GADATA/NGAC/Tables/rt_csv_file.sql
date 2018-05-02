CREATE TABLE [NGAC].[rt_csv_file] (
    [id]              INT      IDENTITY (1, 1) NOT NULL,
    [_timestamp]      DATETIME NULL,
    [c_controller_id] INT      NULL,
    [c_csv_log_id]    INT      NULL,
    [lastDateRecord]  DATETIME NULL,
    [lastLineRead]    INT      NULL,
    [lastFileSize]    INT      NULL,
    [lastStreamPos]   INT      NULL,
    [lastLineRead_2]  INT      NULL,
    [lastFileSize_2]  INT      NULL,
    [lastStreamPos_2] INT      NULL,
    CONSTRAINT [PK_rt_csv_file] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_csv_file_c_controller] FOREIGN KEY ([c_controller_id]) REFERENCES [NGAC].[c_controller] ([id]),
    CONSTRAINT [FK_rt_csv_file_c_csv_log] FOREIGN KEY ([c_csv_log_id]) REFERENCES [NGAC].[c_csv_log] ([id])
);




GO
CREATE NONCLUSTERED INDEX [_dta_index_rt_csv_file_23_1974922753__K1_2]
    ON [NGAC].[rt_csv_file]([id] ASC)
    INCLUDE([c_controller_id]);


GO


