CREATE TABLE [NGAC].[L_ABBErrors] (
    [id]         INT           NOT NULL,
    [ABBError]   VARCHAR (MAX) NULL,
    [_timestamp] DATETIME      NULL,
    [_session]   VARCHAR (50)  NULL,
    CONSTRAINT [PK_L_ABBErrors] PRIMARY KEY CLUSTERED ([id] ASC)
);

