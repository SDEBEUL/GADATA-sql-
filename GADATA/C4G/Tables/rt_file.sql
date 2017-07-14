CREATE TABLE [C4G].[rt_file] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [controller_id]   INT           NULL,
    [_timestamp]      DATETIME      NULL,
    [file_timestamp]  DATETIME      NULL,
    [_file_name]      VARCHAR (128) NULL,
    [file_attributes] INT           NULL,
    [file_size]       INT           NULL,
    [status]          INT           NULL,
    [entries]         INT           NULL,
    CONSTRAINT [PK_rt_file] PRIMARY KEY CLUSTERED ([id] ASC)
);

