CREATE TABLE [C4G].[ia_command] (
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [_timestamp]    DATETIME      NULL,
    [command]       VARCHAR (10)  NULL,
    [vcsc_name]     VARCHAR (256) NULL,
    [controller_id] INT           NULL,
    [adata]         INT           NULL,
    [description]   VARCHAR (256) NULL,
    [reply_table]   VARCHAR (256) NULL,
    [request_data]  VARCHAR (256) NULL,
    CONSTRAINT [PK_ia_command] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_ia_command_c_controller] FOREIGN KEY ([controller_id]) REFERENCES [C4G].[c_controller] ([id])
);



