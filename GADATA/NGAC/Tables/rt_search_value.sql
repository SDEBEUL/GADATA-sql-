CREATE TABLE [NGAC].[rt_search_value] (
    [id]                   INT           IDENTITY (1, 1) NOT NULL,
    [c_variable_search_id] INT           NULL,
    [c_controller_id]      INT           NULL,
    [_timestamp]           DATETIME      NULL,
    [task]                 VARCHAR (MAX) NULL,
    [module]               VARCHAR (MAX) NULL,
    [variable]             VARCHAR (MAX) NULL,
    [value]                VARCHAR (MAX) NULL,
    CONSTRAINT [PK_rt_search_value] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_Search_value_c_controller] FOREIGN KEY ([c_controller_id]) REFERENCES [NGAC].[c_controller] ([id]),
    CONSTRAINT [FK_rt_Search_value_c_variable_search] FOREIGN KEY ([c_variable_search_id]) REFERENCES [NGAC].[c_variable_search] ([id])
);

