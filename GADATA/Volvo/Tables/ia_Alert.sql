CREATE TABLE [Volvo].[ia_Alert] (
    [id]               INT            IDENTITY (1, 1) NOT NULL,
    [_timestamp]       DATETIME       NULL,
    [Type]             VARCHAR (10)   NULL,
    [controller_name]  VARCHAR (256)  NULL,
    [reference_id]     INT            NULL,
    [description]      VARCHAR (256)  NULL,
    [Accept_user]      VARCHAR (256)  NULL,
    [Accept_timestamp] DATETIME       NULL,
    [Fix_user]         VARCHAR (256)  NULL,
    [Fix_timestamp]    DATETIME       NULL,
    [Detect_timestamp] DATETIME       NULL,
    [Close_user]       VARCHAR (256)  NULL,
    [Close_timestamp]  DATETIME       NULL,
    [User_Comment]     VARCHAR (2000) NULL,
    [controller_id]    INT            NULL,
    [controller_type]  VARCHAR (5)    NULL,
    [AlertStatus]      INT            NULL,
    CONSTRAINT [PK_ia_Alert] PRIMARY KEY CLUSTERED ([id] ASC)
);

