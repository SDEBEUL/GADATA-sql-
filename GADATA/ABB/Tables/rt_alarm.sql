CREATE TABLE [ABB].[rt_alarm] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [controller_name] VARCHAR (26)  NULL,
    [_timestamp]      DATETIME      NULL,
    [error_text]      VARCHAR (255) NULL,
    CONSTRAINT [PK_rt_alarm] PRIMARY KEY CLUSTERED ([id] ASC)
);

