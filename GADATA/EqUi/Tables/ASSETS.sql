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
CREATE NONCLUSTERED INDEX [nic_assets_4]
    ON [EqUi].[ASSETS]([controller_type] ASC, [controller_ToolID] ASC);


GO
CREATE NONCLUSTERED INDEX [_dta_index_ASSETS_23_1846922297__K16_K17_K15_K8_K2_5_9]
    ON [EqUi].[ASSETS]([controller_id] ASC, [controller_ToolID] ASC, [controller_type] ASC, [CLassificationId] ASC, [LOCATION] ASC)
    INCLUDE([LocationTree], [ClassificationTree]);


GO
CREATE NONCLUSTERED INDEX [_dta_index_ASSETS_23_1846922297__K15_K17_K8_K2_K16_5_9]
    ON [EqUi].[ASSETS]([controller_type] ASC, [controller_ToolID] ASC, [CLassificationId] ASC, [LOCATION] ASC, [controller_id] ASC)
    INCLUDE([ClassificationTree], [LocationTree]);


GO
CREATE STATISTICS [_dta_stat_1846922297_8_15]
    ON [EqUi].[ASSETS]([CLassificationId], [controller_type]);


GO
CREATE STATISTICS [_dta_stat_1846922297_2_16_17_15]
    ON [EqUi].[ASSETS]([LOCATION], [controller_id], [controller_ToolID], [controller_type]);


GO
CREATE STATISTICS [_dta_stat_1846922297_17_16_15_8]
    ON [EqUi].[ASSETS]([controller_ToolID], [controller_id], [controller_type], [CLassificationId]);


GO
CREATE STATISTICS [_dta_stat_1846922297_17_15_8_2_16]
    ON [EqUi].[ASSETS]([controller_ToolID], [controller_type], [CLassificationId], [LOCATION], [controller_id]);


GO
CREATE STATISTICS [_dta_stat_1846922297_16_15]
    ON [EqUi].[ASSETS]([controller_id], [controller_type]);

