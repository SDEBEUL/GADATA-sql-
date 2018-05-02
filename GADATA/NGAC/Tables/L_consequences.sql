CREATE TABLE [NGAC].[L_consequences] (
    [id]           INT           IDENTITY (1, 1) NOT NULL,
    [Consequences] VARCHAR (MAX) NULL,
    [_timestamp]   DATETIME      NULL,
    [_session]     VARCHAR (50)  NULL,
    CONSTRAINT [PK_L_consequences] PRIMARY KEY CLUSTERED ([id] ASC)
);



