CREATE TABLE [C4G].[rt_statement] (
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [controller_id] INT           NULL,
    [statement_id]  INT           NULL,
    [_timestamp]    DATETIME      NULL,
    [status]        INT           NULL,
    [status_text]   VARCHAR (256) NULL,
    CONSTRAINT [PK_rt_statement] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_statement_c_statement] FOREIGN KEY ([statement_id]) REFERENCES [C4G].[c_statement] ([id])
);

