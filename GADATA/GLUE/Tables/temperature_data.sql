CREATE TABLE [GLUE].[temperature_data] (
    [DateTime]   DATETIME     NOT NULL,
    [controller] VARCHAR (50) NOT NULL,
    [Str1]       INT          NULL,
    [Str2]       INT          NULL,
    [Str3]       INT          NULL,
    [Str4]       INT          NULL,
    [ID]         INT          IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_temperature_data] PRIMARY KEY CLUSTERED ([ID] ASC)
);

