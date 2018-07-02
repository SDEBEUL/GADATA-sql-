CREATE TABLE [EqUi].[ASSETS] (
    [id]                        INT           IDENTITY (1, 1) NOT NULL,
    [SYSTEMID]                  VARCHAR (255) NULL,
    [LOCATION]                  VARCHAR (255) NULL,
    [ASSETNUM]                  VARCHAR (255) NULL,
    [AssetDescription]          VARCHAR (255) NULL,
    [LocationTree]              VARCHAR (MAX) NULL,
    [ClassDescription]          VARCHAR (255) NULL,
    [ClassStructureId]          VARCHAR (255) NULL,
    [CLassificationId]          VARCHAR (255) NULL,
    [ClassificationTree]        VARCHAR (MAX) NULL,
    [Station]                   VARCHAR (255) NULL,
    [Area]                      VARCHAR (255) NULL,
    [Team]                      VARCHAR (255) NULL,
    [controller_name]           VARCHAR (50)  NULL,
    [controller_type]           VARCHAR (4)   NULL,
    [controller_id]             INT           NULL,
    [controller_ToolID]         BIGINT        NULL,
    [ResponsibleTechnicianTeam] VARCHAR (50)  NULL,
    [ResponsibleProductionTeam] VARCHAR (50)  NULL,
    CONSTRAINT [PK_ASSETS] PRIMARY KEY CLUSTERED ([id] ASC)
);










GO



GO



GO



GO



GO



GO



GO



GO



GO



GO


