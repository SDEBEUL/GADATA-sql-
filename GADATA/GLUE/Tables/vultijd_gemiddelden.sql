CREATE TABLE [GLUE].[vultijd_gemiddelden] (
    [ID]                    INT  IDENTITY (1, 1) NOT NULL,
    [time]                  DATE NOT NULL,
    [Controller_id]         INT  NOT NULL,
    [gemiddelde_vultijd_ms] INT  NOT NULL,
    [couten]                INT  NULL,
    CONSTRAINT [PK_vultijd_gemiddelden] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_vultijd_gemiddelden] FOREIGN KEY ([Controller_id]) REFERENCES [GLUE].[Controller] ([ID])
);

