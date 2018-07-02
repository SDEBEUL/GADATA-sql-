CREATE TABLE [NGAC].[rt_LOGFILEDress] (
    [id]             INT        IDENTITY (1, 1) NOT NULL,
    [_timestamp]     DATETIME   NULL,
    [rt_csv_file_id] INT        NULL,
    [Date Time]      DATETIME   NULL,
    [CT]             FLOAT (53) NULL,
    CONSTRAINT [PK_rt_LOGFILEDress] PRIMARY KEY CLUSTERED ([id] ASC)
);

