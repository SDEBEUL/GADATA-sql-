CREATE TABLE [NGAC].[c_device_info] (
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [name]          VARCHAR (MAX) NULL,
    [enable_bit]    INT           NOT NULL,
    [poll_rate]     INT           NOT NULL,
    [insert_update] INT           NOT NULL,
    [URL]           VARCHAR (MAX) NULL,
    CONSTRAINT [PK_c_device_info] PRIMARY KEY CLUSTERED ([id] ASC)
);



