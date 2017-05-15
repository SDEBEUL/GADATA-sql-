CREATE TABLE [EqUi].[ASSETS] (
    [SYSTEMID]           VARCHAR (255) NULL,
    [LOCATION]           VARCHAR (255) NULL,
    [ASSETNUM]           VARCHAR (255) NULL,
    [AssetDescription]   VARCHAR (255) NULL,
    [LocationTree]       VARCHAR (MAX) NULL,
    [ClassDescription]   VARCHAR (255) NULL,
    [ClassStructureId]   VARCHAR (255) NULL,
    [CLassificationId]   VARCHAR (255) NULL,
    [ClassificationTree] VARCHAR (MAX) NULL,
    [Area]               VARCHAR (255) NULL,
    [SubArea]            VARCHAR (255) NULL,
    [line]               VARCHAR (255) NULL,
    [station]            VARCHAR (255) NULL,
    [controller_name]    VARCHAR (50)  NULL,
    [controller_type]    VARCHAR (32)  NULL,
    [controller_id]      INT           NULL,
    [controller_ToolID]  BIGINT        NULL
);






GO
CREATE NONCLUSTERED INDEX [nci_assetsToolid]
    ON [EqUi].[ASSETS]([controller_type] ASC, [controller_ToolID] ASC);

