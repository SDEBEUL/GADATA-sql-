CREATE TABLE [dbo].[NPT] (
    [ID]      INT        IDENTITY (1, 1) NOT NULL,
    [Name]    NCHAR (15) NULL,
    [OwnerId] INT        NOT NULL,
    CONSTRAINT [PK_NPT] PRIMARY KEY CLUSTERED ([ID] ASC)
);

