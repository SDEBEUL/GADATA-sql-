CREATE TABLE [dbo].[rt_ABB_IRC5_AE] (
    [id]            INT            IDENTITY (1, 1) NOT NULL,
    [_TIMESTAMP]    DATETIME       NULL,
    [_MESSAGE]      VARCHAR (2000) NULL,
    [_sqlTimestamp] DATETIME       CONSTRAINT [DF_rt_ABB_IRC5_AE__sqlTimestamp] DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

