CREATE TABLE [GLUE].[vultijden_viewers] (
    [ID]            INT      IDENTITY (1, 1) NOT NULL,
    [c_timestamp]   DATETIME NOT NULL,
    [Controller_id] INT      NOT NULL,
    [vultijd_ms]    INT      NOT NULL,
    [couten]        INT      NULL,
    CONSTRAINT [PK_vultijden_viewers] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_vultijden_viewers] FOREIGN KEY ([Controller_id]) REFERENCES [GLUE].[Controller] ([ID])
);

