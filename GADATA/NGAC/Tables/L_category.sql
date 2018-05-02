CREATE TABLE [NGAC].[L_category] (
    [id]         INT           NOT NULL,
    [Category]   VARCHAR (MAX) NULL,
    [_timestamp] DATETIME      NULL,
    [_session]   VARCHAR (50)  NULL,
    CONSTRAINT [PK_L_category] PRIMARY KEY CLUSTERED ([id] ASC)
);

