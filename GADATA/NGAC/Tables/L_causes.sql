CREATE TABLE [NGAC].[L_causes] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [Causes]     VARCHAR (MAX) NULL,
    [_timestamp] DATETIME      NULL,
    [_session]   VARCHAR (50)  NULL,
    CONSTRAINT [PK_L_causes] PRIMARY KEY CLUSTERED ([id] ASC)
);



