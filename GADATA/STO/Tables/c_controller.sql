CREATE TABLE [STO].[c_controller] (
    [id]                        INT           IDENTITY (1, 1) NOT NULL,
    [ALAMRSOURCE]               VARCHAR (50)  NULL,
    [SUBZONENAME]               VARCHAR (50)  NULL,
    [ALARMOBJECT]               VARCHAR (50)  NULL,
    [Location]                  VARCHAR (MAX) NULL,
    [LocationTree]              VARCHAR (MAX) NULL,
    [Assetnum]                  VARCHAR (MAX) NULL,
    [ProductionTeam]            VARCHAR (MAX) NULL,
    [ResponsibleTechnicianTeam] VARCHAR (50)  NULL,
    [ResponsibleProductionTeam] VARCHAR (50)  NULL,
    [ClassificationTree]        VARCHAR (MAX) NULL,
    [CLassificationId]          VARCHAR (MAX) NULL,
    CONSTRAINT [PK_c_controller_2] PRIMARY KEY CLUSTERED ([id] ASC)
);



