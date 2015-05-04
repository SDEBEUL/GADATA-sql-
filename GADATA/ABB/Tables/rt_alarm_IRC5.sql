CREATE TABLE [ABB].[rt_alarm_IRC5] (
    [key]        INT            IDENTITY (1, 1) NOT NULL,
    [id]         INT            NULL,
    [_timestamp] DATETIME       NULL,
    [Type]       VARCHAR (4)    NOT NULL,
    [Controller] VARCHAR (25)   NULL,
    [Category]   VARCHAR (25)   NULL,
    [Message]    VARCHAR (500)  NULL,
    [Cause]      VARCHAR (500)  NULL,
    [Remedy]     VARCHAR (500)  NULL,
    [WnFiletime] VARCHAR (30)   NULL,
    [severity]   VARCHAR (8000) NULL,
    [number]     VARCHAR (8000) NULL
);

