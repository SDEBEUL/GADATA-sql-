CREATE TABLE [EqUi].[l_querySnapshots] (
    [id]         INT            IDENTITY (1, 1) NOT NULL,
    [snapshotId] INT            NULL,
    [timestamp]  DATETIME       NULL,
    [htmlresult] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_l_querySnapshots] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_l_querySnapshots_h_querySnapshots] FOREIGN KEY ([snapshotId]) REFERENCES [EqUi].[h_querySnapshots] ([id])
);

