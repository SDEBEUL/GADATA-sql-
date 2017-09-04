CREATE TABLE [NGAC].[c_csv_log] (
    [id]                INT           IDENTITY (1, 1) NOT NULL,
    [enable_bit]        INT           NULL,
    [csv_filename]      VARCHAR (50)  NULL,
    [logcount_variable] VARCHAR (50)  NULL,
    [rt_table]          VARCHAR (50)  NULL,
    [poll_rate]         INT           NULL,
    [comment]           VARCHAR (250) NULL,
    [Tempnote]          VARCHAR (250) NULL,
    CONSTRAINT [PK_c_csv_log] PRIMARY KEY CLUSTERED ([id] ASC)
);

