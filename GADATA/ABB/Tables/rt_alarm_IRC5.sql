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














GO
CREATE TRIGGER [ABB].[ABB_IRC5_normalize_trigger] ON [GADATA].[ABB].[rt_alarm_IRC5] AFTER INSERT 
AS
IF ((SELECT TRIGGER_NESTLEVEL()) < 3)
BEGIN
 EXEC GADATA.abb.sp_update_L_IRC5
END