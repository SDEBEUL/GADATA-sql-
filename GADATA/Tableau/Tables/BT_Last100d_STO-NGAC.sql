CREATE TABLE [Tableau].[BT_Last100d_STO-NGAC] (
    [Location]        VARCHAR (255) NULL,
    [AssetID]         VARCHAR (255) NULL,
    [Logtype]         VARCHAR (15)  NOT NULL,
    [timestamp]       DATETIME      NULL,
    [Logcode]         VARCHAR (MAX) NULL,
    [Severity]        VARCHAR (MAX) NULL,
    [Logtext]         VARCHAR (MAX) NULL,
    [FullLogtext]     VARCHAR (MAX) NULL,
    [Response]        INT           NULL,
    [Downtime]        INT           NULL,
    [Classification]  VARCHAR (255) NULL,
    [Subgroup]        VARCHAR (50)  NOT NULL,
    [Category]        VARCHAR (50)  NULL,
    [refId]           INT           NOT NULL,
    [LocationTree]    VARCHAR (MAX) NULL,
    [ClassTree]       VARCHAR (MAX) NULL,
    [controller_name] VARCHAR (50)  NULL,
    [controller_type] VARCHAR (4)   NOT NULL,
    [station]         VARCHAR (255) NULL,
    [Area]            VARCHAR (255) NULL,
    [Team]            VARCHAR (255) NULL,
    [Asset_x]         INT           NULL,
    [Asset_y]         INT           NULL,
    [Asset_png]       VARCHAR (MAX) NULL,
    [Station_x]       INT           NULL,
    [Station_y]       INT           NULL,
    [Station_png]     VARCHAR (MAX) NULL,
    [Vyear]           INT           NULL,
    [Vweek]           INT           NULL,
    [Vday]            INT           NULL,
    [PLOEG]           VARCHAR (2)   NULL,
    [shift]           VARCHAR (2)   NULL
);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20171212-094549]
    ON [Tableau].[BT_Last100d_STO-NGAC]([timestamp] ASC, [controller_name] ASC, [Vyear] ASC, [Vweek] ASC, [Vday] ASC);

