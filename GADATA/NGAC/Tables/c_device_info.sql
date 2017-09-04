CREATE TABLE [NGAC].[c_device_info] (
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [name]          VARCHAR (MAX) NULL,
    [enable_bit]    INT           NULL,
    [poll_rate]     INT           NULL,
    [insert_update] INT           NULL,
    [URL]           VARCHAR (MAX) NULL
);

