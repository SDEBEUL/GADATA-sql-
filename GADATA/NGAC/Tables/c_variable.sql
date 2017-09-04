CREATE TABLE [NGAC].[c_variable] (
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [variable]      VARCHAR (MAX) NULL,
    [poll_rate]     INT           NULL,
    [enable_bit]    INT           NULL,
    [insert_update] INT           NULL,
    [rt_table]      VARCHAR (MAX) NULL
);

