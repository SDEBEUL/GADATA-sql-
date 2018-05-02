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
    [Station]            VARCHAR (255) NULL,
    [Area]               VARCHAR (255) NULL,
    [Team]               VARCHAR (255) NULL,
    [controller_name]    VARCHAR (50)  NULL,
    [controller_type]    VARCHAR (4)   NULL,
    [controller_id]      INT           NULL,
    [controller_ToolID]  BIGINT        NULL
);






GO



GO



GO



GO



GO



GO



GO



GO
CREATE NONCLUSTERED INDEX [nci_asset, equi]
    ON [EqUi].[ASSETS]([controller_type] ASC, [controller_id] ASC, [controller_ToolID] ASC)
    INCLUDE([LOCATION], [LocationTree], [CLassificationId], [ClassificationTree]);


GO
CREATE NONCLUSTERED INDEX [<nci sto assets, sto,>]
    ON [EqUi].[ASSETS]([LOCATION] ASC);


GO
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
    ON [EqUi].[ASSETS]([CLassificationId] ASC)
    INCLUDE([LOCATION], [LocationTree], [ClassificationTree]);

