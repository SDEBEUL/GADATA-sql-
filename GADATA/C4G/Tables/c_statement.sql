CREATE TABLE [C4G].[c_statement] (
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [bit_id]        INT           NULL,
    [update_rate]   INT           NULL,
    [status_handle] INT           NULL,
    [statement]     VARCHAR (304) NULL,
    [keycode]       INT           NULL,
    CONSTRAINT [PK_c_statement] PRIMARY KEY CLUSTERED ([id] ASC)
);

