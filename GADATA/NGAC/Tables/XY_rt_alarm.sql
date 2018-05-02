CREATE TABLE [NGAC].[XY_rt_alarm] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [controller_id]   INT           NULL,
    [_timestamp]      DATETIME      NULL,
    [error_timestamp] DATETIME      NULL,
    [sequenceNumber]  INT           NULL,
    [number]          INT           NULL,
    [categoryId]      INT           NULL,
    [title]           VARCHAR (MAX) NULL,
    [description]     VARCHAR (MAX) NULL,
    [consequences]    VARCHAR (MAX) NULL,
    [causes]          VARCHAR (MAX) NULL,
    [actions]         VARCHAR (MAX) NULL,
    [type]            VARCHAR (MAX) NULL,
    CONSTRAINT [PK_XY_rt_alarm_1] PRIMARY KEY CLUSTERED ([id] ASC)
);

