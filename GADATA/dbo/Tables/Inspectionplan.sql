CREATE TABLE [dbo].[Inspectionplan] (
    [ID]        INT        IDENTITY (1, 1) NOT NULL,
    [CreatorID] INT        NULL,
    [Lenght]    SMALLINT   NULL,
    [Name]      NCHAR (50) NULL,
    [Date]      DATETIME   NULL,
    CONSTRAINT [PK_Inspectionplan] PRIMARY KEY CLUSTERED ([ID] ASC)
);

