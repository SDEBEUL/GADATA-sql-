CREATE TABLE [NGAC].[L_description] (
    [id]               INT           IDENTITY (1, 1) NOT NULL,
    [Description]      VARCHAR (MAX) NULL,
    [CleanDescription] VARCHAR (MAX) NULL,
    [_timestamp]       DATETIME      NULL,
    [_session]         VARCHAR (50)  NULL,
    CONSTRAINT [PK_L_description] PRIMARY KEY CLUSTERED ([id] ASC)
);




GO


