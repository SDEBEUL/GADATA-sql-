CREATE TABLE [NGAC].[XY_L_actions] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [Actions]    VARCHAR (MAX) NULL,
    [_timestamp] DATETIME      NULL,
    [_session]   VARCHAR (50)  NULL,
    CONSTRAINT [PK_XY_L_actions] PRIMARY KEY CLUSTERED ([id] ASC)
);

