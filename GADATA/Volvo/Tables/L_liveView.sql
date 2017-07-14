CREATE TABLE [Volvo].[L_liveView] (
    [Location]        VARCHAR (255)  NULL,
    [AssetID]         VARCHAR (255)  NULL,
    [Logtype]         VARCHAR (9)    NOT NULL,
    [timestamp]       DATETIME       NULL,
    [Logcode]         INT            NULL,
    [Severity]        INT            NULL,
    [logtext]         VARCHAR (2106) NULL,
    [Response(s)]     INT            NULL,
    [Downtime(s)]     INT            NULL,
    [Classification]  VARCHAR (50)   NULL,
    [Subgroup]        VARCHAR (50)   NOT NULL,
    [refId]           INT            NULL,
    [LocationTree]    VARCHAR (MAX)  NULL,
    [ClassTree]       VARCHAR (MAX)  NULL,
    [controller_name] VARCHAR (50)   NULL,
    [controller_type] VARCHAR (3)    NOT NULL
);

