CREATE TABLE [GLUE].[vultijden_viewers] (
    [ID]            BIGINT   IDENTITY (1, 1) NOT NULL,
    [c_timestamp]   DATETIME NOT NULL,
    [Controller_id] INT      NOT NULL,
    [vultijd_ms]    INT      NOT NULL,
    [couten]        BIGINT   NULL,
    CONSTRAINT [PK_vultijden_viewers] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_vultijden_viewers] FOREIGN KEY ([Controller_id]) REFERENCES [GLUE].[Controller] ([ID])
);


GO
CREATE NONCLUSTERED INDEX [nci_glueVultijden]
    ON [GLUE].[vultijden_viewers]([vultijd_ms] ASC, [couten] ASC)
    INCLUDE([c_timestamp], [Controller_id]);

