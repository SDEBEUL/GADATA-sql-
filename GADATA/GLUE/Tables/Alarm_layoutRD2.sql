CREATE TABLE [GLUE].[Alarm_layoutRD2] (
    [location]  VARCHAR (256) NULL,
    [Robotname] VARCHAR (50)  NOT NULL,
    [Type]      VARCHAR (4)   NOT NULL,
    [Errortype] VARCHAR (5)   NOT NULL,
    [Timestamp] DATETIME      NOT NULL,
    [Logcode]   INT           NULL,
    [Severity]  VARCHAR (10)  NULL,
    [Logtekst]  VARCHAR (100) NOT NULL,
    [Downtime]  INT           NULL,
    [Year]      INT           NULL,
    [Week]      INT           NULL,
    [Day]       INT           NULL,
    [Shift]     VARCHAR (2)   NULL,
    [Object]    VARCHAR (3)   NOT NULL,
    [Subgroup]  VARCHAR (3)   NOT NULL,
    [idx]       INT           NULL
);

