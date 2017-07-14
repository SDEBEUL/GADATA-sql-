CREATE TABLE [GLUE].[vultijden] (
    [ID]            INT      IDENTITY (1, 1) NOT NULL,
    [c_timestamp]   DATETIME NOT NULL,
    [Controller_id] INT      NOT NULL,
    [vultijd_ms]    INT      NOT NULL,
    CONSTRAINT [PK_vultijden] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_vultijden] FOREIGN KEY ([Controller_id]) REFERENCES [GLUE].[Controller] ([ID]),
    CONSTRAINT [FK_vultijden2] FOREIGN KEY ([Controller_id]) REFERENCES [GLUE].[Controller] ([ID])
);

