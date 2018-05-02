CREATE TABLE [dbo].[_ULOGVersion] (
    [Version] INT NULL
);


GO
CREATE NONCLUSTERED INDEX [ULOGVERSION]
    ON [dbo].[_ULOGVersion]([Version] ASC);

