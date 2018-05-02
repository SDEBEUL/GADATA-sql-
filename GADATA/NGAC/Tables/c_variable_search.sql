CREATE TABLE [NGAC].[c_variable_search] (
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [variable]      VARCHAR (MAX) NULL,
    [property]      INT           NOT NULL,
    [datatype]      VARCHAR (100) NULL,
    [poll_rate]     INT           NOT NULL,
    [enable_bit]    INT           NOT NULL,
    [insert_update] INT           NOT NULL,
    [rt_table]      VARCHAR (MAX) NULL,
    CONSTRAINT [PK_c_variable_search] PRIMARY KEY CLUSTERED ([id] ASC)
);



