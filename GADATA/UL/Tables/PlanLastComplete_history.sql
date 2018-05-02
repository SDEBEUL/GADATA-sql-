CREATE TABLE [UL].[PlanLastComplete_history] (
    [UpdateTime]         DATETIME   NOT NULL,
    [LastInspectionTime] DATETIME   NULL,
    [UL plan]            NCHAR (50) NULL,
    [BuildBody's]        INT        NULL,
    [WorkGroup]          INT        NULL,
    [WorkLocation]       NCHAR (50) NULL
);

