CREATE TABLE [GLUE].[education2] (
    [DateTime] DATETIME      NOT NULL,
    [LogType]  INT           NOT NULL,
    [Location] VARCHAR (50)  NOT NULL,
    [Str1]     VARCHAR (250) NULL,
    [Str2]     VARCHAR (250) NULL,
    [Str3]     VARCHAR (250) NULL,
    [Str4]     VARCHAR (250) NULL,
    [Str5]     VARCHAR (250) NULL,
    [Str6]     VARCHAR (250) NULL,
    [Str7]     VARCHAR (250) NULL,
    [Str8]     VARCHAR (250) NULL,
    [Str9]     VARCHAR (250) NULL,
    [Str10]    VARCHAR (250) NULL,
    [ID]       INT           IDENTITY (1, 1) NOT NULL
);

