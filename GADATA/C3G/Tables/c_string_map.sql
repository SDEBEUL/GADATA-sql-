CREATE TABLE [C3G].[c_string_map] (
    [id]       INT           IDENTITY (1, 1) NOT NULL,
    [code]     INT           NULL,
    [_string]  VARCHAR (256) NULL,
    [_update]  INT           NULL,
    [rt_table] VARCHAR (50)  NULL,
    [rt_field] VARCHAR (50)  NULL,
    [rt_flags] INT           NULL,
    CONSTRAINT [PK_c_string_map] PRIMARY KEY CLUSTERED ([id] ASC)
);

