CREATE TABLE [EqUi].[h_querySnapshots] (
    [id]        INT      IDENTITY (1, 1) NOT NULL,
    [queryId]   INT      NULL,
    [timestamp] DATETIME NULL,
    [Hangfire]  BIT      NULL,
    CONSTRAINT [PK_querySnapshots] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_h_querySnapshots_c_querySnapshots] FOREIGN KEY ([queryId]) REFERENCES [EqUi].[c_querySnapshots] ([id])
);

