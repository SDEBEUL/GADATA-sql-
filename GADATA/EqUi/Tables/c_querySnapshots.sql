CREATE TABLE [EqUi].[c_querySnapshots] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [name]       VARCHAR (200) NULL,
    [_timestamp] DATETIME      NULL,
    [_user]      VARCHAR (50)  NULL,
    [query]      VARCHAR (MAX) NULL,
    CONSTRAINT [PK_c_querySnapshots] PRIMARY KEY CLUSTERED ([id] ASC)
);

