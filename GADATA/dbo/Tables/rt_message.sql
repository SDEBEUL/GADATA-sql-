CREATE TABLE [dbo].[rt_message] (
    [id]         INT            IDENTITY (1, 1) NOT NULL,
    [_timestamp] DATETIME       NULL,
    [_message]   VARCHAR (2000) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

