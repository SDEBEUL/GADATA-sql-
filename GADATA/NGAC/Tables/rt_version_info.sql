CREATE TABLE [NGAC].[rt_version_info] (
    [id]                   INT           IDENTITY (1, 1) NOT NULL,
    [c_variable_search_id] INT           NULL,
    [c_controller_id]      INT           NULL,
    [_timestamp]           DATETIME      NULL,
    [task]                 VARCHAR (MAX) NULL,
    [module]               VARCHAR (MAX) NULL,
    [variable]             VARCHAR (MAX) NULL,
    [value]                VARCHAR (MAX) NULL
);

