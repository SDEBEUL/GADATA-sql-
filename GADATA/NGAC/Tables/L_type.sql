CREATE TABLE [NGAC].[L_type] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [Type]       VARCHAR (MAX) NULL,
    [_timestamp] DATETIME      NULL,
    [_session]   VARCHAR (50)  NULL,
    CONSTRAINT [PK_L_type] PRIMARY KEY CLUSTERED ([id] ASC)
);



