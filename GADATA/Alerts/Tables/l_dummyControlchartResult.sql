CREATE TABLE [Alerts].[l_dummyControlchartResult] (
    [id]                 INT           NOT NULL,
    [alarmobject]        VARCHAR (MAX) NOT NULL,
    [timestamp]          DATETIME      NOT NULL,
    [value]              FLOAT (53)    NOT NULL,
    [UpperLimit]         FLOAT (53)    NULL,
    [LowerLimit]         FLOAT (53)    NULL,
    [l_controlLimits_id] INT           NULL,
    [Comment]            VARCHAR (MAX) NULL,
    [CreateDate]         DATETIME      NULL,
    CONSTRAINT [PK_l_dummyControlchartResult] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_l_dummyControlchartResult_l_controlLimits] FOREIGN KEY ([l_controlLimits_id]) REFERENCES [Alerts].[l_controlLimits] ([id])
);

