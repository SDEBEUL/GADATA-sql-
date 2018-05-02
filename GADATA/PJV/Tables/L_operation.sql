CREATE TABLE [PJV].[L_operation] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [_timestamp]  DATETIME      NULL,
    [code]        INT           NULL,
    [rev_created] INT           NULL,
    [tableName]   VARCHAR (40)  NULL,
    [tableRowId]  INT           NULL,
    [description] VARCHAR (MAX) NULL,
    CONSTRAINT [PK_L_operation] PRIMARY KEY CLUSTERED ([id] ASC)
);

