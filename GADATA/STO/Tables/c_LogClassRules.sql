CREATE TABLE [STO].[c_LogClassRules] (
    [id]                 INT           IDENTITY (1, 1) NOT NULL,
    [Err_start]          INT           NULL,
    [Err_end]            INT           NULL,
    [Err_text]           VARCHAR (255) NULL,
    [I_comment]          VARCHAR (255) NULL,
    [c_ClassificationId] INT           NULL,
    [c_SubgroupId]       INT           NULL
);

