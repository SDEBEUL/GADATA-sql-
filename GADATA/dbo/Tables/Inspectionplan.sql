CREATE TABLE [dbo].[Inspectionplan] (
    [ID]           INT        IDENTITY (1, 1) NOT NULL,
    [CreatorID]    INT        NULL,
    [Lenght]       SMALLINT   NULL,
    [Name]         NCHAR (50) NULL,
    [Date]         DATETIME   NULL,
    [PlanActive]   BIT        NULL,
    [SpotIdent]    INT        NULL,
    [WorkTime]     TIME (7)   NULL,
    [WorkGroup]    INT        NULL,
    [WorkLocation] NCHAR (50) NULL,
    CONSTRAINT [PK_Inspectionplan] PRIMARY KEY CLUSTERED ([ID] ASC)
);



