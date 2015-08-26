CREATE TABLE [C4G].[L_HandMonitor] (
    [id]            INT          IDENTITY (1, 1) NOT NULL,
    [_timestamp]    DATETIME     NULL,
    [Controller_id] INT          NULL,
    [Type]          VARCHAR (25) NULL,
    [Grip]          TINYINT      NULL,
    [Seq]           TINYINT      NULL,
    [Time]          INT          NULL
);

