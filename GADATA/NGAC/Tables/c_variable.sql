CREATE TABLE [NGAC].[c_variable] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [variable]   VARCHAR (MAX) NULL,
    [poll_rate]  INT           NOT NULL,
    [enable_bit] INT           NOT NULL,
    [event_enum] INT           NOT NULL,
    [sql_action] INT           NOT NULL,
    [rt_table]   VARCHAR (MAX) NULL,
    CONSTRAINT [PK_c_variable_1] PRIMARY KEY CLUSTERED ([id] ASC)
);



