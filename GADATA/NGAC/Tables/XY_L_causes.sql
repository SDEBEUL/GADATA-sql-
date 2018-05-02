CREATE TABLE [NGAC].[XY_L_causes] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [Causes]     VARCHAR (MAX) NULL,
    [_timestamp] DATETIME      NULL,
    [_session]   VARCHAR (50)  NULL,
    CONSTRAINT [PK_XY_L_causes] PRIMARY KEY CLUSTERED ([id] ASC)
);

