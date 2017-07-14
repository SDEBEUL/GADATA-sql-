CREATE TABLE [dbo].[NPT] (
    [ID]           INT         IDENTITY (1, 1) NOT NULL,
    [Name]         NCHAR (15)  NULL,
    [OwnerId]      INT         NOT NULL,
    [LoginPass]    NCHAR (15)  NULL,
    [LoginUser]    NCHAR (15)  NULL,
    [RemoreServer] NCHAR (250) NULL,
    CONSTRAINT [PK_NPT] PRIMARY KEY CLUSTERED ([ID] ASC)
);

