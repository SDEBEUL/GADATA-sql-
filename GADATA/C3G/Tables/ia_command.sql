CREATE TABLE [C3G].[ia_command] (
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [_timestamp]    DATETIME      NULL,
    [command]       VARCHAR (10)  NULL,
    [vcsc_name]     VARCHAR (256) NULL,
    [controller_id] INT           NULL,
    [adata]         INT           NULL,
    [description]   VARCHAR (256) NULL,
    [reply_table]   VARCHAR (256) NULL,
    [request_data]  VARCHAR (256) NULL,
    [sdata]         VARCHAR (256) NULL,
    CONSTRAINT [PK_ia_command] PRIMARY KEY CLUSTERED ([id] ASC)
);

