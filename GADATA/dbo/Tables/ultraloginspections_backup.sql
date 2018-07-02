CREATE TABLE [dbo].[ultraloginspections_backup] (
    [ID]                INT        IDENTITY (1, 1) NOT NULL,
    [InspectionPlanID]  INT        NOT NULL,
    [SpotID]            INT        NOT NULL,
    [InspectorComment]  NCHAR (30) NULL,
    [BodyNbr]           INT        NOT NULL,
    [InspectorID]       INT        NOT NULL,
    [InspectionTime]    DATETIME   NOT NULL,
    [IndexOfTestSeq]    INT        NOT NULL,
    [Loose]             BIT        NOT NULL,
    [OK]                BIT        NOT NULL,
    [SmallNugget]       BIT        NOT NULL,
    [StickWeld]         BIT        NOT NULL,
    [BadTroughWeld]     BIT        NOT NULL,
    [StationID]         INT        NOT NULL,
    [MeasuredThickness] FLOAT (53) NULL,
    [MinIdentation]     FLOAT (53) NULL,
    [TotalThickness]    FLOAT (53) NULL,
    [PlanLenght]        INT        NULL
);

