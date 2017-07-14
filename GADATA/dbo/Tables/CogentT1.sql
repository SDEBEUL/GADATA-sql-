CREATE TABLE [dbo].[CogentT1] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [_timestamp]  DATETIME      NULL,
    [_Value]      INT           NULL,
    [C_timestamp] VARCHAR (64)  NULL,
    [System]      VARCHAR (64)  NULL,
    [LamrBit]     VARCHAR (600) NULL,
    [test1]       INT           NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

