CREATE TABLE [ABB].[c_config] (
    [id]       INT          IDENTITY (1, 1) NOT NULL,
    [_varname] VARCHAR (50) NULL,
    [_value]   BIT          NULL,
    CONSTRAINT [PK_c_config] PRIMARY KEY CLUSTERED ([id] ASC)
);

