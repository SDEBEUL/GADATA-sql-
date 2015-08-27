CREATE TABLE [Volvo].[L_liveView] (
    [Location]  VARCHAR (256) NULL,
    [Robot]     VARCHAR (50)  NULL,
    [Type]      VARCHAR (32)  NULL,
    [Errortype] VARCHAR (4)   NOT NULL,
    [Timestamp] CHAR (19)     NULL,
    [Logcode]   INT           NULL,
    [Severity]  INT           NOT NULL,
    [Logtekst]  VARCHAR (301) NULL,
    [DT]        INT           NULL,
    [Year]      INT           NULL,
    [Week]      INT           NULL,
    [day]       INT           NULL,
    [Shift]     INT           NULL,
    [Object]    VARCHAR (2)   NULL,
    [Subgroup]  VARCHAR (2)   NULL,
    [id]        INT           NULL
);

