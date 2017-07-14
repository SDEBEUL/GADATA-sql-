CREATE TABLE [GLUE].[vultijd_data] (
    [DateTime]   DATETIME     NOT NULL,
    [controller] VARCHAR (50) NOT NULL,
    [Str1]       INT          NULL,
    [Str2]       INT          NULL,
    [Str3]       INT          NULL,
    [ID]         BIGINT       IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_vultijd_data] PRIMARY KEY CLUSTERED ([ID] ASC)
);

