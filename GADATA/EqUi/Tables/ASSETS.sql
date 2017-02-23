CREATE TABLE [EqUi].[ASSETS] (
    [SYSTEMID]         VARCHAR (255) NULL,
    [LOCATION]         VARCHAR (255) NULL,
    [ASSETNUM]         VARCHAR (255) NULL,
    [AssetDescription] VARCHAR (255) NULL,
    [LocationTree]     VARCHAR (MAX) NULL,
    [controller_name]  VARCHAR (50)  NULL,
    [controller_type]  VARCHAR (32)  NULL,
    [controller_id]    INT           NULL
);

