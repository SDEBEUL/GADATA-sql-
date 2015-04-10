CREATE TABLE [dbo].[rt_irc5_ae] (
    [id]         INT            IDENTITY (1, 1) NOT NULL,
    [_timestamp] DATETIME       NULL,
    [message]    VARCHAR (2000) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

