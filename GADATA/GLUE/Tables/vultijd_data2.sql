CREATE TABLE [GLUE].[vultijd_data2] (
    [DateTime]   DATETIME     NOT NULL,
    [controller] VARCHAR (50) NOT NULL,
    [Str1]       INT          NULL,
    [Str2]       INT          NULL,
    [ID]         BIGINT       IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_vultijd_data2] PRIMARY KEY CLUSTERED ([ID] ASC)
);

