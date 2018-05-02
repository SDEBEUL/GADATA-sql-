CREATE TABLE [PJV].[JoiningModelVariantDistinct] (
    [id]                    INT           IDENTITY (1, 1) NOT NULL,
    [joiningModelVariantId] INT           NULL,
    [_timestamp]            DATETIME      NULL,
    [_lasttimestamp]        DATETIME      NULL,
    [name]                  VARCHAR (MAX) NULL,
    [isDead]                INT           NULL,
    [rev_created]           INT           NULL,
    [rev_modified]          INT           NULL,
    CONSTRAINT [PK_JoiningModelVariantDistinct] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_JoiningModelVariantDistinct_JoiningModelVariant] FOREIGN KEY ([joiningModelVariantId]) REFERENCES [PJV].[JoiningModelVariant] ([id])
);

