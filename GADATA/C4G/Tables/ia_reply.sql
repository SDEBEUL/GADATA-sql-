CREATE TABLE [C4G].[ia_reply] (
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [command_id]    INT           NULL,
    [_timestamp]    DATETIME      NULL,
    [vcsc_name]     VARCHAR (256) NULL,
    [request_data]  VARCHAR (256) NULL,
    [state]         INT           NULL,
    [status]        INT           NULL,
    [controller_id] INT           NULL,
    [count]         INT           NULL,
    CONSTRAINT [PK_ia_reply] PRIMARY KEY CLUSTERED ([id] ASC)
);

