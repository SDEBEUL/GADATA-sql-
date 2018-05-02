CREATE TABLE [NGAC].[XY_L_description] (
    [id]               INT           IDENTITY (1, 1) NOT NULL,
    [Description]      VARCHAR (MAX) NULL,
    [CleanDescription] VARCHAR (MAX) NULL,
    [_timestamp]       DATETIME      NULL,
    [_session]         VARCHAR (50)  NULL,
    CONSTRAINT [PK_XY_L_description] PRIMARY KEY CLUSTERED ([id] ASC)
);

